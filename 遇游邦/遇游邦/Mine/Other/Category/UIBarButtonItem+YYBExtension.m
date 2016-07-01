//
//  UIBarButtonItem+YYBExtension.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/26.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "UIBarButtonItem+YYBExtension.h"
#import "UIView+YYBExtension.h"

@implementation UIBarButtonItem (YYBExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc]initWithCustomView:button];
}

@end
