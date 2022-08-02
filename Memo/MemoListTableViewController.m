//
//  MemoListTableViewController.m
//  Memo
//
//  Created by Yujean Cho on 2022/08/01.
//

#import "MemoListTableViewController.h"
#import "Model/Memo.h"
#import "DetailViewController.h"
#import "DataManager.h"

@interface MemoListTableViewController ()

@property (strong, nonatomic) NSDateFormatter* formatter;

@end

@implementation MemoListTableViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 선택한 cell 의 row 얻기
    NSIndexPath* indexPath = [self.tableView indexPathForCell:(UITableViewCell*)sender];
    if (indexPath != nil) {
        Memo* target = [[[DataManager sharedInstance] memoList] objectAtIndex:indexPath.row];
        
        // segueway 로 접근할 scene 에 접근할 수 있다. - DetailView
        DetailViewController* vc = (DetailViewController*)segue.destinationViewController;
        vc.memo = target;
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[DataManager sharedInstance] fetchMemo];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // formatter init
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateStyle = NSDateFormatterLongStyle;
    self.formatter.timeStyle = NSDateFormatterNoStyle; // 시간표시 x
    self.formatter.locale = [NSLocale localeWithLocaleIdentifier:@"Ko_kr"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DataManager sharedInstance] memoList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // 메모, 날짜 출력 구현
    Memo* target = [[[DataManager sharedInstance] memoList] objectAtIndex:indexPath.row];
    cell.textLabel.text = target.content;
    cell.detailTextLabel.text = [self.formatter stringFromDate:target.insertDate];
    
    
    return cell;
}


// 편집 기능 활성화
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// 편집 스타일 지정
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 삭제 스타일
    return UITableViewCellEditingStyleDelete;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // tableView 에서 Cell 을 삭제
    // 위의 UITableViewCellEditingStyleDelete 가 리턴되면 if 문 실행
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        Memo* target = [[DataManager sharedInstance] memoList][indexPath.row];
        
        // Database 에서 메모를 삭제
        [[DataManager sharedInstance] deleteMemo:target];
        
        // 배열에서 데이터 삭제
        [[[DataManager sharedInstance] memoList] removeObjectAtIndex:indexPath.row];
        
        // tableView 에서 cell 을 삭제
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
