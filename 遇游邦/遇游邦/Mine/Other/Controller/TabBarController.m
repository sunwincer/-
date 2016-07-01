//
//  TabBarController.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/22.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "TabBarController.h"
#import "HomePageController.h"
#import "FindController.h"
#import "MineController.h"
#import "MessageController.h"
#import "UIImage+OrigionImage.h"
#import "YYBtabBar.h"
#import "NavigationViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary * dict =@{
                           NSFontAttributeName:[UIFont systemFontOfSize:12],
                           NSForegroundColorAttributeName:kRGBColor(170, 170, 170)
                           };
    NSDictionary * selctDict =@{
                                NSForegroundColorAttributeName:kRGBColor(255, 150, 0)
                                };
    UITabBarItem * item =[UITabBarItem appearance];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selctDict forState:UIControlStateSelected];
    self.tabBar.backgroundColor=kRGBColor(247, 247, 247);
    
    //添加子控件
    [self setupChiledViewController:[[HomePageController alloc]init] title:@"首页" image:@"首页 空心" selectedImage:@"首页 选中"];
    [self setupChiledViewController:[[FindController alloc]init] title:@"发现" image:@"faxian" selectedImage:@"faxian  选中"];
    [self setupChiledViewController:[[MessageController alloc]init] title:@"消息" image:@"消息未" selectedImage:@"消息"];
    [self setupChiledViewController:[[MineController alloc]init] title:@"我的" image:@"我的" selectedImage:@"我的 "];
    
    
    //更换tabBar
    [self setValue:[[YYBtabBar alloc]init] forKey:@"tabBar"];
   
    
}
//初始化自控制器
-(void)setupChiledViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)highlightedImage;{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image =[UIImage origionImage:image];
    vc.tabBarItem.selectedImage =[UIImage origionImage:highlightedImage];
    //改变背景颜色，便于区分
    vc.view.backgroundColor =[UIColor whiteColor];
    

    //添加导航
    NavigationViewController * nv =[[NavigationViewController alloc]initWithRootViewController:vc];
    [self addChildViewController:nv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
