//
//  ViewController1.h
//  tabs
//
//  Created by 李樊 on 16/6/23.
//  Copyright © 2016年 isoushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubViewController : UIViewController
@property (nonatomic,copy) NSString *vcName;
@property (nonatomic,weak) UIViewController *delegateMainVC;
@end
