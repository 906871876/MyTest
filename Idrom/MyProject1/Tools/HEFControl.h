//
//  HHControl.h
//  1504LimitFree
//
//  Created by HeHui on 15/11/17.
//  Copyright (c) 2015年 HeHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HEFControl : NSObject

/**
 *  Button
 */

+ (UIButton *)generateButtonWith:(UIButtonType)type
                           frame:(CGRect)frame
                           title:(NSString *)title
                       imageName:(NSString *)imgName backgroundImageName:(NSString *)bgImgName
                        fontSize:(CGFloat)font
                          target:(id)target
                        selector:(SEL)sel
                      titleColor:(UIColor *)color;




@end
