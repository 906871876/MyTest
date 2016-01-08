//
//  CDMyUtilOfAlert.h
//  Generally means
//
//  Created by 成都千锋 on 15/11/2.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CDMyUtilOfAlert : NSObject

+ (void) showAlertWithTitle:(NSString *) title andMessage:(NSString *)msg onViewController:(UIViewController *)viewController;
+ (void) showAlertWithTitle:(NSString *) title andMessage:(NSString *)msg onViewController:(UIViewController *)viewController withHandler:(void(^)(UIAlertAction *)) handler;
@end
