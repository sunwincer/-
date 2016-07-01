//
//  LightNavigationViewController.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/29.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "LightNavigationViewController.h"
#import "UIView+YYBExtension.h"

@interface LightNavigationViewController ()

@end

@implementation LightNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setTintColor:[UIColor redColor]];
    
    UIImage *backgroundImage = [self imageWithColor:kRGBColor(255, 255, 255)];
    [self.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    
}

-(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count>0) {
        //自定义设置返回
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:nil forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"返回  黑色"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"返回 白色"] forState:UIControlStateNormal];
        //        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        //        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        button.size =button.currentBackgroundImage.size;
        //让按钮的内容往左偏
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        
        
        
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:button];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //需要加上去，否则不出来,  可以覆盖上面设置的leftBar
    [super pushViewController:viewController animated:animated];
    
    
    
    
}
-(void)back {
    
    
    [self popViewControllerAnimated:YES];
    
}


@end
