//
//  ComposeViewController.m
//  Memo
//
//  Created by Yujean Cho on 2022/08/02.
//

#import "ComposeViewController.h"
#import "Model/Memo.h"
#import "DataManager.h"

@interface ComposeViewController ()

- (IBAction)close:(id)sender;
- (IBAction)save:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *memoTextView;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 전달된 메모가 있는지 확인
    if (self.editTarget != nil) {
        self.navigationItem.title = @"Edit";
        self.memoTextView.text = self.editTarget.content;
    } else {
        self.navigationItem.title = @"New MEMO";
        self.memoTextView.text = @"";
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    
    NSString* memo = self.memoTextView.text;
    
    [[DataManager sharedInstance] addNewMemo:memo];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
