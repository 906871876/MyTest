//
//  HEFSearchViewController.m
//  MyProject1
//
//  Created by 成都千锋 on 15/12/2.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFSearchViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "HEFSearchModel.h"
#import "HEFShowViewController.h"

#define Bar_Height 35 //mysearchbar & seg 的高度
#define Bar_Color TAB_COLOR(189, 189, 200, 1)
#define Bar_smallGap 5 //最小间隙
#define Bar_bigGap 10 //较大间隙
@interface HEFSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UINavigationBarDelegate>{
    
    UITableView *myTableView;
    NSMutableArray *dataArray;
    UISearchBar *mySearchBar;
    UIView *segView;
    UIView *searchBarView;
    UISegmentedControl *seg;
    NSMutableArray *currentArray;
    NSInteger index;
    NSString *idromString;
}

@end

@implementation HEFSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"查询";
    index = 0;
    mySearchBar = [[UISearchBar alloc] init];
    mySearchBar.frame = CGRectMake(0, 64 - Bar_Height, WIDTH, Bar_Height);
    mySearchBar.barTintColor = Bar_Color;
    mySearchBar.showsCancelButton = NO;
    mySearchBar.searchBarStyle = UISearchBarStyleDefault;
    mySearchBar.delegate = self;
    mySearchBar.placeholder = @"请输入关键字开始搜索";
    searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, Bar_Height, WIDTH, 64)];
    searchBarView.backgroundColor = Bar_Color;
    [searchBarView addSubview:mySearchBar];
    
    segView = [[UIView alloc] initWithFrame:CGRectMake(0, Bar_Height + 18, WIDTH, Bar_Height + Bar_smallGap)];
    segView.backgroundColor = Bar_Color;
    NSArray *nameArray = @[@"模糊查找",@"第一字",@"第二字",@"第三字",@"第四字"];
    seg = [[UISegmentedControl alloc] initWithItems:nameArray];
    seg.selectedSegmentIndex = index;
    seg.frame = CGRectMake(Bar_bigGap, Bar_smallGap,WIDTH - Bar_bigGap *2, 30);
    [seg addTarget:self action:@selector(changeIdromOrder:) forControlEvents:UIControlEventValueChanged];
    [segView addSubview:seg];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Bar_Height, WIDTH, HEIGHT) style:UITableViewStylePlain];
    
    myTableView.delegate = self;
    myTableView.dataSource = self;

    [self.view addSubview:myTableView];
    [self.view addSubview:searchBarView];
    
}
- (void) changeIdromOrder:(UISegmentedControl *)sender{
    
    index = sender.selectedSegmentIndex;
    
}


#pragma mark --- UISearchBarDelegate ---
//点击搜索按钮的回调方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    [searchBar resignFirstResponder];
    [self loadDataModel];
   // [self loadDataModelTest];
}
//即将开始编辑的回调方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    if (searchBarView.frame.origin.y == Bar_Height ) {
        [UIView animateWithDuration:0.05 animations:^{
            self.navigationController.navigationBarHidden = YES;
            searchBar.showsCancelButton = YES;
            CGFloat searchY =  searchBarView.frame.origin.y;
            searchY -= Bar_Height + Bar_bigGap;
            searchBarView.frame = CGRectMake(0, searchY, WIDTH, 64);
            
            CGFloat tableY =  myTableView.frame.origin.y;
            tableY += Bar_Height;
            myTableView.frame = CGRectMake(0, tableY, WIDTH, HEIGHT - tableY);
            [self.view addSubview:segView];
        }];
    }
    return YES;
    
}
//点击取消按钮的回调方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.5 animations:^{
        searchBar.showsCancelButton = NO;
        self.navigationController.navigationBarHidden = NO;
        CGFloat searchY =  searchBarView.frame.origin.y;
        searchY += Bar_Height + Bar_bigGap;
        searchBarView.frame = CGRectMake(0, searchY, WIDTH, 64);
        
        CGFloat tableY =  myTableView.frame.origin.y;
        tableY -= Bar_Height;
        myTableView.frame = CGRectMake(0, tableY, WIDTH, HEIGHT - tableY);
        
        mySearchBar.text = @"";
        [segView  removeFromSuperview];
        [currentArray removeAllObjects];
        [myTableView reloadData];
    }];

    [searchBar resignFirstResponder];
}


//加载数据
- (void) loadDataModel{
    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }
    
    [SVProgressHUD showWithStatus:@"正在加载，请稍后……"];

    NSString *nameStr = mySearchBar.text;
    
    nameStr = [nameStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *keyStr = @"0d70b0baf0a7b7e0";
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.jisuapi.com/chengyu/search?appkey=%@&keyword=%@",keyStr,nameStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/xml", @"application/json", nil];
    
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        
        
        [SVProgressHUD dismiss];
        
        NSDictionary *tempDict = responseObject[@"result"];
        for (NSDictionary *dict in tempDict) {
            HEFSearchModel *model = [[HEFSearchModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [dataArray addObject:model.name];
        }
        
        [self chooseIdromFromDataArray:dataArray];
        [myTableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

- (void) loadDataModelTest{
    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }
    NSArray *testArray = @[@"跃然纸上",@"脸青鼻肿",@"问道于盲",@"取民愈广",@"裙带关系",@"久居人下",@"大张声势",@"归邪转曜",@"双宿双飞"];
    [dataArray addObjectsFromArray:testArray];
    [self chooseIdromFromDataArray:dataArray];
    [myTableView reloadData];

}

- (void) chooseIdromFromDataArray:(NSMutableArray *)dataArr{
    if (!currentArray) {
        currentArray = [NSMutableArray array];
    }else{
        [currentArray removeAllObjects];
    }
    
    
    if (index == 0) {
        currentArray = dataArr;
        
    }
    if (index == 1) {

        for (NSString *idromStr in dataArr) {
            
            NSRange range = {0,1};
            NSString *tempStr = [idromStr substringWithRange:range];
            
            if ([tempStr isEqualToString:mySearchBar.text]) {
                [currentArray addObject:idromStr];
            }
        }
        
    }
    if (index == 2) {
        for (NSString *idromStr in dataArr) {
            NSRange range = {1,1};
            NSString *tempStr = [idromStr substringWithRange:range];
            if ([tempStr isEqualToString:mySearchBar.text]) {
                [currentArray addObject:idromStr];
            }
        }
        
    }
    if (index == 3) {
        for (NSString *idromStr in dataArr) {
            NSRange range = {2,1};
            NSString *tempStr = [idromStr substringWithRange:range];
            if ([tempStr isEqualToString:mySearchBar.text]) {
                [currentArray addObject:idromStr];
            }
        }
        
    }
    if (index == 4) {
        for (NSString *idromStr in dataArr) {
            NSRange range = {3,1};
            NSString *tempStr = [idromStr substringWithRange:range];
            if ([tempStr isEqualToString:mySearchBar.text]) {
                [currentArray addObject:idromStr];
            }
        }
        
    }
    [myTableView reloadData];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return currentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    static NSString *cellIdentifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = currentArray[indexPath.row];
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.navigationController.navigationBarHidden = NO;
    
    
    
    idromString = dataArray[indexPath.row];
    
    HEFShowViewController *ShowVC = [[HEFShowViewController alloc] init];
    
    ShowVC.idromName = idromString;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = FB_Frame;
    [button setTitle:@"收藏" forState:UIControlStateNormal];
    [button setTitle:@"取消收藏" forState:UIControlStateSelected];
    [button setTitleColor:Text_Color forState:UIControlStateNormal];
    [button setTitleColor:Text_Color forState:UIControlStateSelected];
    [button addTarget:self action:@selector(collectionBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    ShowVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    HEFDBModel *dbModel = [[HEFDBModel alloc] init];
    dbModel.name = idromString;
    
    BOOL isCollected = [[HEFDBManager manager] isModelExists:dbModel];
    button.selected = isCollected;
    
    [self.navigationController pushViewController:ShowVC animated:YES];


}

- (void) collectionBtnPressed:(UIButton *) sender{
    
    HEFDBModel *model = [HEFDBModel new];
    model.name = idromString;
  
    MBProgressHUDManager *hudMgr = [[MBProgressHUDManager alloc] initWithView:self.view];

    if (sender.selected) {

        BOOL isCancelSuc = [[HEFDBManager manager] deleteModel:model];
        if (isCancelSuc) {
            [hudMgr showNoticeMessage:@"取消收藏成功" duration:2.f complection:^{
                
            }];
            sender.selected = NO;
        }else {
            [hudMgr showNoticeMessage:@"取消收藏失败" duration:2.f complection:^{
                
            }];
        }
        
    }else {
        BOOL isSuc = [[HEFDBManager manager] insertModel:model];
        
        if (isSuc) {
            
            [hudMgr showMessage:@"收藏成功" duration:1.f];
            
            sender.selected = YES;
            
        }else {
            [hudMgr showDetailMessage:@"收藏失败" duration:2.f complection:^{
                
            }];
        }
        
    }

}




@end
