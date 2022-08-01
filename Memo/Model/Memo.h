//
//  Memo.h
//  Memo
//
//  Created by Yujean Cho on 2022/08/01.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Memo : NSObject

@property (strong, nonatomic) NSString* content; // 내용
@property (strong, nonatomic) NSDate* insertDate; // 날짜

// 생성자를 생성하고 dummy data 를 return 하는 팩토리 메서드
- (instancetype)initWithContent:(NSString*)content;

+ (NSArray*)dummyMemoList;

@end

NS_ASSUME_NONNULL_END
