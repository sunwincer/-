//
//  ActivityTableViewCell.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/28.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "ActivityTableViewCell.h"

@interface ActivityTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *ActivityImageView;

@property (weak, nonatomic) IBOutlet UILabel *ActivityTitlelabel;

@property (weak, nonatomic) IBOutlet UILabel *ActivityDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *ActivityDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ActivityStyleLableA;
@property (weak, nonatomic) IBOutlet UILabel *ActivityStyleLableB;
@property (weak, nonatomic) IBOutlet UILabel *ActivityStyleLableC;
@property (weak, nonatomic) IBOutlet UILabel *ActivityPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ActivityOwnerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ActivityCompanyImageView;

@end
@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
