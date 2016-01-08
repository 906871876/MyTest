//
//  HEFRootTabBarVC.m
//  MyProject1
//
//  Created by 成都千锋 on 15/11/18.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFRootTabBarVC.h"

@interface HEFRootTabBarVC ()


@end

@implementation HEFRootTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addControllers];
}

/** 添加子视图控制器 */
- (void) addControllers{
    
 
    self.tabBar.backgroundColor = [UIColor whiteColor];

    NSArray *nameArray = @[@"分类",@"查询",@"收藏",@"更多"];
    NSArray *normalArray = @[@"tab_app",
                             @"tab_search",
                             @"tab_featured",
                             @"tab_game"];
    NSArray *selectedArray = @[@"tab_app_seclected",
                               @"tab_search_seclected",
                               @"tab_featured_seclected",
                               @"tab_game_seclected"];
    
    NSArray *VCNameArray = @[@"HEFClassifyViewController",
                             @"HEFSearchViewController",
                             @"HEFFeatureViewController",
                             @"HEFOtherViewController"];
    
        
    for (int i = 0; i < nameArray.count; i++) {
        //通过类名获取这个 类
        Class class = NSClassFromString(VCNameArray[i]);
        
        UIViewController *vc = [[class alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.tabBarItem.title = nameArray[i];
        vc.tabBarItem.image = [[UIImage imageNamed:normalArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //设置导航栏
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        //逐一添加ViewController
        [self addChildViewController:nav];
        

    }
 
}





@end
