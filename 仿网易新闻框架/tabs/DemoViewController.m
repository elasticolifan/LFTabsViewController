//
//  TestViewController.m
//  tabs
//
//  Created by 李樊 on 16/6/24.
//  Copyright © 2016年 isoushi. All rights reserved.
//

#import "DemoViewController.h"
#import "SubViewController.h"
#import "LFTabsViewController.h"
@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *roundedRectangleTypeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    roundedRectangleTypeBtn.frame = CGRectMake(0, 0,100, 50);
    roundedRectangleTypeBtn.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 - 20);
    [roundedRectangleTypeBtn setTitle:@"圆角矩形样式" forState:UIControlStateNormal];
    [self.view addSubview:roundedRectangleTypeBtn];
    [roundedRectangleTypeBtn addTarget:self action:@selector(handleroundedRectangleTypeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *lineTypeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    lineTypeBtn.frame = CGRectMake(0, 0,100, 50);
    lineTypeBtn.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 + 30);
    [lineTypeBtn setTitle:@"线型样式" forState:UIControlStateNormal];
    [self.view addSubview:lineTypeBtn];
    [lineTypeBtn addTarget:self action:@selector(handleLineTypeBtnAction) forControlEvents:UIControlEventTouchUpInside];

    
    
    

}
- (void)handleroundedRectangleTypeBtnAction{
    
    SubViewController *vc1 = [[SubViewController alloc] init];
    vc1.vcName = @"控制器1";
    SubViewController *vc2 = [[SubViewController alloc] init];
    vc2.vcName = @"控制器2";
    SubViewController *vc3 = [[SubViewController alloc] init];
    vc3.vcName = @"控制器3";
    SubViewController *vc4 = [[SubViewController alloc] init];
    vc4.vcName = @"控制器4";
    SubViewController *vc5 = [[SubViewController alloc] init];
    vc5.vcName = @"控制器5";
    SubViewController *vc6 = [[SubViewController alloc] init];
    vc6.vcName = @"控制器6";
    SubViewController *vc7 = [[SubViewController alloc] init];
    vc7.vcName = @"控制器7";
    SubViewController *vc8 = [[SubViewController alloc] init];
    vc8.vcName = @"控制器8";
    SubViewController *vc9 = [[SubViewController alloc] init];
    vc9.vcName = @"控制器9";
    SubViewController *vc10 = [[SubViewController alloc] init];
    vc10.vcName = @"控制器10";
    SubViewController *vc11= [[SubViewController alloc] init];
    vc11.vcName = @"控制器11";
    SubViewController *vc12 = [[SubViewController alloc] init];
    vc12.vcName = @"控制器12";
    SubViewController *vc13 = [[SubViewController alloc] init];
    vc13.vcName = @"控制器13";
    SubViewController *vc14 = [[SubViewController alloc] init];
    vc14.vcName = @"控制器14";
    SubViewController *vc15 = [[SubViewController alloc] init];
    vc15.vcName = @"控制器15";
    SubViewController *vc16 = [[SubViewController alloc] init];
    vc16.vcName = @"控制器16";
    
    
    NSMutableArray *subVCArr = [NSMutableArray arrayWithArray:@[vc1,vc2,vc3,vc4,vc5,vc6,vc7,vc8,vc9,vc10,vc11,vc12,vc13,vc14,vc15,vc16]];
    
    NSMutableArray *tabsTitleArray = [NSMutableArray arrayWithArray:@[@"按钮按钮1",@"按钮按钮2",@"按钮按钮3",@"按钮钮钮4",@"按钮按钮按钮5",@"按钮6",@"按钮按钮7",@"按钮按8",@"按钮按钮9",@"按钮按钮10",@"按钮按11",@"按钮按钮12",@"按钮按钮按钮13",@"按钮14",@"按钮15",@"按钮16"]];
    LFTabsViewController *LFTabsVC = [[LFTabsViewController alloc]
                                      initWithSubVCArray:subVCArr tabsTitleArray:tabsTitleArray tabsTitleFontSize:13 spaceBetweenTabs:25 tabsHeight:50 tabsSelectedScale:1.3 pointHeight:1000 pointViewColor:[UIColor orangeColor] pointViewType:LFPointViewTypeRoundedRectangle leftSpaceBetweenPointViewAndTitleLabel:5
                                        topSpaceBetweenPointViewAndTitleLabel:5
                                      loadNextSubVCWhenScrollDidEnd:NO
                                        tabsOrValue:59 / 255.0 tabsOgValue:69 / 255.0 tabsObValue:80 / 255.0 tabsSrValue:94 / 255.0 tabsSgValue:205 / 255.0  tabsSbValue:122 / 255.0];
    LFTabsVC.shouldAutoRotate = YES;
    //设置子控制器的代理主控制器
    for (UIViewController *VC in subVCArr) {
        SubViewController *subVC = (SubViewController *)VC;
        subVC.delegateMainVC = LFTabsVC;
     }
    
    
    
    [self.navigationController pushViewController:LFTabsVC animated:YES];
}


- (void)handleLineTypeBtnAction{
    
    SubViewController *vc1 = [[SubViewController alloc] init];
    vc1.vcName = @"控制器1";
    SubViewController *vc2 = [[SubViewController alloc] init];
    vc2.vcName = @"控制器2";
    SubViewController *vc3 = [[SubViewController alloc] init];
    vc3.vcName = @"控制器3";
    SubViewController *vc4 = [[SubViewController alloc] init];
    vc4.vcName = @"控制器4";
    SubViewController *vc5 = [[SubViewController alloc] init];
    vc5.vcName = @"控制器5";
    SubViewController *vc6 = [[SubViewController alloc] init];
    vc6.vcName = @"控制器6";
    SubViewController *vc7 = [[SubViewController alloc] init];
    vc7.vcName = @"控制器7";
    SubViewController *vc8 = [[SubViewController alloc] init];
    vc8.vcName = @"控制器8";
    SubViewController *vc9 = [[SubViewController alloc] init];
    vc9.vcName = @"控制器9";
    SubViewController *vc10 = [[SubViewController alloc] init];
    vc10.vcName = @"控制器10";
    SubViewController *vc11= [[SubViewController alloc] init];
    vc11.vcName = @"控制器11";
    SubViewController *vc12 = [[SubViewController alloc] init];
    vc12.vcName = @"控制器12";
    SubViewController *vc13 = [[SubViewController alloc] init];
    vc13.vcName = @"控制器13";
    SubViewController *vc14 = [[SubViewController alloc] init];
    vc14.vcName = @"控制器14";
    SubViewController *vc15 = [[SubViewController alloc] init];
    vc15.vcName = @"控制器15";
    SubViewController *vc16 = [[SubViewController alloc] init];
    vc16.vcName = @"控制器16";
    
    
    NSMutableArray *subVCArr = [NSMutableArray arrayWithArray:@[vc1,vc2,vc3,vc4,vc5,vc6,vc7,vc8,vc9,vc10,vc11,vc12,vc13,vc14,vc15,vc16]];
    
    NSMutableArray *tabsTitleArray = [NSMutableArray arrayWithArray:@[@"按钮按钮1",@"按钮按钮2",@"按钮按钮3",@"按钮钮钮4",@"按钮按钮按钮5",@"按钮6",@"按钮按钮7",@"按钮按8",@"按钮按钮9",@"按钮按钮10",@"按钮按11",@"按钮按钮12",@"按钮按钮按钮13",@"按钮14",@"按钮15",@"按钮16"]];
    LFTabsViewController *LFTabsVC = [[LFTabsViewController alloc]
                                      initWithSubVCArray:subVCArr tabsTitleArray:tabsTitleArray tabsTitleFontSize:13 spaceBetweenTabs:25 tabsHeight:50 tabsSelectedScale:1.3 pointHeight:3 pointViewColor:[UIColor orangeColor] pointViewType:LFPointViewTypeLine leftSpaceBetweenPointViewAndTitleLabel:5
                                      topSpaceBetweenPointViewAndTitleLabel:10
                                      loadNextSubVCWhenScrollDidEnd:YES
                                      tabsOrValue:59 / 255.0 tabsOgValue:69 / 255.0 tabsObValue:80 / 255.0 tabsSrValue:94 / 255.0 tabsSgValue:205 / 255.0  tabsSbValue:122 / 255.0];
    LFTabsVC.shouldAutoRotate = YES;
   //设置子控制器的代理主控制器
    for (UIViewController *VC in subVCArr) {
        SubViewController *subVC = (SubViewController *)VC;
        subVC.delegateMainVC = LFTabsVC;
    }

    
   
    
    
    [self.navigationController pushViewController:LFTabsVC animated:YES];
        
  
    
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
