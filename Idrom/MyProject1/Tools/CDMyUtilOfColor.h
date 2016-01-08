//
//  CDMyUtilOfColor.h
//  Generally means
//
//  Created by 成都千锋 on 15/11/2.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CDMyUtilOfColor : NSObject

/**获得随机颜色*/
+ (UIColor *) randomColor;
/**获得不用透明度的颜色*/
+ (UIColor *) randomColorWithAlpha:(double)alpha;
@end
