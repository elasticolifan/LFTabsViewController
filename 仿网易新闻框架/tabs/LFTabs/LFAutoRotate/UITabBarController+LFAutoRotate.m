//
//  UITabBarController+AutoRotate.m
//  sdautolayouttest3
//
//  Created by 李樊 on 16/5/23.
//  Copyright © 2016年 isoushi. All rights reserved.
//

#import "UITabBarController+LFAutoRotate.h"

@implementation UITabBarController (LFAutoRotate)
- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
