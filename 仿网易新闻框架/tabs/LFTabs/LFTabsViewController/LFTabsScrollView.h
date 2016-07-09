//
//  LFTabsScrollView.h
//  tabs
//
//  Created by 李樊 on 16/6/23.
//  Copyright © 2016年 isoushi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LFPointViewType) {
    LFPointViewTypeLine = 0,
    LFPointViewTypeRoundedRectangle   = 1,

};

typedef void(^tabBtnClickedBlock)(NSInteger index);
typedef void(^contentOffsetChangeBlock)(CGFloat offset,NSInteger direction);// 0左滑,1右滑
typedef void(^backScrollViewEndScrollingBlock)(CGFloat offset);
@interface LFTabsScrollView : UIScrollView
@property (nonatomic,copy)  tabBtnClickedBlock block;
@property (nonatomic,copy)  contentOffsetChangeBlock offsetBlock;
@property (nonatomic,copy)  backScrollViewEndScrollingBlock endScrollingBlock;

- (instancetype)initWithSuperView:(UIView *)superView tabsCount:(NSInteger )count titleArray:(NSArray *)titleArray  tabsTitleFontSize:(CGFloat)titleFontSize   spaceBetweenTabs:(CGFloat) spaceBetweenTabs tabsHeight:(CGFloat) height  tabsSelectedScale:(CGFloat)scale  pointHeight:(CGFloat)pointHeight pointViewColor:(UIColor *)pointViewColor  pointViewType:(LFPointViewType)type
leftSpaceBetweenPointViewAndTitleLabel:(CGFloat)leftSpace
topSpaceBetweenPointViewAndTitleLabel:(CGFloat)topSpace
                      tabsOrValue:(CGFloat)orValue tabsOgValue:(CGFloat)ogValue tabsObValue:(CGFloat)obValue tabsSrValue:(CGFloat)srValue tabsSgValue:(CGFloat)sgValue tabsSbValue:(CGFloat)sbValue;


- (void)tabBtnClickedCallBackWithIndex:(tabBtnClickedBlock) block;
- (void)handleTabBtnAction:(UIButton *)sender;
@property (nonatomic,assign) BOOL handledByAutoRotate; //由自动旋转触发
@end
