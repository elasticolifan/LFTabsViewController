//
//  CustomView.m
//  tabs
//
//  Created by 李樊 on 16/6/23.
//  Copyright © 2016年 isoushi. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)dealloc{
    NSLog(@"CustomView dealloc");
    
    
}
- (instancetype)initWithFrame:(CGRect)frame VCname:(NSString *)vcName{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = vcName;
        [self addSubview:label];
        
    }
    
    return self;
}


//- (instancetype)initWithVCname:(NSString *)vcName{
//    self = [super init];
//    if (self) {
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        label.text = vcName;
//        [self addSubview:label];
//        
//        
//        
//    }
//    return self;
//    
//}

@end
