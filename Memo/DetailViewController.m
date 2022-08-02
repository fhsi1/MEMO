//
//  DetailViewController.m
//  Memo
//
//  Created by Yujean Cho on 2022/08/02.
//
  
#import "DetailViewController.h"
#import "ComposeViewController.h"
#import "DataManager.h"

@interface DetailViewController () <UITableViewDataSource>

@property (strong, nonatomic) NSDateFormatter* formatter;

@property (weak, nonatomic) IBOutlet UITableView *memoTableView;

- (IBAction)deleteMemo:(id)sender;

@end

@implementation DetailViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"memoCell" forIndexPath:indexPath];
        
        cell.textLabel.text = self.memo.content;
        return cell;
    } else if (indexPath.row == 1) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"dateCell" forIndexPath:indexPath];
        
        cell.textLabel.text = [self.formatter stringFromDate:self.memo.insertDate];
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // NavigationController 의 childViewController 중 0번째 index에 해당
    ComposeViewController* vc = [[segue.destinationViewController childViewControllers] objectAtIndex:0];
    
    // editTarget 속성에 메모 전달
    vc.editTarget = self.memo;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.memoTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // formatter init
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateStyle = NSDateFormatterLongStyle;
    self.formatter.timeStyle = NSDateFormatterMediumStyle; // 시간표시 x
    self.formatter.locale = [NSLocale localeWithLocaleIdentifier:@"Ko_kr"];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)deleteMemo:(id)sender {
    // UIAlert Instance 생성
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirm deletion" message:@"Are you sure you want to delete the memo?" preferredStyle:UIAlertControllerStyleAlert];
    
    // 경고창에 버튼 추가
    // 먼저 액션을 만들고 AlertController 에 추가한다.
    // 어떤 버튼을 선택하여도 경고창은 사라지기 때문에, 사라지는 코드는 구현하지 않아도 된다.
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[DataManager sharedInstance] deleteMemo:self.memo];
        
        // navigationController 에 접근하여 현재 화면을 pop 해준다.
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alert addAction:okAction];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancelAction];
    
    // 경고창 화면에 표시
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
