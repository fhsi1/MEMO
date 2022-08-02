//
//  Memo.m
//  Memo
//
//  Created by Yujean Cho on 2022/08/01.
//

#import "Memo.h"

@implementation Memo

// storage
static NSMutableArray* _dummyMemoList = nil;
- (instancetype)initWithContent:(NSString*)content {
    self = [super init];
    if (self != nil) {
        _content = content;
        _insertDate = [NSDate date];
    }
    return self;
}

+ (NSMutableArray*)dummyMemoList {
    // lazy loading pattern
    if (_dummyMemoList == nil) {
        Memo* memo1 = [[Memo alloc] initWithContent:@"Lorem Ipsum 111"];
        Memo* memo2 = [[Memo alloc] initWithContent:@"Lorem Ipsum 222"];
        
        _dummyMemoList = [NSMutableArray arrayWithObjects:memo1, memo2, nil];
    }
    return _dummyMemoList;
}

@end
