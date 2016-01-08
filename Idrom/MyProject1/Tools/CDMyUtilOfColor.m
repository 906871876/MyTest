//
//  CDMyUtilOfColor.m
//  Generally means
//
//  Created by 成都千锋 on 15/11/2.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "CDMyUtilOfColor.h"

@implementation CDMyUtilOfColor

+ (UIColor *) randomColor{
    
    return [self randomColorWithAlpha:1];
}

+ (UIColor *) randomColorWithAlpha:(double)alpha{
    
    double red = arc4random() % 256 / 255.0;
    double green = arc4random() % 256 / 255.0;
    double blue = arc4random() % 256 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end
