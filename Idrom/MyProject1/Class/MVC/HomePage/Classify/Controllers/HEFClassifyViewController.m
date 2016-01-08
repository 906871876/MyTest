//
//  HEFClassifyViewController.m
//  MyProject1
//
//  Created by 成都千锋 on 15/12/3.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFClassifyViewController.h"
#import "HEFIdromViewController.h"
@interface HEFClassifyViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *myTableView;
    NSMutableArray *dataArray;
}

@end

@implementation HEFClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分类查看";
    
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
    

    NSArray *classifyArray = @[@"带数字的成语",
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
    [dataArray addObjectsFromArray:classifyArray];
    [myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = dataArray[indexPath.row];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *rowString = dataArray[indexPath.row];
//    NSRange range = {2,2};
//    NSString *nameString = [rowString substringWithRange:range]; 
    HEFIdromViewController *idromVC = [[HEFIdromViewController alloc] init];
    idromVC.describeStr = rowString;//描述的Str
    [self.navigationController pushViewController:idromVC animated:YES];

}


@end
