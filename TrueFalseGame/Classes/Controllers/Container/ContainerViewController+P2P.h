//
//  ContainerViewController+P2P.h
//  demoios6
//
//  Created by nagao on 2013/08/26.
//  Copyright (c) 2013年 com.appirits. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController (P2P) <SelectOrderViewDelegate>

// alert
- (void)askOrder;
- (void)showResult:(BOOL)win;

// send
- (void)dispatch:(NSDictionary *)dic;
- (void)dispatchToFinish;
- (void)dispatchToRematch;
- (void)dispatchToBoardData:(NSArray *)board selfColor:(NSString *)color;
- (void)dispatchFirstMoveData:(NSString *)value;

@end
