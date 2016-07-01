//
//  ResultViewController.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/29.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "ResultViewController.h"
#import "LightNavigationViewController.h"
#import "ScrollDisplayViewController.h"
#import "UIView+YYBExtension.h"
#import "ResultUserViewController.h"
#import "ResultActivityViewController.h"
@interface ResultViewController ()<UIScrollViewDelegate>

//指示器
@property(nonatomic,strong) UIView * indicator;
/**
 *  按钮
 */
@property(nonatomic,strong) UIButton * selectBtn;
//内容view
@property(nonatomic,strong) UIScrollView * contentView;
//头部标题栏
@property(nonatomic,strong) UIView *titleView;
//分割线
@property(nonatomic,strong) UIView *seperatorView;


@end

@implementation ResultViewController
- (void)viewDidLoad {
    [super viewDidLoad];
        
    
//    LightNavigationViewController * na =[[LightNavigationViewController alloc]initWithRootViewController:self];
//    [self addChildViewController:na];
    
    
    
    // Do any additional setup after loading the view.
    self.navigationItem.title =self.title;
    //初始化标题栏
    [self setupTitleView];
    //初始化自控制器
    [self setupChildVcs];
    [self setupContentView];
}
/**初始化自控制器
 */
-(void)setupChildVcs{
    ResultActivityViewController * activity =[[ResultActivityViewController alloc]init];
    [self addChildViewController:activity];
    ResultUserViewController *user =[[ResultUserViewController alloc]init];
    
    [self addChildViewController:user];
    
}
/**
 *  初始化contentView
 */
-(void)setupContentView
{
    UIScrollView * contentView = [[UIScrollView alloc]init];
    //让ScrollView分页显示
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    self.contentView = contentView;
    contentView.frame = [UIScreen mainScreen].bounds;
    //滚动区域
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * contentView.width, 0);
    /*
     UISwitch * s = [[UISwitch alloc]init];
     s.on = YES;
     [contentView addSubview:s];
     UISwitch * s1 = [[UISwitch alloc]init];
     s1.x = 375;
     s1.on = YES;
     [contentView addSubview:s1];
     UISwitch * s2 = [[UISwitch alloc]init];
     s2.x = 375 * 2;
     s2.on = YES;
     [contentView addSubview:s2];
     */
    //关闭系统帮你设置Inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view insertSubview:contentView atIndex:0];
    
    //加载第一个子控制器
    [self scrollViewDidEndScrollingAnimation:contentView];

    
}
/**
 *  初始化顶部标题栏
 */
-(void)setupTitleView
{
    UIView * titleView = [[UIView alloc]init];
    self.titleView = titleView;
    titleView.width = self.view.width;
    titleView.height = 40;
    titleView.y = 0;
    //    titleView.alpha = 0.5; 上面的内容(包含文字)都会半透明!!
    //设置背景颜色半透明
    //    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    //    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    titleView.backgroundColor = kRGBColor(255, 255, 255);
    [self.view addSubview:titleView];
    
    
    //创建分割线
    UIView * seperatorView =[[UIView alloc]init];
    self.seperatorView=seperatorView;
    seperatorView.backgroundColor=kRGBColor(184, 184, 184);
    seperatorView.width=0.5;
    seperatorView.height =20;
    seperatorView.center = titleView.center;
    [titleView addSubview:seperatorView];
    
    //创建指示器
    UIView * indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = kRGBColor(255, 125, 0);
    indicatorView.height = 0.5;
    indicatorView.y = titleView.height - indicatorView.height;
    self.indicator = indicatorView;
    [titleView addSubview:indicatorView];
    
    //添加子标题
    NSArray * titles = @[@"活动",@"用户"];
    CGFloat btnWidth = titleView.width / titles.count;
    CGFloat btnHeight = titleView.height;
    
    for (int i = 0; i < titles.count ; i++) {
        //创建按钮
        //        [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * btn = [[UIButton alloc]init];//这样创建和上面一样效果
        btn.width = btnWidth;
        btn.height = btnHeight;
        btn.x = i * btnWidth;
        btn.tag = i;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(titleSelect:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        if (i == 0) {
            btn.enabled = NO;
            self.selectBtn = btn;
            //设置指示器
            [btn layoutIfNeeded];
            self.indicator.width = btn.width;
            self.indicator.centerX = btn.centerX;
            
        }
        
        [titleView addSubview:btn];
    }
    
    
    
}

/**
 *  选中指示器
 */
-(void)titleSelect:(UIButton * )btn{
    //挪动我的指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.width = btn.width;
        self.indicator.centerX = btn.centerX;
    }];
    
    //变色
    self.selectBtn.enabled = YES;
    btn.enabled = NO;
    self.selectBtn = btn;
    
    
    //2.滚动contentView
    CGPoint offset = self.contentView.contentOffset;
    offset.x = btn.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //要知道加载哪一个控制器的View
    //根据偏移量来获得当前加载哪一个!!  偏移量/宽度 获得偏移了几个宽度
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    //取出当前控制器
    UITableViewController * vc = self.childViewControllers[index];
    //控制器的View的坐标
    vc.tableView.x = scrollView.contentOffset.x;
    //添加View
    [scrollView addSubview:vc.tableView];
    
    //设置内边距
    CGFloat y = CGRectGetMaxY(self.titleView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(y, 0, 49, 0);
    vc.tableView.contentOffset = CGPointMake(0, -y);
}

@end
