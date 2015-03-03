//
//  NavigationController.m
//  chatapp
//
//  Created by Kako on 2015/03/03.
//  Copyright (c) 2015年 Kako. All rights reserved.
//

#import "NavigationController.h"
#import "AppConstant.h"

@implementation NavigationController

- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = HEXCOLOR(0x19C5FF00);
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.translucent = NO;
}

@end
