//
//  CDMyUtilOfSort.m
//  MyProject1
//
//  Created by 成都千锋 on 15/11/27.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "CDMyUtilOfSort.h"

@implementation CDMyUtilOfSort
+ (NSMutableArray *) stringToSortWithArray:(NSArray *)oldArray{
    
    NSMutableArray *nameArray = [NSMutableArray new];
    NSMutableArray *preArray  = [NSMutableArray new];
    NSMutableArray *newArray  = [NSMutableArray new];
    NSMutableArray *dataArray = [NSMutableArray new];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cityInfo" ofType:@"plist"];
    NSArray *tempArray = [NSArray arrayWithContentsOfFile:filePath];
    
    for (NSDictionary *dict in tempArray) {
        [nameArray addObject:dict[@"city_name"]];
        [preArray addObject:dict[@"city_pre"]];
        
    }
    for (int i = 0; i < nameArray.count; i++) {
        NSString *string = [NSString stringWithFormat:@"%@%@",preArray[i],nameArray[i]];
        
        [newArray addObject:string];
        
    }
    
    NSArray *lastArray = [newArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSArray *keyArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];
    
    for (int i = 0; i < keyArray.count; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int j = 0; j < lastArray.count; j++) {
            NSString *str1 = [lastArray[j] substringToIndex:1];
            NSString *first = [[NSString stringWithFormat:@"%@", str1] uppercaseString];
            if ([first isEqualToString:keyArray[i]]) {
                NSString *updateStr = [lastArray[j] substringFromIndex:1];
                [arr addObject:updateStr];
            }
        }
        [dataArray addObject:arr];  
    }
    return dataArray;
}
@end
