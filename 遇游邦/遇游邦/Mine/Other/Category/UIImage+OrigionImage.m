//
//  UIImage+OrigionImage.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/22.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "UIImage+OrigionImage.h"

@implementation UIImage (OrigionImage)
+(instancetype)origionImage:(NSString *)image{
    UIImage * oImage=[UIImage imageNamed:image];
    oImage =[oImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return oImage;
}

@end
