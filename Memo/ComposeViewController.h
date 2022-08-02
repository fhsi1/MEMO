//
//  ComposeViewController.h
//  Memo
//
//  Created by Yujean Cho on 2022/08/02.
//

#import <UIKit/UIKit.h>
#import "Memo+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController

// 수정할 메모 전달받아 해당 속성에 저장
@property (strong, nonatomic) Memo* editTarget;

@end

NS_ASSUME_NONNULL_END
