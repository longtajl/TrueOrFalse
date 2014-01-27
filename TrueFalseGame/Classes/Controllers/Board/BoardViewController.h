//
//  BoardViewController.h
//  demoios6
//
//  Created by nagao on 12/11/02.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionManager.h"
#import "BoardView.h"
#import "AppDefinition.h"

#define zConstBoardRow  3

@interface BoardViewController : UIViewController <ConnectionManagerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *board;
@property (nonatomic, strong) NSString *order;
@property (nonatomic, assign) NSInteger gameStatus;
@property (nonatomic, assign) BOOL isMove;
@property (nonatomic, assign) BOOL turn;

- (BOOL)win;
- (BOOL)lose;
- (void)clear;
- (void)setUp:(BOOL)isFirstMover;
- (void)setReceiveBoardData:(NSMutableArray *)data;
- (void)setConnectStatus:(NSInteger)status;
- (void)showHeaderViewAtAnimation;

@end
