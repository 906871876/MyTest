//
//  HEFDisplayTableViewCell.h
//  MyProject1
//
//  Created by 成都千锋 on 15/12/3.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HEFDisplayModel;
@interface HEFDisplayTableViewCell : UITableViewCell

/**成语名称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**读音*/
@property (weak, nonatomic) IBOutlet UILabel *pronounceLabel;
/**解释*/
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/**出自*/
@property (weak, nonatomic) IBOutlet UILabel *comefromLabel;
/**反义词*/
@property (weak, nonatomic) IBOutlet UILabel *antonymLabel;
/**近义词*/
@property (weak, nonatomic) IBOutlet UILabel *thesaurusLabel;
/**例子*/
@property (weak, nonatomic) IBOutlet UILabel *exampleLabel;

@property (nonatomic, strong) HEFDisplayModel *displayModel;

@end
