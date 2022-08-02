//
//  DataManager.h
//  Memo
//
//  Created by Yujean Cho on 2022/08/02.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

// 아래의 두 멤버를 통해서 CoreData 사용
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

// singleton class 로 구현
+ (instancetype)sharedInstance;

@property (readonly, strong) NSManagedObjectContext* mainContext;

// 메모를 저장할 배열
@property (strong, nonatomic) NSMutableArray* memoList;

// Data 읽어오는 메서드
- (void)fetchMemo;


@end

NS_ASSUME_NONNULL_END
