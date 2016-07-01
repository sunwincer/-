//
//  HomePageController.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/22.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "HomePageController.h"

#import "LocationViewController.h"
#import "iCarousel.h"
#import "StyleTableViewCell.h"
#import "SearchViewController.h"
#import "SelectViewController.h"
#import "HotTableViewController.h"
#import "CityTableViewController.h"
#import "TypeTableViewController.h"
#import "LastTableViewController.h"

#define kButtonSpace (self.view.width - (56 * 4))/8.0


@interface HomePageController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) UISearchBar * search;

//头部标题栏

@property (nonatomic,strong)UIView * titleView;

@property(nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) UIView * headerView;
//内容view
@property(nonatomic,strong)UIScrollView *contentView;


//保存选中的按钮

@property (nonatomic,strong) UIButton *selectButton;
//指示器
@property (nonatomic,strong) UIView *indicator;
@property(nonatomic,strong) StyleTableViewCell *cell;


//头部图片
@property (nonatomic,strong) NSArray * imageArr;
@end

@implementation HomePageController

{
    iCarousel *_ic;
    UIPageControl *_pageControl;
    
    NSTimer *_timer;
}

-(NSArray *)imageArr{
    
    if (!_imageArr) {
        _imageArr =@[@"1",@"2"@"3",@"4",@"5",@"3"];
    }
    return _imageArr;
    
}
/**初始化自控制器
 */
-(void)setupChildVcs{
    
    HotTableViewController* hot  =[[HotTableViewController alloc]init];
    [self addChildViewController:hot];
    CityTableViewController *city =[[CityTableViewController alloc]init];
    
    [self addChildViewController:city];
    TypeTableViewController *type =[[TypeTableViewController alloc]init];
    
    [self addChildViewController:type];

    LastTableViewController *last =[[LastTableViewController alloc]init];
    
    [self addChildViewController:last];

    
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
    contentView.scrollEnabled=NO;
    self.contentView = contentView;
    
   
    contentView.frame =CGRectMake(0, 210, kWindowW,kWindowH);
    
  
   
    
    //滚动区域
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * contentView.width, 0);
        //关闭系统帮你设置Inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view insertSubview:contentView atIndex:0];
    
    //加载第一个子控制器
    [self scrollViewDidEndScrollingAnimation:contentView];
    
    
}



/**

 *头部视图
 */
-(UIView *)headerView{
    [_timer invalidate];
    
    UIView *headerView=[[UIView alloc]init];
    headerView.backgroundColor =[UIColor lightGrayColor];
    self.headerView =headerView;
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kWindowW);
        make.height.mas_equalTo(160);
    }];
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 35, kWindowW, 160)];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.image=[UIImage imageNamed:@"4.jpg"];
    [headerView addSubview:imageView];
    return headerView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigation];
    [self headerView];

    [self setupTitleView];
    //初始化自控制器
    [self setupChildVcs];
    [self setupContentView];
    
    
}
-(void)setupNavigation{
    
    
    
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(72, 31, self.view.width-71-44, 30);
    view.backgroundColor = kRGBColor(255, 108, 2);
    view.layer.cornerRadius =15;
    
    self.navigationItem.titleView=view;
    
    UIButton * searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [view addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-17);
        make.bottom.mas_equalTo(-7);
    }];
    searchBtn.backgroundColor =[UIColor clearColor];
    [searchBtn setTitle:@"搜索目的地/用户昵称/内容关键词" forState:UIControlStateNormal];
    [searchBtn setTintColor:kRGBColor(225, 120, 0)];
    searchBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [searchBtn addTarget:self action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];

    
    
//    UITextField * filed =[[UITextField alloc]init];
//    //UISearchBar *search = [[UISearchBar alloc]init];
//    //self.search = search;
//    [view addSubview:filed];
//    filed.backgroundColor =[UIColor clearColor];
//    [filed mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(5);
//        make.left.mas_equalTo(35);
//        make.right.mas_equalTo(-17);
//        make.bottom.mas_equalTo(-7);
//    }];
    //search.delegate = self;
    
//    UIImage *bgImage = [UIImage imageNamed:@"btn_search"] ;
//     
//    search.backgroundImage = [UIImage image:bgImage scaleToSize:search.size];
//    [view addSubview:search];
//     */
//    self.navigationItem.titleView = view;
//    filed.backgroundColor =[UIColor colorWithRed:225 green:108 blue:2 alpha:1];
    
    UIImageView * imageView =[[UIImageView alloc]init];
    
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.left.mas_equalTo(13);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    imageView.image =[UIImage imageNamed:@"搜索"];
    
    
//    UIView * view =[[UIView alloc]init];
   UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"北京" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"V"] forState:UIControlStateNormal];
    
    button.titleEdgeInsets =UIEdgeInsetsMake(0, -40, 0, 0);
    
    button.imageEdgeInsets =UIEdgeInsetsMake(0, 30, 0, 0);
    
    button.tintColor=kRGBColor(255, 255, 255);
    button.size =CGSizeMake(50, 21);
    button.titleLabel.font =[UIFont systemFontOfSize:17];
    [button setBackgroundColor:[UIColor clearColor]];
    [button addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
//    UIImageView *image =[[UIImageView alloc]initWithImage:];
//    
//    
//        image.contentMode =UIViewContentModeLeft;
    
    
    
        self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    
    
    self.navigationItem.rightBarButtonItem= [UIBarButtonItem itemWithImage:@"筛选" highImage:@"筛选 深色" title:nil target:self action:@selector(clickToSelect)];
    
    
    
    
}
/**
 *  初始化顶部标题栏
 */
-(void)setupTitleView
{
    UIView * titleView = [[UIView alloc]init];
    self.titleView=titleView;
    titleView.width = self.view.width;
    titleView.height = 35;
    titleView.y = 0;    //    titleView.alpha = 0.5; 上面的内容(包含文字)都会半透明!!
    //设置背景颜色半透明
    //    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    //    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    
    [self.view addSubview:titleView];
    
    //创建指示器
    UIView * indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = kRGBColor(255, 125, 10);
    indicatorView.height = 2;
    indicatorView.y = titleView.height - indicatorView.height;
    self.indicator = indicatorView;
    [titleView addSubview:indicatorView];
    
    //添加子标题
    NSArray * titles = @[@"热门",@"同城",@"类型",@"最近出发"];
    CGFloat btnWidth = titleView.width / titles.count;
    CGFloat btnHeight = titleView.height;
    
    for (int i = 0; i < titles.count ; i++) {
        //创建按钮
        //        [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * btn = [[UIButton alloc]init];//这样创建和上面一样效果
        btn.width = btnWidth;
        btn.height = btnHeight;
        btn.x = i * btnWidth;
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:kRGBColor(170, 170, 170) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(titleSelect:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:kRGBColor(255, 125, 10) forState:UIControlStateDisabled];
        [btn setTag:i];
        if (i == 0) {
            btn.enabled = NO;
            self.selectButton = btn;
            //设置指示器
            [btn layoutIfNeeded];
            self.indicator.width = btn.titleLabel.width;
            self.indicator.centerX = btn.centerX;
            
        }
        if (i== 2) {
            [btn setImage:[UIImage imageNamed:@"类型下拉"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"类型下拉 选中"] forState:UIControlStateDisabled];
            btn.titleEdgeInsets= UIEdgeInsetsMake(0, -30, 0, 0);
            btn.imageEdgeInsets =UIEdgeInsetsMake(0, 50, 0, 0);
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
        self.indicator.width = btn.titleLabel.width;
        self.indicator.centerX = btn.centerX;
        NSLog(@"%f",btn.center.x);
    }];
    if (btn.tag==2) {
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200);
            make.top.mas_equalTo(self.indicator.mas_bottom);
            make.centerX.mas_equalTo(self.indicator.mas_centerX);
           
            
        }];
        
    }
    else{
        [self.tableView removeFromSuperview];
    }
    
    //变色
    self.selectButton.enabled = YES;
    btn.enabled = NO;
    self.selectButton = btn;
    //2.滚动contentView
    CGPoint offset = self.contentView.contentOffset;
    offset.x = btn.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        NSLog(@"我来了");
        _tableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.selectButton.mas_centerX);
            make.top.mas_equalTo(self.selectButton.mas_bottom).mas_equalTo(0);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(44* 6);
            ;
        }];
        NSLog(@"%lf",_tableView.frame.origin.x);
        
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StyleTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
        _tableView.tableFooterView=[UIView new];
        _tableView.rowHeight = 44;
        
        _tableView.backgroundColor=kRGBColor(229, 229, 229);
        
        
    }
    return _tableView;
}
//定位
-(void)locationClick{
    
    LocationViewController * vc =[[LocationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
//筛选
-(void)clickToSelect{
    
    SelectViewController * slVC =[[SelectViewController alloc]init];
    
    [self.navigationController pushViewController:slVC animated:YES];
    
    
    
    
    
}


-(void)clickToSearch{
    
    SearchViewController *seachView =[[SearchViewController alloc]init];
    
    [self.navigationController pushViewController:seachView animated:YES];
    
    
    NSLog(@"点击搜索");
    
}
#pragma mark--UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StyleTableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.styleLabel.textColor=kRGBColor(66, 66, 66);
    cell.styleLabel.highlightedTextColor=kRGBColor(255, 150, 0);
    
    self.cell =cell;
    NSArray *a =@[@"全部路线类型",@"休闲",@"摄影",@"登上",@"跑步",@"烧烤"];
    
    self.cell.styleLabel.text =a[indexPath.row];
    
    NSLog(@"cell的label的text%@",cell.styleLabel.text);
    NSLog( @"cell%@",cell);
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView removeFromSuperview];
    TypeTableViewController * TY=[[TypeTableViewController alloc]init];
    [TY.tableView reloadData];

 
}

kRemoveCellSeparator;





#pragma mark--UIScrollView
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
