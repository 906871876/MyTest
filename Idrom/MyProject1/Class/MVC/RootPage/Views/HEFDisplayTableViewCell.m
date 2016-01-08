//
//  HEFDisplayTableViewCell.m
//  MyProject1
//
//  Created by 成都千锋 on 15/12/3.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFDisplayTableViewCell.h"
#import "HEFDisplayModel.h"
@implementation HEFDisplayTableViewCell

- (void)setDisplayModel:(HEFDisplayModel *)displayModel{

    _nameLabel.text = displayModel.name;
    _pronounceLabel.text = displayModel.pronounce;
    _contentLabel.text = displayModel.content;
    _exampleLabel.text = displayModel.example;
    _comefromLabel.text = displayModel.comefrom;
    _comefromLabel.numberOfLines = 0;
    NSArray *antonymArr = displayModel.antonym;
    NSMutableString *antonymStr = [NSMutableString string];
    for (NSString *tempStr in antonymArr) {
        [antonymStr appendFormat:@"%@\n",tempStr];
    }
    _antonymLabel.text = antonymStr;
    
    NSArray *thesaurusArr = displayModel.thesaurus;
    NSMutableString *thesaurusStr = [NSMutableString string];
    for (NSString *tempStr in thesaurusArr) {
        [thesaurusStr appendFormat:@"%@\n",tempStr];
    }
    _thesaurusLabel.text = thesaurusStr;


}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
