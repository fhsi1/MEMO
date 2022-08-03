//
//  DetailViewController.h
//  Memo
//
//  Created by Yujean Cho on 2022/08/02.
//

#import <UIKit/UIKit.h>
#import "Model/Memo.h"
#import "Memo+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

// 목록 화면에서 전달되는 memo 저장
@property (strong, nonatomic) Memo* memo;

@end

NS_ASSUME_NONNULL_END
