//
//  SelectViewController.m
//  遇游邦
//
//  Created by 孙文策 on 16/6/29.
//  Copyright © 2016年 孙文策. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *button;

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title =@"筛选";
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
