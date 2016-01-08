//
//  HEFIdromViewController.m
//  MyProject1
//
//  Created by 成都千锋 on 15/12/5.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFIdromViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "HEFSearchModel.h"
#import "HEFShowViewController.h"
#import <Masonry.h>
#import "HEFRandomIdiom.h"

#ifndef W_H_
#define W_H_
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
#endif

@interface HEFIdromViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *myTableView;
    NSMutableArray *dataArray;
    NSString *idromString;
    NSArray *classifyArray;
}

@property (nonatomic, strong) UIView *loadingMask;


@end

@implementation HEFIdromViewController

- (UIView *)loadingMask
{
    if (_loadingMask == nil) {
        _loadingMask = [[UIView alloc] init];
        [self.view addSubview:_loadingMask];
        [_loadingMask mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            
        }];
        
        _loadingMask.backgroundColor = [UIColor whiteColor];
        
    }
    return _loadingMask;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.describeStr;
    self.navigationItem.rightBarButtonItem.title = @"摇一摇";
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor whiteColor];
    myTableView.dataSource =self;
    myTableView.delegate = self;
    
    [self loadDataModel];
    [self.view addSubview:myTableView];
    
    
    
}



- (void) loadDataModel{
    
    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }
    classifyArray = @[@"带数字的成语",
                      @"带叠字的成语",
                      @"含有一对反义词的成语",
                      @"含有两对反义词的成语",
                      @"含有两对近义词的成语",
                      @"描写动物的成语",
                      @"描写植物的成语",
                      @"描写人体名称的成语",
                      @"描写方位名称的成语",
                      @"描写四季的成语",
                      @"隔字相同的成语",
                      @"其他成语"];
    
    
    if ([_describeStr isEqualToString:classifyArray[0]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnNumberIdiom]];
    }
    if ([_describeStr isEqualToString:classifyArray[1]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnReiterativeLocutionIdiom]];
        
    }
    if ([_describeStr isEqualToString:classifyArray[2]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnOneAntonymsIdiom]];
        
    }
    if ([_describeStr isEqualToString:classifyArray[3]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnTwoAntonymsIdiom]];
        
    }
    if ([_describeStr isEqualToString:classifyArray[4]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnTwoSynonymsIdrom]];
        
    }
    if ([_describeStr isEqualToString:classifyArray[5]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnAnimalIdiom]];
    }
    if ([_describeStr isEqualToString:classifyArray[6]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnPlantIdiom]];
        
    }
    if ([_describeStr isEqualToString:classifyArray[7]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnHumanBodyIdiom]];
        
    }
    if ([_describeStr isEqualToString:classifyArray[8]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnLocationIdiom]];
        
    }
    if ([_describeStr isEqualToString:classifyArray[9]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnFourSeasonsIdiom]];
        
    }
    if ([_describeStr isEqualToString:classifyArray[10]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnSameWordsIdiom]];
        
    }
    if ([_describeStr isEqualToString:classifyArray[11]]) {
        
        [dataArray addObjectsFromArray:(NSArray *)[HEFRandomIdiom returnOtherIdiom]];
        
    }
    
    [myTableView reloadData];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return dataArray.count;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    cell.textLabel.text = dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    idromString = dataArray[indexPath.row];
    
    HEFShowViewController *ShowVC = [[HEFShowViewController alloc] init];
    ShowVC.idromName = idromString;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = FB_Frame;
    [button setTitle:@"收藏" forState:UIControlStateNormal];
    [button setTitle:@"取消收藏" forState:UIControlStateSelected];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
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
/**
 *  添加一个加载时遮罩
 */
- (void)addLoadingMaskView
{
    [self loadingMask];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"正在加载,请稍后..."];
    
}

/**
 *  删除加载时的遮罩
 */
- (void)removeLoadingMaskView
{
    [UIView animateWithDuration:0.35 animations:^{
        self.loadingMask.alpha = 0;
    } completion:^(BOOL finished) {
        [self.loadingMask removeFromSuperview];
        self.loadingMask = nil;
    }];
}

@end
