//
//  BoardView.h
//  demoios6
//
//  Created by nagao on 12/11/07.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoardView : UIView

- (void)setupButtons:(id)target;
- (void)clearColor;
- (void)reflectBoardData:(NSMutableArray *)board;
- (void)showMovePossibleArea:(NSInteger)index board:(NSMutableArray *)board;

@end
