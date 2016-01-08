//
//  HEFShowViewController.m
//  MyProject1
//
//  Created by 成都千锋 on 15/12/4.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFShowViewController.h"
#import <AFNetworking.h>
#import "APIConfig.h"
#import "HEFDisplayModel.h"
#import <Masonry.h>
#import <SVProgressHUD.h>
#import "HEFRandomIdiom.h"

@interface HEFShowViewController ()

/**成语名称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**读音*/
@property (weak, nonatomic) IBOutlet UILabel *pronounceLabel;
/**解释*/
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/**出自*/
@property (weak, nonatomic) IBOutlet UILabel *comefromLabel;
/**近义词*/
@property (weak, nonatomic) IBOutlet UILabel *thesaurusLabel;
/**反义词*/
@property (weak, nonatomic) IBOutlet UILabel *antonymLabel;
/**例子*/
@property (weak, nonatomic) IBOutlet UILabel *exampleLabel;

@property (nonatomic, strong) UIView *loadingMask;


@end

@implementation HEFShowViewController

- (NSString *)idromName{
    if (_idromName == nil) {
        _idromName = [NSString new];
    }
    return _idromName;
}

- (UIView *)loadingMask
{
    if (_loadingMask == nil) {
        _loadingMask = [[UIView alloc] init];
        [self.view addSubview:_loadingMask];
        [_loadingMask mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            
        }];
        _loadingMask.backgroundColor = [UIColor whiteColor];
        
    }
    return _loadingMask;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addDataWithIdrom];


}

/**加载数据*/
- (void) addDataWithIdrom{
    //添加一个加载时遮罩
    [self addLoadingMaskView];
    
    _idromName = [_idromName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *keyStr = @"0d70b0baf0a7b7e0";
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.jisuapi.com/chengyu/detail?appkey=%@&chengyu=%@",keyStr,_idromName];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/xml", @"application/json", nil];
    
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            NSDictionary *tempDict = responseObject[@"result"];
            
            HEFDisplayModel *model = [[HEFDisplayModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDict];
            [self removeLoadingMaskView];
            [self stuffDataWithModel:model];
        });
   
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];

}
/**填充数据*/
- (void) stuffDataWithModel:(HEFDisplayModel *)model{
    
    _nameLabel.text = model.name;
    _pronounceLabel.text = model.pronounce;

    //判断是否有释义
    if ([model.content isEqual:@""] || [model.content isEqual:@"无"]) {
        _contentLabel.text = @"暂无来源";
    }else{
        _contentLabel.text = model.content;
    }
    
    //判断是否有反义词
    if ([model.antonym  isEqual: @""] || [model.antonym isEqual:@"无"]) {
        _antonymLabel.text  = @"暂无反义词";
    }else{
        
        NSArray *antonymArr = model.antonym;
        NSMutableString *antonymStr = [NSMutableString string];
        for (NSString *tempStr in antonymArr) {
            [antonymStr appendFormat:@"%@ ",tempStr];
        }
        _antonymLabel.text = antonymStr;

    }
    //判断是否有近义词
    if ([model.thesaurus  isEqual: @""] || [model.thesaurus isEqual:@"无"]) {
        _thesaurusLabel.text =@"暂无近义词";
    }else{
        NSArray *thesaurusArr = model.thesaurus;
        NSMutableString *thesaurusStr = [NSMutableString string];
        for (NSString *tempStr in thesaurusArr) {
            [thesaurusStr appendFormat:@"%@ ",tempStr];
        }
        _thesaurusLabel.text = thesaurusStr;
    }
    //判断是否有例子
    if ([model.example isEqual:@""] || [model.example isEqual:@"无"]) {
        _exampleLabel.text = @"暂无例子";
    }else{
        _exampleLabel.text = model.example;
    }
    //判断是否有来源
    if ([model.comefrom isEqual:@""] || [model.comefrom isEqual:@"无"]) {
        _comefromLabel.text = @"暂无来源";
    }else{
        _comefromLabel.text = model.comefrom;
    }
 
    
    

}

/**
 *  添加一个加载时遮罩
 */
- (void)addLoadingMaskView
{
    [self loadingMask];
    [SVProgressHUD showWithStatus:@"正在加载,请稍后..."];
    
}

/**
 *  删除加载时的遮罩
 */
- (void)removeLoadingMaskView
{
    [UIView animateWithDuration:0.35 animations:^{
        self.loadingMask.alpha = 0;
    } completion:^(BOOL finished) {
        [self.loadingMask removeFromSuperview];
        self.loadingMask = nil;
    }];
}
@end
