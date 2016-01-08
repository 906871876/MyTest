//
//  HEFMoreVC.m
//  MyProject1
//
//  Created by 成都千锋 on 15/12/10.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFOtherViewController.h"
#import "HEFSettingViewController.h"
@interface HEFOtherViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HEFOtherViewController

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = @[].mutableCopy;
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于APP";
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource =self;

    [self loadDataModel];
    [self.view addSubview:self.myTableView];
    
    
}

- (void) loadDataModel{
    
    NSArray *secondSection = @[@"操作说明",@"字体设置",@"软件版本",@"更多功能即将推出……"];

    [self.dataArray addObjectsFromArray:secondSection];

}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    static NSArray *titles = nil;
//    if (!titles) {
//        titles = @[@"   关于APP"];
//    }
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
//    label.text = titles[section];
//    label.backgroundColor = TAB_COLOR(240, 240, 240, 1);
//    label.textColor = Text_Color;
//    label.font = [UIFont systemFontOfSize:16];
//    label.tag = 600 + section;
//    return label;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    static NSArray *titles = nil;
//    if (!titles) {
//        titles =@[@"设置说明"];
//    }
//    return titles[section];
//}

////指定分组
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.dataArray.count;
//}

//步骤4.实现委托和数据源中的方法
//指定每个分区里面有多少行

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 30;
//}


//创建表格的单元格   cell：单元格

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *items =@[@"小号",@"中号",@"大号"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:items];
    seg.frame = CGRectMake(WIDTH - 160, 9, 150, 26);
    if (indexPath.row == 1) {
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"one"];
        if (!oneCell) {
            oneCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"one"];
        }
        [oneCell.viewForBaselineLayout addSubview:seg];
        oneCell.textLabel.text = self.dataArray[1];
        return oneCell;
    }else{
    
        static NSString *cellIdentifier = @"CELL";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }

        if (indexPath.row != 3) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = self.dataArray[indexPath.row];
        return cell;
    }
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 1 || indexPath.row != 3) {
        NSString *string = _dataArray[indexPath.row];
        
        HEFSettingViewController *settingVC = [[HEFSettingViewController alloc] init];
        settingVC.settingStr = string;
        [self.navigationController pushViewController:settingVC animated:YES];
    }


}
@end
