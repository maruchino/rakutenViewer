#import "CalorieViewController.h"
#import "AppDelegate.h"
#import "TakeViewController.h"

@interface CalorieViewController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic) NSArray *menu;
@property(nonatomic) NSArray *calorie;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation CalorieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //検索機能をDelegate
    _searchBar.delegate = self;
    
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    NSBundle *bundle = [NSBundle mainBundle];
    
    //読み込むプロバティリストのファイルパス（場所)を指定
    NSString *path = [bundle pathForResource:@"Calorie" ofType:@"plist"];
    
    //プロバティリストの中身のデータを取得
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _dict = dic[@"Main"];
    
    //メンバー変数にデータをアサイン
    self.menu = _dict.allKeys;
    self.calorie = _dict.allValues;
    
    }
    
    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

#pragma mark - テーブルビュー

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
    }
    
    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
        //タイトル変数の初期化
        NSString *title;
        title = @"メニュー";
        return title;
        }
        
        //検索機能の記述もあるよ
        - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
            NSInteger dataCount;
            
            if (tableView == self.searchDisplayController.searchResultsTableView) {
                dataCount = self.dataSource.count;
            }else{
                dataCount = self.menu.count;
            }
            return dataCount;
}

//検索機能の記述もあるよ
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"Cell";
    
    //セルを準備する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _menu[indexPath.row];
    
    // ここのsearchDisplayControllerはStoryboardで紐付けされたsearchBarに自動で紐づけられています
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        // 検索中の暗転された状態のテーブルビューはこちらで処理
        cell.textLabel.text = self.dataSource[indexPath.row];
    } else {
        //検索してない状態のテーブルビューはこちらで処理
        cell.textLabel.text = self.menu[indexPath.row];
    }
    return cell;
}

#pragma mark - セルおしたあとの記述

//didSelectは暗転状態でも、効くので、ifで条件分岐することと、コードで遷移する記述を書く！
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self.navigationController pushViewController:TakeViewController animated:YES];
    //毎回Appdelegateを呼び起こす時に使う
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    ap.foodStr = _menu[indexPath.row];
    ap.caloInt = _calorie[indexPath.row];
    
    TakeViewController *takeView = [self.storyboard instantiateViewControllerWithIdentifier:@"take_view"];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        // 検索中の暗転された状態のテーブルビューはこちらで処理
        takeView.title = self.dataSource[indexPath.row];
        ap.foodStr = _dataSource[indexPath.row];
        ap.caloInt = _dict[self.dataSource[indexPath.row]];
        
    } else {
        //検索してない状態のテーブルビューはこちらで処理
        takeView.title = self.menu[indexPath.row];
    }
    
    [self.navigationController pushViewController:takeView animated:YES];
}

#pragma mark - 検索機能

//ここから検索機能についてです
- (void)filterContainsWithSearchText:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    NSLog(@"predicate = %@", searchText);
    
    self.dataSource = [self.menu filteredArrayUsingPredicate:predicate];
    }
    
    - (BOOL)searchDisplayController:controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // 検索バーに入力された文字列を引数に、絞り込みをかけます
    [self filterContainsWithSearchText:searchString];
    return YES;
}

@end