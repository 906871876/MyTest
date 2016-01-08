//
//  HEFDisplayModel.h
//  MyProject1
//
//  Created by 成都千锋 on 15/12/3.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFBaseModel.h"

@interface HEFDisplayModel : HEFBaseModel
/**成语名称*/
@property (nonatomic, copy) NSString *name;
/**读音*/
@property (nonatomic, copy) NSString *pronounce;
/**解释*/
@property (nonatomic, copy) NSString *content;
/**出自*/
@property (nonatomic, copy) NSString *comefrom;
/**反义词*/
@property (nonatomic, copy) id antonym;
/**近义词*/
@property (nonatomic, copy) id thesaurus;
/**例子*/
@property (nonatomic, copy) NSString *example;


@end
