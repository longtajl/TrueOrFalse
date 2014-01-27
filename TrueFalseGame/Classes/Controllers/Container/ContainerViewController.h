//
//  TopViewController.h
//  demoios6
//
//  Created by nagao on 2013/08/23.
//  Copyright (c) 2013年 com.appirits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "FlatUIKit.h"
#import "ConnectionManager.h"
#import "BoardViewController.h"
#import "SelectOrderView.h"

@interface ContainerViewController : UIViewController

@property (strong, nonatomic) FUIAlertView *alertView;
@property (strong, nonatomic) SelectOrderView *selectOrderView;
@property (strong, nonatomic) ConnectionManager *connectionManager;
@property (strong, nonatomic) BoardViewController *boardViewController;

- (void)pushBoardViewController:(BOOL)isFirstMover;
- (void)popBoardViewController;

- (void)dismissAlertView;

@end
