//
//  LFTabsViewController.m
//  tabs
//
//  Created by 李樊 on 16/6/23.
//  Copyright © 2016年 isoushi. All rights reserved.
//
#define LFSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define LFSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "LFTabsViewController.h"

#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
@interface LFTabsViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray *subVCArray;
@property (nonatomic,strong) NSMutableArray *tabsTitleArray;
@property (nonatomic,assign) CGFloat fontSize;
@property (nonatomic,assign) CGFloat spaceBetweenTabs;
@property (nonatomic,assign) CGFloat tabsHeight;
@property (nonatomic,assign) CGFloat pointHeight;
@property (nonatomic,assign) CGFloat scale;
@property (nonatomic,strong) UIColor *pointViewColor;
@property (nonatomic,assign) LFPointViewType type;
@property (nonatomic,assign) CGFloat orValue;
@property (nonatomic,assign) CGFloat ogValue;
@property (nonatomic,assign) CGFloat obValue;

@property (nonatomic,assign) CGFloat srValue;
@property (nonatomic,assign) CGFloat sgValue;
@property (nonatomic,assign) CGFloat sbValue;


@property (nonatomic,strong) LFTabsScrollView *lfTabsScrollView;
@property (nonatomic,strong) UIScrollView *backScrollView;
@property (nonatomic,assign) CGFloat lastContentOffsetX; //上次滑动的偏移量x ,结合当前滑动偏移量得出滑动方向
@property (nonatomic,assign) BOOL isBtnHandle;  //控制pointview是否有动画,点按tabs有动画,滑动子vc 不要动画,不然会造成pointview延迟

@property (nonatomic,assign) CGFloat leftSpace;
@property (nonatomic,assign) CGFloat topSpace;

@property (nonatomic,strong) NSMutableSet *indexSet; //记录已存在的vc.view
@property (nonatomic,assign) BOOL loadNextSubVCWhenScrollDidEnd;
@end

@implementation LFTabsViewController
- (NSSet *)indexSet{
    if (!_indexSet) {
        self.indexSet = [[NSMutableSet alloc] initWithObjects:@0, nil];
    }
    
    return _indexSet;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
[self createLFTabsScrollView];
    [self createBackScrollView]; 
 
}






- (instancetype)initWithSubVCArray:(NSMutableArray *)subVCArray tabsTitleArray:(NSMutableArray *)tabsTitleArray tabsTitleFontSize:(CGFloat)titleFontSize spaceBetweenTabs:(CGFloat)spaceBetweenTabs tabsHeight:(CGFloat)tabsHeight tabsSelectedScale:(CGFloat)scale pointHeight:(CGFloat)pointHeight pointViewColor:(UIColor *)pointViewColor  pointViewType:(LFPointViewType)type leftSpaceBetweenPointViewAndTitleLabel:(CGFloat)leftSpace
topSpaceBetweenPointViewAndTitleLabel:(CGFloat)topSpace loadNextSubVCWhenScrollDidEnd:(BOOL)loadNextSubVCWhenScrollDidEnd
                       tabsOrValue:(CGFloat)orValue tabsOgValue:(CGFloat)ogValue tabsObValue:(CGFloat)obValue tabsSrValue:(CGFloat)srValue tabsSgValue:(CGFloat)sgValue tabsSbValue:(CGFloat)sbValue{
    self = [super init];
    if (self) {
        self.subVCArray = subVCArray;
        self.tabsTitleArray = tabsTitleArray;
        self.fontSize = titleFontSize;
        self.spaceBetweenTabs = spaceBetweenTabs;
        self.tabsHeight = tabsHeight;
        self.scale = scale;
        self.pointHeight = pointHeight;
        self.type = type;
        self.pointViewColor = pointViewColor;
        self.loadNextSubVCWhenScrollDidEnd = loadNextSubVCWhenScrollDidEnd;
        self.orValue = orValue;
        self.ogValue = ogValue;
        self.obValue = obValue;
        
        self.srValue = srValue;
        self.sgValue = sgValue;
        self.sbValue = sbValue;
        self.leftSpace = leftSpace;
        self.topSpace = topSpace;
        
    }
    
    return self;
    
}


- (void)createLFTabsScrollView{
    self.lfTabsScrollView = [[LFTabsScrollView alloc] initWithSuperView:self.view tabsCount:self.subVCArray.count titleArray:self.tabsTitleArray  tabsTitleFontSize:self.fontSize spaceBetweenTabs:self.spaceBetweenTabs tabsHeight:self.tabsHeight  tabsSelectedScale:self.scale pointHeight:self.pointHeight pointViewColor:self.pointViewColor  pointViewType:self.type    leftSpaceBetweenPointViewAndTitleLabel:self.leftSpace topSpaceBetweenPointViewAndTitleLabel:self.topSpace tabsOrValue:self.orValue tabsOgValue:self.ogValue tabsObValue:self.obValue tabsSrValue:self.srValue tabsSgValue:self.sgValue tabsSbValue:self.sbValue];
    __weak typeof(self) weakSelf = self;
    [self.lfTabsScrollView tabBtnClickedCallBackWithIndex:^(NSInteger index) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.isBtnHandle = YES;
//        NSLog(@"%ld",index);
        [strongSelf.backScrollView setContentOffset:CGPointMake(index * LFSCREEN_WIDTH, 0) animated:NO];
        UIViewController *VC =  strongSelf.subVCArray[index];
        if (VC.view.superview != strongSelf.backScrollView) {
            [strongSelf.backScrollView addSubview:VC.view];
            VC.view.sd_layout.leftSpaceToView(strongSelf.backScrollView,index * LFSCREEN_WIDTH).topSpaceToView(strongSelf.backScrollView,0).widthIs(LFSCREEN_WIDTH).heightRatioToView(strongSelf.backScrollView,1);
        }
        [strongSelf.indexSet addObject:[NSNumber numberWithInteger:index]];
        
    }];
      
    self.lfTabsScrollView.didFinishAutoLayoutBlock = ^(CGRect rect){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (LFSCREEN_WIDTH > LFSCREEN_HEIGHT) {
            CGFloat naviHeight =  strongSelf.navigationController.navigationBar.bounds.size.height;
            //如果发现上面的按钮条位置不对,请把下面的naviheight改为0
            strongSelf.lfTabsScrollView.sd_layout.topSpaceToView(strongSelf.view,naviHeight);
            [strongSelf screenRotated];
          }
        else{
            //如果发现上面的按钮条位置不对,请把下面的64改为0
            strongSelf.lfTabsScrollView.sd_layout.topSpaceToView(strongSelf.view,64);
            [strongSelf screenRotated];
         }
    };
 
}
- (void)screenRotated{
    self.backScrollView.contentSize = CGSizeMake(LFSCREEN_WIDTH * self.subVCArray.count, 0);

    for (NSNumber *indexNum in self.indexSet) {
        NSInteger index = [indexNum integerValue];
        UIViewController *vc = self.subVCArray[index];
        vc.view.sd_layout.leftSpaceToView(self.backScrollView,index * LFSCREEN_WIDTH).widthIs(LFSCREEN_WIDTH);
        
        
        
    }
    
    int selectedBtnIndex = 0; //获取处于选择状态的按钮
    UIButton *selectedBtn = nil;
    for (int i = 0; i < self.subVCArray.count; i++) {
        UIButton *tabBtn = [self.lfTabsScrollView viewWithTag:i + 1];
        if (tabBtn.selected) {
            selectedBtnIndex = i;
            selectedBtn = tabBtn;
        }
        
    }
    
    [self.backScrollView setContentOffset:CGPointMake(LFSCREEN_WIDTH * selectedBtnIndex, 0) animated:NO];
    
    self.lfTabsScrollView.handledByAutoRotate = YES;
    [self.lfTabsScrollView handleTabBtnAction:selectedBtn];

}


- (void)createBackScrollView{
    self.backScrollView = [[UIScrollView alloc] init];
    _backScrollView.backgroundColor = [UIColor whiteColor];
    _backScrollView.delegate = self;
    [self.view addSubview:_backScrollView];
    _backScrollView.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(_lfTabsScrollView,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0);
    _backScrollView.pagingEnabled = YES;
    _backScrollView.contentSize = CGSizeMake(LFSCREEN_WIDTH * self.subVCArray.count, 0);
    UIViewController *vc1 = self.subVCArray[0];
    
    [_backScrollView addSubview: vc1.view];
    vc1.view.sd_layout.leftSpaceToView(_backScrollView,0).topSpaceToView(_backScrollView,0).widthIs(LFSCREEN_WIDTH).heightRatioToView(_backScrollView,1);
    
//    self.backScrollView.bounces = NO;
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"scrollView.contentOffset.x = %f",scrollView.contentOffset.x);
    if (!self.loadNextSubVCWhenScrollDidEnd){
    NSInteger dirction = scrollView.contentOffset.x - self.lastContentOffsetX;
    if (!self.isBtnHandle) {
    
    if (dirction > 0) {
//        NSLog(@"向左滑动");
    for (int i = 0; i < self.subVCArray.count - 1; i++) {
    if (i *LFSCREEN_WIDTH < scrollView.contentOffset.x && scrollView.contentOffset.x < (i + 1) *LFSCREEN_WIDTH ) {
        UIViewController *vc =  self.subVCArray[i + 1];
        if (vc.view.superview != _backScrollView) {
            [_backScrollView addSubview:vc.view];
            vc.view.sd_layout.leftSpaceToView(_backScrollView,(i + 1) * LFSCREEN_WIDTH).topSpaceToView(_backScrollView,0).widthIs(LFSCREEN_WIDTH).heightRatioToView(_backScrollView,1);
         }
        [self.indexSet addObject:[NSNumber numberWithInteger:i + 1]];
    
    }
 }
        
    }
    if (dirction < 0) {
//        NSLog(@"向右滑动");
        for (int i = 0; i < self.subVCArray.count - 1; i++) {
            if (i *LFSCREEN_WIDTH < scrollView.contentOffset.x && scrollView.contentOffset.x < (i + 1) *LFSCREEN_WIDTH ) {
                UIViewController *vc =  self.subVCArray[i];
                if (vc.view.superview != _backScrollView) {
                    [_backScrollView addSubview:vc.view];
                    vc.view.sd_layout.leftSpaceToView(_backScrollView,i * LFSCREEN_WIDTH).topSpaceToView(_backScrollView,0).widthIs(LFSCREEN_WIDTH).heightRatioToView(_backScrollView,1);
                }
                [self.indexSet addObject:[NSNumber numberWithInteger:i]];

            
                }
            }
        }
    }
}
    NSInteger passDirection = (scrollView.contentOffset.x - self.lastContentOffsetX) > 0? 0:1;
    if (0 <= scrollView.contentOffset.x && scrollView.contentOffset.x <= LFSCREEN_WIDTH * (self.subVCArray.count -1) ) {
        
    
    if (self.lfTabsScrollView.offsetBlock) {
        if (self.isBtnHandle) {
            [UIView animateWithDuration:0.25 animations:^{
          self.lfTabsScrollView.offsetBlock(scrollView.contentOffset.x / LFSCREEN_WIDTH,passDirection);
        }];
        }
        else{
           self.lfTabsScrollView.offsetBlock(scrollView.contentOffset.x / LFSCREEN_WIDTH,passDirection);
        }
    }
    }
    self.isBtnHandle = NO;
    self.lastContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.isBtnHandle = NO;
    if (self.lfTabsScrollView.endScrollingBlock) {
        self.lfTabsScrollView.endScrollingBlock(scrollView.contentOffset.x / LFSCREEN_WIDTH);
       }
    
    NSLog(@"self.indexSet = %@",self.indexSet);
}

- (void)dealloc{
    NSLog(@"LFTabsViewController dealloc");
 
}



//释放视图内存示例
- (void)freeMemory{
    int selectedBtnIndex = 0; //获取处于选择状态的按钮
    for (int i = 0; i < self.subVCArray.count; i++) {
      UIButton *tabBtn = [self.lfTabsScrollView viewWithTag:i + 1];
        if (tabBtn.selected) {
            selectedBtnIndex = i;
        }
        
    }
    
    for (NSNumber *indexNum in self.indexSet) {
        NSInteger index = [indexNum integerValue]; //已存在的vc.view的下标
        if (index != selectedBtnIndex) {
            UIViewController *vc = self.subVCArray[index];
            [vc.view removeFromSuperview];
             vc.view = nil;
            
        }
        
   }
    
    self.indexSet = [NSMutableSet setWithObjects:[NSNumber numberWithInteger:selectedBtnIndex], nil];
    
    
 
}

- (BOOL)shouldAutorotate{
    
    return YES;
    
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation

{
    return UIInterfaceOrientationPortrait;
    
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations

{
    if (self.shouldAutoRotate) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    else{
        return UIInterfaceOrientationMaskPortrait;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self freeMemory];
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
