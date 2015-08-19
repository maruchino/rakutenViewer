//
//  IB Outlet.h
//  rakutenViewer
//
//  Created by  intern on 2015/08/19.
//  Copyright (c) 2015年 sonicmoov. All rights reserved.
//
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@interface ViewController : UIViewController<UISearchBarDelegate>
_searchBar.delegate = self;
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    // 検索処理
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if( [searchText length] != 0 )
    {
        // インクリメンタル検索
    }
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    // ブックマークの処理
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    // サーチキャンセル
}

