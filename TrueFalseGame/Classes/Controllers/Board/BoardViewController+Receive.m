//
//  BoardViewController+Receive.m
//  demoios6
//
//  Created by nagao on 12/11/07.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

#import "BoardViewController+Receive.h"

@interface BoardViewController(Private)

@end

@implementation BoardViewController(Receive)

- (void)receiveToOrder:(NSMutableDictionary *)dictionary
{
//    NSString *orderValue = [dictionary objectForKey:zConstKeyOrder];
//    if ([orderValue isEqualToString:zConstValueOrderFirst]) {
//        [self setTurn:NO];
//        [self setSelfColor:[NSNumber numberWithInt:zzConstRed]];
//        [self setPlaymateColor:[NSNumber numberWithInt:zzConstBlack]];
//    } else {
//        [self setTurn:YES];
//        [self setSelfColor:[NSNumber numberWithInt:zzConstBlack]];
//        [self setPlaymateColor:[NSNumber numberWithInt:zzConstRed]];
//    }
//    self.gameStatus = PLAYING_;
//    [self.alertView dismissWithClickedButtonIndex:-1 animated:YES];
}

- (void)receiveToPut:(NSMutableDictionary *)dictionary
{
//    [self setTurn:YES];
//    
//    self.board = [dictionary objectForKey:zConstKeyBoardData];
//    [self.boardView reflect:self.board];
//    
//    if ([self lose]) {
//        [self showResult:NO];
//        self.gameStatus = FINISH_;
//    }
}

- (void)receiveToRematch:(NSMutableDictionary *)dictionary
{
//    [self clear];
//    [self.alertView dismissWithClickedButtonIndex:-1 animated:YES];
//    [self askFirstMoveOnAlertView];
}

- (void)receiveToFinish:(NSMutableDictionary *)dictionary
{
    //[self finish];
}

@end
