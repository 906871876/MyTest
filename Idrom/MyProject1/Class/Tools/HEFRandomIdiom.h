//
//  HEFRandomIdiom.h
//  MyProject1
//
//  Created by 成都千锋 on 15/12/5.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEFRandomIdiom : NSObject
/** 生成随机成语*/
+ (NSString *) RandomIdiom;
/** 返回数字成语*/
+ (NSString *) returnNumberIdiom;

/** 叠字成语*/
+ (NSString *) returnReiterativeLocutionIdiom;

/** 含有一对反义词的成语*/
+ (NSArray *) returnOneAntonymsIdiom;

/** 含有两对反义词的成语*/
+ (NSString *) returnTwoAntonymsIdiom;

/** 含有两对近义词的成语*/
+ (NSArray *) returnTwoSynonymsIdrom;

/** 动物名称成语*/
+ (NSString *) returnAnimalIdiom;

/** 植物名称成语*/
+ (NSString *) returnPlantIdiom;

/** 人体名称成语*/
+ (NSString *) returnHumanBodyIdiom;


/** 方位名称成语*/
+ (NSString *) returnLocationIdiom;

/** 描写四季的成语*/
+ (NSString *) returnFourSeasonsIdiom;

/** 隔字相同的成语*/
+ (NSString *) returnSameWordsIdiom;



/** 其他的成语*/
+ (NSString *) returnOtherIdiom;
@end
