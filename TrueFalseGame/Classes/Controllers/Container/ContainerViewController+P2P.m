//
//  ContainerViewController+P2P.m
//  demoios6
//
//  Created by nagao on 2013/08/26.
//  Copyright (c) 2013年 com.appirits. All rights reserved.
//

#import "ContainerViewController+P2P.h"
#import "ContainerViewController+FUIAlertViewDelegate.h"
#import "KGModal.h"
#import "SelectOrderView.h"

@implementation ContainerViewController (P2P)

#pragma mark - Public Method

- (void)showResult:(BOOL)win
{
    NSString *message = [NSString stringWithFormat:@"あなたの%@です。\n再度ゲームを行いますか？", (win ? @"勝ち" : @"負け")];
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"結果"
                                                          message:message
                                                         delegate:nil
                                                cancelButtonTitle:@"終了"
                                                otherButtonTitles:@"対戦", nil];
    alertView.tag = RESULT;
    alertView.delegate = self;
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont flatFontOfSize:15.f];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14.f];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    [alertView show];
    
    self.alertView = alertView;
}

- (void)askOrder
{
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"確認"
                                                         message:@"接続が完了しました。\n先手or後手を決めてください"
                                                        delegate:nil
                                               cancelButtonTitle:@"後手"
                                               otherButtonTitles:@"先手", nil];
    alertView.tag = ASK_ORDER;
    alertView.delegate = self;
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont flatFontOfSize:15.f];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14.f];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    [alertView show];
    
    self.alertView = alertView;
}

#pragma mark - ConnectionManagerDelegate

- (void)connectionManager:(ConnectionManager *)manager didReceiveData:(NSData *)data fromPeer:(NSString *)peer
{
    [self.boardViewController setConnectStatus:CONNECT];
    [self dismissAlertView];
    
    NSError *error = nil;
    NSMutableDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSString *method = [dataDictionary objectForKey:kDispatchKeyMethod];
    NSString *methodName = [NSString stringWithFormat:@"receiveTo%@%@:", [[method substringToIndex:1] uppercaseString],[method substringFromIndex:1]];
    SEL selector = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:dataDictionary];
    }
}

- (void)connectionManagerDidConnect:(ConnectionManager *)manager
{
    [self askOrder];
    [self.boardViewController setConnectStatus:CONNECT];
}

- (void)connectionManagerDidDisconnect:(ConnectionManager *)manager
{
    AppLog;
    [self.boardViewController setConnectStatus:LOST];
}

- (void)connectionManagerDidConnecting:(ConnectionManager *)manager
{
    AppLog;
}

- (void)connectionManagerDidConnecAvailable:(ConnectionManager *)manager
{
    AppLog;
}

- (void)connectionManagerDidConnecUnavailable:(ConnectionManager *)manager
{
    AppLog;
}

#pragma mark - Private Methods Receive

- (void)receiveToOrder:(NSMutableDictionary *)data
{
    NSString *orderValue = [data objectForKey:kDispatchKeyOrder];
    if (self.boardViewController.gameStatus != SEND_ORDER) {
        [self pushBoardViewController:[orderValue isEqualToString:kFistAttack]];
        [self dispatchFirstMoveData:([orderValue isEqualToString:kFistAttack] ? kSecondAttack : kFistAttack)];
    } else {
        if ([self.boardViewController.order isEqualToString:orderValue]) {
            [self.boardViewController setGameStatus:WAIT];
            [self askOrder];
        } else {
            [self pushBoardViewController:[orderValue isEqualToString:kFistAttack]];
        }
    }
}

- (void)receiveToPut:(NSMutableDictionary *)dictionary
{
    NSMutableArray *boardData = [dictionary objectForKey:kDispatchKeyBoardData];
    [self.boardViewController setReceiveBoardData:boardData];
}

- (void)receiveToFinish:(NSMutableDictionary *)dictionary
{
    [self popBoardViewController];
}

- (void)receiveToRematch:(NSMutableDictionary *)dictionary
{
    [self.boardViewController clear];
    [self askOrder];
}

#pragma mark - Public Methods Dispatch

- (void)dispatchToFinish
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setValue:kDispatchMethodToFinish forKey:kDispatchKeyMethod];
    [self dispatch:data];
}

- (void)dispatchToRematch
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setValue:kDispatchMethodToRematch forKey:kDispatchKeyMethod];
    [self dispatch:data];
}

- (void)dispatchToBoardData:(NSArray *)board selfColor:(NSString *)color
{
    AppLog;
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setValue:kDispatchMethodToPut forKey:kDispatchKeyMethod];
    [data setValue:board forKey:kDispatchKeyBoardData];
    [self dispatch:data];
}

- (void)dispatchFirstMoveData:(NSString *)value
{
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setValue:kDispatchMethodToOrder forKey:kDispatchKeyMethod];
    [data setValue:value forKey:kDispatchKeyOrder];
    [self dispatch:data];
}

- (void)dispatch:(NSDictionary *)dic
{
    NSData *data = nil;
    NSError *error = nil;
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        [self.connectionManager sendDataToAllPeers:data];
    }
}

@end