//
//  HEFDBManager.h
//  MyProject1
//
//  Created by 成都千锋 on 15/12/10.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEFDBModel.h"
@interface HEFDBManager : NSObject

+ (instancetype) manager;

/** 是否已经存在 */
- (BOOL)isModelExists:(HEFDBModel *)model;

/** 增 */
- (BOOL)insertModel:(HEFDBModel *)model;

/** 删 */
- (BOOL)deleteModel:(HEFDBModel *)model;

/** 改 */
//- (BOOL)updateModel:(HEFDBModel *)model;

/** 查 */
- (NSArray *)queryModels;



@end
