//
//  YYBtabBar.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/22.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "YYBtabBar.h"
#import "UIView+YYBExtension.h"

@interface YYBtabBar ()

@property(nonatomic,weak) UIButton *publishBtn;

@end

@implementation YYBtabBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UIButton * publishBTN =[UIButton buttonWithType:UIButtonTypeCustom];
        [publishBTN setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
        [publishBTN setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateHighlighted];
        publishBTN.size =publishBTN.currentBackgroundImage.size;
        [self addSubview:publishBTN];
        self.publishBtn = publishBTN;
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width =self.width;
    CGFloat height = self.height;
    self.publishBtn.center =CGPointMake(width* 0.5, height * 0.5);
    
    //设置其他tabb的frame
    CGFloat buttonY = 0;
    CGFloat buttonW =self.frame.size.width / 5.0;
    CGFloat buttonH =self.frame.size.height;
    NSInteger index = 0;
    
    for (UIView * button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]]|| button == self.publishBtn) {
            continue;
        }
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame =CGRectMake(buttonX, buttonY, buttonW, buttonH);
        NSLog(@"%lf",button.frame.origin.x);
        index ++;
    }
    
    
    
    
    
    
}

@end
