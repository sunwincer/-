//
//  LocationViewController.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/27.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "LocationViewController.h"
#import <Masonry.h>
#import "SearchViewController.h"

@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UISearchBar * search;
//搜索背景
@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) UIButton *searchButton;
//记录历史信息
@property (nonatomic,strong) NSMutableArray * record;
@property (nonatomic,strong) UIView *locationView;
//定位位置的显示的label
@property (nonatomic,strong) UILabel *locationLabel;

@property (nonatomic,strong) UILabel *cityLabel;

@property (nonatomic,strong) UIButton * locationBtn;

//热门城市
@property (nonatomic,strong)NSArray * topCityArr;




@end
@implementation LocationViewController



-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.searchView.hidden =NO;
    self.locationView.hidden =NO;
    
    [self setupNavigationItem];
    
}
//导航

-(void)setupNavigationItem{
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1]];
    UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    
    label.center =self.navigationItem.titleView.center;
    label.textColor =[UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    label.font =[UIFont systemFontOfSize:16];
    label.textAlignment =NSTextAlignmentCenter;
    label.text =@"选择城市";
    [label setNumberOfLines:0];
    [label sizeToFit];
    
    self.navigationItem.titleView =label;
    
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = [UIColor colorWithRed:255 green:108 blue:2 alpha:1];
}
//搜索
-(UIView *)searchView{
    if (!_searchView) {
        _searchView =[UIView new];
        _searchView.frame =CGRectMake(0, 0, kWindowW, 50);
        _searchView.backgroundColor =kRGBColor(247, 247, 247);
        [self.view addSubview:_searchView];
        
        UIView *View =[UIView new];
        View.backgroundColor=kRGBColor(255, 255, 255);
        [_searchView addSubview:View];
        [View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 19, 10, 19));
        }];
        UIImageView * imageview =[[UIImageView alloc]init];
        UIImage * image =[UIImage imageNamed:@"搜索－定位页"];
        imageview.image=image;
        [View addSubview:imageview];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(View);
            make.left.mas_equalTo(12);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
        
        self.searchButton =[UIButton buttonWithType:0];
        self.searchButton.backgroundColor=[UIColor clearColor];
        self.searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.searchButton.titleLabel.font =[UIFont systemFontOfSize:13];
        [self.searchButton setTitle:@"深圳" forState:UIControlStateNormal];
        self.searchButton.titleLabel.textColor =kRGBColor(255, 120, 0);
        
        [View addSubview:self.searchButton];
        [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.left.mas_equalTo(imageview.mas_right).mas_equalTo(6);
            make.top.mas_equalTo(View.mas_top).mas_equalTo(0);
            make.bottom.mas_equalTo(View.mas_bottom).mas_equalTo(0);
            make.right.mas_equalTo(View.mas_right).mas_equalTo(0);
        }];
        
        
        [self.searchButton addTarget:self action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
        
    }
    return _searchView;
}

//城市背景
-(UIView *)locationView{
    
    if (!_locationView) {
        _locationView =[UIView new];
        
        _locationView.backgroundColor =nil;
        [self.view addSubview:_locationView];
        [_locationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.searchView.mas_bottom).mas_equalTo(0);
            
            make.left.right.mas_equalTo(0);
#warning 需要改，
            make.bottom.mas_equalTo(0);
            
        }];
        UILabel *label =[UILabel new];
        [_locationView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(17);
            make.top.mas_equalTo(18);
            make.size.mas_equalTo(CGSizeMake(56, 14));
        }];
       label.font =[UIFont systemFontOfSize:14];
        label.tintColor = kRGBColor(52, 52, 52);
        label.text =@"当前位置";
        
 //=========================================================定位按钮
        self.locationBtn =[UIButton buttonWithType:0];
        
        
        [_locationView addSubview:self.locationBtn];
        [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(label.mas_bottom).mas_equalTo(17);
            make.left.mas_equalTo(58);
            make.right.mas_equalTo(-58);
            make.height.mas_equalTo(34);
        }];
        self.locationBtn.layer.cornerRadius = 15;
        [self.locationBtn.layer setBorderWidth:1];//设置边界的宽度
        
        
        
        //设置按钮的边界颜色
        
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){170/255,170/255,170/255,1});
        
        [self.locationBtn.layer setBorderColor:color];
        
   //=======================================================
        
        UILabel * topCityTitleLabel =[[UILabel alloc]init];
        
        [_locationView addSubview:topCityTitleLabel];
        [topCityTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(17);
            make.top.mas_equalTo(self.locationBtn.mas_bottom).mas_equalTo(28);
            make.width.mas_equalTo(56);
            make.height.mas_equalTo(14);
        }];
        topCityTitleLabel.text=@"热门城市";
        topCityTitleLabel.font =[UIFont systemFontOfSize:14];
        topCityTitleLabel.tintColor = kRGBColor(52, 52, 52);
        
        UIView * lastView =nil;//记录上前一个图
        UIView * topView =nil;
        for (int i= 0; i < 4;i++) {
            
            UIButton *btn =[UIButton buttonWithType:0];
            [btn.layer setCornerRadius:15];
            [btn.layer setBorderWidth:1];
            CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
            
            CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){170/255,170/255,170/255,1});
            
            [btn.layer setBorderColor:color];
            
            [_locationView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
               
                make.top.mas_equalTo(topCityTitleLabel.mas_bottom).mas_equalTo(18);
                make.height.mas_equalTo(34);
                make.width.mas_equalTo((kWindowW-72)/4);
                
                if (lastView) {
                    make.size.mas_equalTo(lastView);
                    make.left.mas_equalTo(lastView.mas_right).mas_equalTo(10);
                    make.centerY.mas_equalTo(lastView);
                    
                }
                else{
                    make.left.mas_equalTo(21);
                }
                

            }];
            lastView =btn;
          
            
            
            self.locationBtn =btn;
            self.locationBtn.tag=i;
            [self.locationBtn addTarget:self action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            
            
            

        }
        
        
        


        
        
        
        
        
        
        
    }
    
    
    return _locationView;
    
    
    
    
    
}
//测试点击传值出来
-(void)clickTo:(UIButton *) sender
{
    
    
    NSLog(@"%ld",(long)sender.tag);
    
}

//当前位置
-(UILabel *)locationLabel{
    if (!_locationLabel) {
        _locationLabel =[[UILabel alloc]init];
        
        
        
        
        
        
        NSLog(@"label%f",_locationLabel.frame.size.height);
        
        
        
        
        
    }
    return _locationLabel;
}


-(void)clickToSearch{
    
    
//    SearchViewController *searchVC =[SearchViewController new];
//    
//    [self.navigationController pushViewController:searchVC animated:YES];

    NSLog(@"点击点位");
    
    
    
}
    
    

-(NSMutableArray *)record{
    
    if (!_record) {
        _record =[NSMutableArray array];
        
    }
    return _record;
    
    
}
@end
