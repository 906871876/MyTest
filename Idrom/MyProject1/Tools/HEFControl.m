//
//  HHControl.m
//  1504LimitFree
//
//  Created by HeHui on 15/11/17.
//  Copyright (c) 2015年 HeHui. All rights reserved.
//

#import "HEFControl.h"

@implementation HEFControl

+ (UIButton *)generateButtonWith:(UIButtonType)type frame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imgName backgroundImageName:(NSString *)bgImgName fontSize:(CGFloat)font target:(id)target selector:(SEL)sel titleColor:(UIColor *)color
{
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    if (title.length > 0) {
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:font];
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (imgName.length > 0) {
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }
    if (bgImgName.length > 0) {
        [btn setBackgroundImage:[UIImage imageNamed:bgImgName] forState:UIControlStateNormal];
    }
    if (target && sel) {
        [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
    
}
@end
