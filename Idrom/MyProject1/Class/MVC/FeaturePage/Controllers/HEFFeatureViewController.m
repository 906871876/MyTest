//
//  HEFFeatureViewController.m
//  MyProject1
//
//  Created by 成都千锋 on 15/12/2.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFFeatureViewController.h"
#import "HEFShowViewController.h"
#import "HEFControl.h"
#import <MJRefresh.h>


@interface HEFFeatureViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HEFFeatureViewController

- (NSMutableArray *)dataArray{

    if (_dataArray == nil) {
        _dataArray = @[].mutableCopy;
    }

    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏夹";
    
    self.navigationItem.leftBarButtonItem = BARBUTTON(@"编辑", @selector(gotoEdit:));
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"删除", @selector(deleteSelectedRows:));
    [self fetchAllCollections];
    
}

- (void)fetchAllCollections
{
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.myTableView.allowsMultipleSelectionDuringEditing = YES;
    
    self.myTableView.dataSource =self;
    self.myTableView.delegate =self;
    
    [self loadData];
    [self.view addSubview:self.myTableView];
    NSInteger count = [[HEFDBManager manager] queryModels].count;
    //1.添加下拉刷新
    
    __weak typeof(self) weakSelf = self;
    // 将自己变成弱引用对象，防止造成循环引用的错误
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        if (self.dataArray.count !=  count) {
            [weakSelf loadData];
        }else{
            [self.myTableView.mj_header endRefreshing];
        }
        
        
    }];
    
    self.myTableView.mj_header = header;

}
- (void) loadData{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dataArray addObjectsFromArray:[[HEFDBManager manager] queryModels]];
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];

    });
    
    
    

}

- (void) deleteSelectedRows:(UIBarButtonItem *) sender {
    if (self.myTableView.isEditing) {
        // NSIndexPath对象的数组
        NSArray *indexPaths = self.myTableView.indexPathsForSelectedRows;
        
        for (NSIndexPath *indexPath in indexPaths) {
            HEFDBModel *model = self.dataArray[indexPath.row];
          //  [self.myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            BOOL isSuc = [[HEFDBManager manager] deleteModel:model];
            if (isSuc) {
                [self.dataArray removeObject:model];
                [self.myTableView reloadData];
            }else{
            
            }
        }
    }

}
- (void) gotoEdit:(UIBarButtonItem *) sender {
    if ([self.myTableView isEditing]) {
        [self.myTableView setEditing:NO animated:YES];
        [sender setTitle:@"编辑"];
    }
    else {
        [self.myTableView setEditing:YES animated:YES];
        [sender setTitle:@"完成"];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    HEFDBModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self.myTableView isEditing]) {
        HEFDBModel *model = self.dataArray[indexPath.row];
        NSString *idromStr = model.name;
        HEFShowViewController *showVC = [[HEFShowViewController alloc] init];
        showVC.idromName = idromStr;
        [self.navigationController pushViewController:showVC animated:YES];
    }
    
}
@end
