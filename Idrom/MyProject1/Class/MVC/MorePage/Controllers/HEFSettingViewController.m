//
//  HEFSettingViewController.m
//  MyProject1
//
//  Created by 成都千锋 on 15/12/14.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFSettingViewController.h"

@interface HEFSettingViewController ()

@end

@implementation HEFSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextView *myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    myTextView.font = [UIFont systemFontOfSize:18];
    myTextView.editable = NO;
    NSArray *array = @[@"操作说明",@"字体设置",@"软件版本"];
    NSLog(@"set %@", _settingStr);
    if ([_settingStr isEqualToString:array[0]]) {
        myTextView.text = @"\t➤ 如需快速查找某个成语，可直接进入查询界面;\n\n\t➤ 查询界面可根据单个字查询，也可用模糊查询;\n\n\t➤ 可以将自己需要的成语添加都收藏夹，以便查看\n";
    }
    if ([_settingStr isEqualToString:array[2]]) {
        myTextView.text = @"APP Name: Idioms daquan\nAPP Version: 1.1";
    }
    
    [self.view addSubview:myTextView];
}





@end
