//
//  UIBarButtonItem+YYBExtension.h
//  遇游邦
//
//  Created by 孙文策 on 16/6/26.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YYBExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action;
@end
