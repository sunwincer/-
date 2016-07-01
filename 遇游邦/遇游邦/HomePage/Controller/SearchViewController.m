
//
//  SearchViewController.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/29.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "SearchViewController.h"
#import "UIView+YYBExtension.h"
#import "ResultViewController.h"

@interface SearchViewController ()
@property (nonatomic,strong) UIView *backgroudView;
@property(nonatomic,strong) UIImageView *searchImageView;
@property(nonatomic,strong) UITextField * textFiled;
@property(nonatomic,strong) UIButton * searchButton;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor =[UIColor whiteColor];
    [self setupNavigation];
}
-(void)setupNavigation{
    
    self.searchButton =[UIButton buttonWithType:0];
    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchButton setTintColor:kRGBColor(250, 250, 250)];
    self.searchButton.size =CGSizeMake(30, 21);
    self.searchButton.titleLabel.font =[UIFont systemFontOfSize:15];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.searchButton];
    [self.searchButton addTarget:self action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];
   
    
    
    
    self.backgroudView=[UIView new];
    self.backgroudView.backgroundColor =kRGBColor(247, 247, 247);
    self.backgroudView.frame =CGRectMake(43, 27, kWindowW-103, 30);
    self.backgroudView.layer.cornerRadius= 4;
    self.navigationItem.titleView=self.backgroudView;
    self.searchImageView =[[UIImageView alloc]init];
    [self.backgroudView addSubview:self.searchImageView];
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-7);
        make.width.mas_equalTo(16);
    }];
    self.searchImageView.image =[UIImage imageNamed:@"搜索"];
    
    
    
    
    
    UITextField * textFiled =[[UITextField alloc]init];
    [self.backgroudView addSubview:textFiled];
    [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(32);
        make.right.mas_equalTo(-32);
    }];
    
    
    textFiled.font =[UIFont systemFontOfSize:13];
    textFiled.textColor=kRGBColor(184, 184, 184);
    textFiled.textAlignment=NSTextAlignmentLeft;
    textFiled.placeholder =@"搜索目的地/用户昵称/内容关键词";
    self.textFiled=textFiled;
    
    
    
    
    
    
    
    
    
    
    
}

-(void)clickToSearch{
    
    NSLog(@"开始搜索");
    ResultViewController * vc =[[ResultViewController alloc]init];
    
    vc.title =self.textFiled.text;

    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
