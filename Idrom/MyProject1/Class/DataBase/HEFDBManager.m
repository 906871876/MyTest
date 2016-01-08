//
//  HEFDBManager.m
//  MyProject1
//
//  Created by 成都千锋 on 15/12/10.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFDBManager.h"
#import <FMDB.h>

#define Error_log(preStr)  NSLog(@"%@失败 || error =%@",preStr, self.dataBase.lastErrorMessage);
@interface HEFDBManager ()

@property (nonatomic,strong) FMDatabase *dataBase;
@end


@implementation HEFDBManager
- (instancetype)init{

    NSException *exception = [NSException exceptionWithName:@"NotAllowed" reason:@"This is Single Thread" userInfo:nil];
    @throw exception;
    return nil;
}

+ (instancetype)manager{
    static HEFDBManager *g_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (g_manager == nil) {
            g_manager = [[[self class] alloc]initMyself];
        }
    });
    return g_manager;
    
    
}

- (FMDatabase *)dataBase{
    if (_dataBase == nil) {
        NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"chengyucidian.db"];
        _dataBase = [[FMDatabase alloc] initWithPath:dbPath];
    }
    return _dataBase;
}

- (instancetype)initMyself{

    self = [super init];
    if (self){
        // 创建数据库
        // 创建表
        if ([self.dataBase open]) {
            
            NSString *sql = @"CREATE TABLE IF NOT EXISTS idroms (name text)";
            if ([self.dataBase executeUpdate:sql]) {
                
                // 关闭数据库
                [self.dataBase close];
                
            } else {
                Error_log(@"创建表")
                [self.dataBase close];
            }
        }else {
            Error_log(@"打开数据库");
        }
    }
    return self;
}
/** 是否已经存在 */
- (BOOL)isModelExists:(HEFDBModel *)model{
    [self.dataBase open];
    NSString *name = model.name;
    
    NSString *sql = @"SELECT * FROM idroms WHERE name=?";
    
    FMResultSet *set = [self.dataBase executeQuery:sql,name];
    
    while ([set next]) {
        [self.dataBase close];
        return YES;
    }
    [self.dataBase close];
    return NO;
}

- (BOOL)insertModel:(HEFDBModel *)model{
    // 先判断本条是否已经存在
    BOOL isExist = [self isModelExists:model];
    [self.dataBase open];
    
    if (isExist) {
        NSLog(@"该条数据已经存在");
        [self.dataBase close];
        return NO;
    }else {
        NSString *sql = @"INSERT INTO idroms VALUES (?)";
        BOOL isSuc = [self.dataBase executeUpdate:sql,model.name];
        if (isSuc) {

                [self.dataBase close];
                return YES;
            
        }else {
            [self.dataBase close];
            
            return NO;
            Error_log(@"插入数据");
        }
    }

}

- (BOOL)deleteModel:(HEFDBModel *)model{
    BOOL isExist = [self isModelExists:model];
    [self.dataBase open];
    
    if (isExist) {
        // 先删除数据库中数据
        NSString *deleteSql = @"DELETE FROM idroms WHERE name=?";
        
        BOOL isDeleteSuc = [self.dataBase executeUpdate:deleteSql,model.name];
        if (isDeleteSuc) {
            [self.dataBase close];
            
            return YES;
            
        }else {
            Error_log(@"删除数据");
            
            [self.dataBase close];
            
            return NO;
        }
        
    }else {
        return NO;
        
        Error_log(@"删除数据");
    }
}


- (NSArray *)queryModels{
    [self.dataBase open];
    // 去数据库中获取所有数据
    NSString *sql = @"SELECT * FROM idroms";
    
    FMResultSet *set = [self.dataBase executeQuery:sql];
    
    NSMutableArray *arr = @[].mutableCopy;
    
    while ([set next]) {
        
        // 每次查到数据，创建一个model并且给model对应的属性赋值
        HEFDBModel *model = [HEFDBModel new];
        model.name = [set stringForColumn:@"name"];
        [arr addObject:model];
        
    }
    [self.dataBase close];
    return arr;
}
@end
