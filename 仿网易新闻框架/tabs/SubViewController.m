//
//  ViewController1.m
//  tabs
//
//  Created by 李樊 on 16/6/23.
//  Copyright © 2016年 isoushi. All rights reserved.
//

#import "SubViewController.h"
#import "CustomView.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "OtherViewController.h"
@interface SubViewController ()

@end

@implementation SubViewController
- (void)dealloc{
    NSLog(@"SubViewController dealloc");

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) /255.0 alpha:1];
    // Do any additional setup after loading the view from its nib.
    
    CustomView *customView = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, 100, 25) VCname:self.vcName];
    customView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:customView];
    customView.sd_layout.centerXEqualToView(self.view).centerYEqualToView(self.view);
    
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [pushBtn setTitle:@"PUSH" forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushToOtherVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
    pushBtn.sd_layout.widthIs(50).heightIs(30).centerXEqualToView(customView).topSpaceToView(customView,20);
    
    
}
- (void)pushToOtherVC{
    OtherViewController *otherVC = [[OtherViewController alloc] init];
    [self.delegateMainVC.navigationController pushViewController:otherVC animated:YES];
    
    
    
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
