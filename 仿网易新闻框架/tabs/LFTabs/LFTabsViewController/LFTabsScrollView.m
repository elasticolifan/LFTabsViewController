//
//  LFTabsScrollView.m
//  tabs
//
//  Created by 李樊 on 16/6/23.
//  Copyright © 2016年 isoushi. All rights reserved.
//
#define LFSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#import "LFTabsScrollView.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
@interface LFTabsScrollView()
@property (nonatomic,strong) UIView *pointView;
@property (nonatomic,assign) CGFloat pointViewHeight;
@property (nonatomic,assign) NSInteger tabsCount;
@property (nonatomic,strong) NSMutableArray *tabsArray;

@property (nonatomic,assign) CGFloat scale;

@property (nonatomic,assign) CGFloat orValue;
@property (nonatomic,assign) CGFloat ogValue;
@property (nonatomic,assign) CGFloat obValue;

@property (nonatomic,assign) CGFloat srValue;
@property (nonatomic,assign) CGFloat sgValue;
@property (nonatomic,assign) CGFloat sbValue;

@property (nonatomic,assign) CGFloat spaceBetweenTabs;
@property (nonatomic,assign) LFPointViewType type;

@property (nonatomic,assign) CGFloat leftSpace;
@property (nonatomic,assign) CGFloat topSpace;


@end

@implementation LFTabsScrollView

- (void)dealloc{
    NSLog(@"LFTabsScrollView dealloc");
    
}

- (NSMutableArray *)tabsArray{
    if (!_tabsArray) {
        self.tabsArray = [NSMutableArray array];
    }
    return _tabsArray;
    
}
- (instancetype)initWithSuperView:(UIView *)superView tabsCount:(NSInteger )count titleArray:(NSArray *)titleArray  tabsTitleFontSize:(CGFloat)titleFontSize   spaceBetweenTabs:(CGFloat) spaceBetweenTabs tabsHeight:(CGFloat) height  tabsSelectedScale:(CGFloat)scale  pointHeight:(CGFloat)pointHeight pointViewColor:(UIColor *)pointViewColor  pointViewType:(LFPointViewType)type leftSpaceBetweenPointViewAndTitleLabel:(CGFloat)leftSpace topSpaceBetweenPointViewAndTitleLabel:(CGFloat)topSpace tabsOrValue:(CGFloat)orValue tabsOgValue:(CGFloat)ogValue tabsObValue:(CGFloat)obValue tabsSrValue:(CGFloat)srValue tabsSgValue:(CGFloat)sgValue tabsSbValue:(CGFloat)sbValue{
    self = [super init];
    if (self) {
        [superView addSubview:self];
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.scale = scale;
        self.tabsCount = count;
        self.orValue = orValue;
        self.ogValue = ogValue;
        self.obValue = obValue;
        self.srValue = srValue;
        self.sgValue = sgValue;
        self.sbValue = sbValue;
        self.spaceBetweenTabs = spaceBetweenTabs;
        self.type = type;
        self.pointViewHeight = pointHeight;
        self.leftSpace = leftSpace;
        self.topSpace = topSpace;
        if (self.type ==LFPointViewTypeRoundedRectangle) {
            //如果发现上面的按钮条位置不对,请把下面的64改为0
           self.sd_layout.leftSpaceToView(superView,0).topSpaceToView(superView,64).rightSpaceToView(superView,0).heightIs(height);
            
            
        }else{
           //如果发现上面的按钮条位置不对,请把下面的64改为0
            self.sd_layout.leftSpaceToView(superView,0).topSpaceToView(superView,64).rightSpaceToView(superView,0).heightIs(height + pointHeight);
        }
        for (int i = 0; i < count; i++) {
            UIButton *tabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [tabBtn setTitle:titleArray[i] forState:UIControlStateNormal];
            [tabBtn setTitleColor:[UIColor colorWithRed:self.orValue green:self.ogValue blue:self.obValue alpha:1.0] forState:UIControlStateNormal];
            tabBtn.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];

            
            if (i == 0) {
                tabBtn.selected = YES;
                [tabBtn setTitleColor:[UIColor colorWithRed:self.srValue green:self.sgValue blue:self.sbValue alpha:1.0] forState:UIControlStateNormal];
                tabBtn.titleLabel.layer.transform = CATransform3DMakeScale(self.scale, self.scale, self.scale);
            }
            tabBtn.tag = i + 1;
            [self addSubview:tabBtn];
            [tabBtn.titleLabel sizeToFit];
            CGFloat titleLabelWidth = tabBtn.titleLabel.frame.size.width;

            UIButton *lastBtn = [self viewWithTag:i];
            
            tabBtn.sd_layout.leftSpaceToView(lastBtn,0).topSpaceToView(self,0).widthIs(titleLabelWidth + self.spaceBetweenTabs).heightIs(height);
            [tabBtn addTarget:self action:@selector(handleTabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.tabsArray addObject:tabBtn];
        }
         self.pointView = [[UIView alloc] init];
        self.pointView.backgroundColor = pointViewColor;
        [self addSubview:self.pointView];
        [self insertSubview:self.pointView atIndex:0];
        UIButton *firstBtn = [self.tabsArray firstObject];
        if (self.type == LFPointViewTypeRoundedRectangle) {
            
           self.pointView.sd_cornerRadiusFromHeightRatio = @0.5;
            
            CGFloat height = firstBtn.titleLabel.bounds.size.height * self.scale + self.topSpace * 2;
            
            self.pointView.sd_layout.heightIs(height).centerXIs(firstBtn.center.x).centerYIs(firstBtn.center.y);
            
            
            
        }else{
         self.pointView.sd_layout.bottomSpaceToView(self,0).heightIs(pointHeight).centerXIs(firstBtn.center.x);
        }
        _pointView.sd_layout.widthIs(firstBtn.titleLabel.bounds.size.width * self.scale + self.leftSpace * 2);
        [_pointView updateLayout];
        
        
        __weak typeof(self) weakSelf = self;
        self.offsetBlock = ^(CGFloat offset,NSInteger direction){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            [strongSelf animateWithOffset:offset direction:direction];
            

    };
       
        self.endScrollingBlock = ^(CGFloat offset){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSInteger tag = offset + 1;
            if ( 0 < tag && tag <= strongSelf.tabsCount) {
            UIButton *btn = [strongSelf viewWithTag:tag];
            [strongSelf handleTabBtnAction:btn]; 
           
        }
            
            
            
        };
     }
    
    
    return self;
    
}

- (void)animateWithOffset:(CGFloat )offset direction:(NSInteger)direction{
    int index = (int)offset;
    UIButton *leftBtn = nil;
    UIButton *rightBtn = nil;
    if (index  == self.tabsArray.count - 1) { //这时候leftbtn是最后一个
        leftBtn = self.tabsArray[index];
        rightBtn = self.tabsArray[index];
    }
    
    else{
        leftBtn = self.tabsArray[index];
        rightBtn = self.tabsArray[index + 1];
    }
    CGFloat deltaOffset = offset - (int)offset; //deltaOffset 永远是0-1之间
    //pointView中心点动画
    self.pointView.sd_layout.centerXIs(leftBtn.center.x + (rightBtn.center.x - leftBtn.center.x) * deltaOffset);
    
    //标题增大动画
    if (direction == 1 && leftBtn == rightBtn) { //这个判断条件是避免最后一个按钮 在快速滑动vc的时候标题大小抖动
        
    }else{
        
        rightBtn.titleLabel.layer.transform = CATransform3DMakeScale(1 +(self.scale - 1) * deltaOffset, 1 +(self.scale - 1) * deltaOffset, 1 +(self.scale - 1) * deltaOffset);
        leftBtn.titleLabel.layer.transform = CATransform3DMakeScale(1 +(self.scale - 1) * (1 - deltaOffset), 1 +(self.scale - 1) * (1 - deltaOffset), 1 +(self.scale - 1) * (1 - deltaOffset));
        
    }
    
    //颜色动画
    [rightBtn setTitleColor:[UIColor colorWithRed:(self.orValue + (self.srValue - self.orValue) * deltaOffset) green: (self.ogValue + (self.sgValue - self.ogValue) * deltaOffset)blue:(self.obValue + (self.sbValue - self.obValue) * deltaOffset) alpha:1] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor colorWithRed:(self.orValue + (self.srValue - self.orValue) * (1 - deltaOffset)) green: (self.ogValue + (self.sgValue - self.ogValue) * (1 - deltaOffset)) blue:(self.obValue + (self.sbValue - self.obValue) *(1 - deltaOffset)) alpha:1] forState:UIControlStateNormal];
    
    //pointView宽度动画
    
    CGFloat leftWidth = leftBtn.titleLabel.frame.size.width+ self.leftSpace * 2;
    CGFloat rightWidth = rightBtn.titleLabel.frame.size.width + self.leftSpace * 2;
    self.pointView.sd_layout.widthIs(leftWidth + (rightWidth - leftWidth) * deltaOffset);
    
    [self.pointView updateLayout];
//    NSLog(@"pointViewWidth == %f",self.pointView.frame.size.width);
    //pointView高度动画
    if (self.type == LFPointViewTypeRoundedRectangle) {
    
        CGFloat leftHeight = leftBtn.titleLabel.frame.size.height  + self.topSpace * 2;
        CGFloat rightHeight = rightBtn.titleLabel.frame.size.height + self.topSpace * 2;
        self.pointView.sd_layout.heightIs(leftHeight + (rightHeight - leftHeight) * deltaOffset);
        [self.pointView updateLayout];
    }
        //btn宽度动画
        CGFloat rightBtnWidth = rightBtn.titleLabel.frame.size.width + self.spaceBetweenTabs ;
        CGFloat leftBtnWidth = leftBtn.titleLabel.frame.size.width + self.spaceBetweenTabs ;
        
        rightBtn.sd_layout.widthIs(rightBtnWidth);
        leftBtn.sd_layout.widthIs(leftBtnWidth);
        
        CGFloat contentWidth = 0;
        //获取新的contentsize,并把其他btn恢复原始状态
        for (int i = 0; i < self.tabsArray.count; i++) {
            UIButton *btn = self.tabsArray[i];
            contentWidth +=btn.bounds.size.width;
        }
        self.contentSize = CGSizeMake(contentWidth, 0);

    
}




- (void)handleTabBtnAction:(UIButton *)sender{
   if (self.block) {
        self.block(sender.tag - 1);
    }
    CGFloat contentWidth = 0;
    //获取新的contentsize,并把其他btn恢复原始状态
    for (int i = 0; i < self.tabsArray.count; i++) {
        UIButton *btn = self.tabsArray[i];
        if (btn != sender) {
            btn.selected = NO;
            [btn setTitleColor:[UIColor colorWithRed:_orValue green:_ogValue blue:_obValue alpha:1.0] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.25 animations:^{
                btn.titleLabel.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
            }];
            btn.sd_layout.widthIs(btn.titleLabel.bounds.size.width + self.spaceBetweenTabs);
            
        }
   
        contentWidth +=btn.bounds.size.width;
        
    }
    [UIView animateWithDuration:0.25 animations:^{
       self.contentSize = CGSizeMake(contentWidth, 0);
       // [sender updateLayout] 等价于 [self layoutSubviews];
        [self layoutSubviews]; //重新计算contentsize后 需要主动调用layoutsubviews一下,重新计算子view的约束,不然sender.center.x会不准确,造成pointview位置错误
    }];
    
    _pointView.sd_layout.widthIs(sender.titleLabel.bounds.size.width * self.scale + self.leftSpace * 2).centerXIs(sender.center.x);
    
    if (self.handledByAutoRotate) {
        [self.pointView updateLayout];
    }
    else{
    [UIView animateWithDuration:0.25 animations:^{
       [self.pointView updateLayout];
    }];
    }
    self.handledByAutoRotate = NO;
   
    
   
   //偏移到屏幕中心算法
     CGPoint point = CGPointMake(sender.center.x -( LFSCREEN_WIDTH / 2 - (self.frame.origin.x)), 0); //该点保证了每次偏移都在屏幕中心
    
    CGFloat maxContentOffsetX = self.contentSize.width - self.frame.size.width; //最大偏移量
    
    if (point.x <= 0) {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];

    }else if (0 < point.x && point.x< maxContentOffsetX)
    {
        [self setContentOffset: point animated:YES];
        
    }else{
        [self setContentOffset:CGPointMake(maxContentOffsetX, 0) animated:YES];

        
    }

    
   //设置点击后大小和颜色
    [sender setTitleColor:[UIColor colorWithRed:self.srValue green:self.sgValue blue:self.sbValue alpha:1] forState:UIControlStateNormal];
    sender.selected = YES;
    [UIView animateWithDuration:0.25 animations:^{
         sender.titleLabel.layer.transform = CATransform3DMakeScale(self.scale, self.scale, self.scale);
    }];
   
    
}

- (void)tabBtnClickedCallBackWithIndex:(tabBtnClickedBlock) block{
    self.block = block;
 }






@end
