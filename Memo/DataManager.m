//
//  DataManager.m
//  Memo
//
//  Created by Yujean Cho on 2022/08/02.
//

#import "DataManager.h"

@implementation DataManager

// factory method
// 앱 전체에서 하나의 instance 를 공유할 수 있다.
+ (instancetype)sharedInstance {
    static DataManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
        sharedInstance.memoList = [[NSMutableArray alloc] init];
    });
    
    return sharedInstance;
}

- (void)fetchMemo {
    // fetch request
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Memo"];
    
    // data 는 정렬되어 있지 않다. sort descriptor 를 구현하여 직접 정렬해야 한다.
    NSSortDescriptor* sortByDateDesc = [NSSortDescriptor sortDescriptorWithKey:@"insertDate" ascending:NO];
    
    request.sortDescriptors = @[sortByDateDesc];
    
    NSError* error = nil;
    
    // fetchRequest 실행
    NSArray* result = [self.mainContext executeFetchRequest:request error:&error];
    
    // 최종 결과 memoList 에 저장
    [self.memoList setArray:result];
}

// custom getter
- (NSManagedObjectContext*)mainContext {
    return self.persistentContainer.viewContext;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Memo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


@end
