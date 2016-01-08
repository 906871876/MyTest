//
//  CDMyUtilOfAlert.m
//  Generally means
//
//  Created by 成都千锋 on 15/11/2.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "CDMyUtilOfAlert.h"

@implementation CDMyUtilOfAlert

+ (void) showAlertWithTitle:(NSString *) title andMessage:(NSString *)msg onViewController:(UIViewController *)viewController{
    
    [self showAlertWithTitle:title andMessage:msg onViewController:viewController withHandler:nil];
    
}

+ (void) showAlertWithTitle:(NSString *) title andMessage:(NSString *)msg onViewController:(UIViewController *)viewController withHandler:(void(^)(UIAlertAction *)) handler{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    [ac addAction:ok];
    [viewController presentViewController:ac animated:YES completion:nil];
    
    
}

@end
