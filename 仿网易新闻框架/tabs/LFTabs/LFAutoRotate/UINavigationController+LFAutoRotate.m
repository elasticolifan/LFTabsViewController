//
//  UINavigationController+AutoRotate.m
//  sdautolayouttest3
//
//  Created by 李樊 on 16/5/23.
//  Copyright © 2016年 isoushi. All rights reserved.
//

#import "UINavigationController+LFAutoRotate.h"

@implementation UINavigationController (LFAutoRotate)


- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

@end
