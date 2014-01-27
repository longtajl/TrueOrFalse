//
//  BoardViewController+Receive.h
//  demoios6
//
//  Created by nagao on 12/11/07.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//
#import "BoardViewController.h"

@interface BoardViewController (Receive)

- (void)receiveToOrder:(NSMutableDictionary *)dictionary;
- (void)receiveToPut:(NSMutableDictionary *)dictionary;
- (void)receiveToRematch:(NSMutableDictionary *)dictionary;;
- (void)receiveToFinish:(NSMutableDictionary *)dictionary;;

@end
