//
//  CDMyButton.m
//  day101303
//
//  Created by LUOHao on 15/10/13.
//  Copyright (c) 2015年 mobiletrain. All rights reserved.
//

#import "CDMyButton.h"

@implementation CDMyButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(self.bounds.size.width - 50, (self.bounds.size.height - 30) / 2, 40, 30);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(10, 0, self.bounds.size.width - 60, self.bounds.size.height);
}

@end
