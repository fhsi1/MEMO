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

// 토큰 저장 속성
// Notification Observer 를 해제할 때 사용
@property (strong, nonatomic) id willShowToken;
@property (strong, nonatomic) id willHideToken;

@end

@implementation ComposeViewController

// 소멸자
// Notification Observer 해제
- (void) dealloc {
    if (self.willShowToken) {
        [[NSNotificationCenter defaultCenter] removeObserver:self.willShowToken];
    }
    
    if (self.willHideToken) {
        [[NSNotificationCenter defaultCenter] removeObserver:self.willHideToken];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // textView 가 선택되고 키보드가 자동으로 표시
    [self.memoTextView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 입력 포커스 제거, 키보드가 사라진다.
    [self.memoTextView resignFirstResponder];
}

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
    
    // observer 등록
    // keyboard 가 표시되기 전에 전달되는 Notification 처리
    self.willShowToken = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        // keyboard 가 표시되기 전에 키보드 높이만큼 아래쪽에 여백을 추가
        // keyboard 높이는 실행환경에 따라 달라질 수 있기 때문에 고정값 x
        // Notification 객체에 접근하여 높이 값을 가져온다.
        CGFloat height = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        
        // textView 의 여백은 contentInset 속성으로 설정
        // 현재 설정 값 저장 후 bottom 속성을 keyboard 높이로 변경
        // bottom 을 제외한 나머지 inset 속성 유지
        UIEdgeInsets inset = self.memoTextView.contentInset;
        inset.bottom = height;
        self.memoTextView.contentInset = inset;
        
        // textView 오른쪽 ScrollBar 에도 동일한 여백 적용
        inset = self.memoTextView.scrollIndicatorInsets;
        inset.bottom = height;
        self.memoTextView.scrollIndicatorInsets = inset;
    }];
    
    // keyboard 가 사라지기 전에 전달되는 Notification 처리
    self.willHideToken = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
       
        UIEdgeInsets inset = self.memoTextView.contentInset;
        inset.bottom = 0;
        self.memoTextView.contentInset = inset;
        
        inset = self.memoTextView.scrollIndicatorInsets;
        inset.bottom = 0;
        self.memoTextView.contentInset = inset;
    }];
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
    
    if (self.editTarget != nil) {
        self.editTarget.content = memo;
        [[DataManager sharedInstance] saveContext];
    } else {
        [[DataManager sharedInstance] addNewMemo:memo];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
