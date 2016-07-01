//
//  StyleTableViewCell.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/28.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "StyleTableViewCell.h"

@interface StyleTableViewCell ()


@end
@implementation StyleTableViewCell

- (void)awakeFromNib {
        // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame{
    
    frame.size.height -= 0.5;
    //    frame
    [super setFrame:frame];

    
}

@end
