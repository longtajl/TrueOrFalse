//
//  ContainerViewController+FUIAlertViewDelegate.m
//  demoios6
//
//  Created by nagao on 2013/08/30.
//  Copyright (c) 2013年 com.appirits. All rights reserved.
//

#import "ContainerViewController+FUIAlertViewDelegate.h"
#import "ContainerViewController+P2P.h"

@implementation ContainerViewController (FUIAlertViewDelegate)

- (void)alertView:(FUIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case ASK_ORDER: [self didFinishAskAlert:buttonIndex];    break;
        case RESULT:    [self didFinishResultAlert:buttonIndex]; break;
    }
}

- (void)willPresentAlertView:(FUIAlertView *)alertView
{
    AppLog;
}

- (void)didPresentAlertView:(FUIAlertView *)alertView
{
    AppLog;
}

- (void)alertView:(FUIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    AppLog;
}

- (void)alertView:(FUIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    AppLog;
}

#pragma mark - Private Methods

- (void)didFinishAskAlert:(NSInteger)buttonIndex
{
    NSString *order = kFistAttack;
    switch (buttonIndex) {
        case 1: order = kFistAttack;   break;
        case 0: order = kSecondAttack; break;
    }
    [self.boardViewController setGameStatus:SEND_ORDER];
    [self dispatchFirstMoveData:([order isEqualToString:kFistAttack] ? kSecondAttack : kFistAttack)];
}

- (void)didFinishResultAlert:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self dispatchToFinish];
            [self popBoardViewController];
            break;
        case 1:
            [self.boardViewController clear];
            [self askOrder];
            [self dispatchToRematch];
            break;
    }
}

@end
