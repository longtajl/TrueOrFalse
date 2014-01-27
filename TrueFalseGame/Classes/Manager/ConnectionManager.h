//
//  ConnectionManager.h
//  demoios6
//
//  Created by nagao on 12/10/26.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@class ConnectionManager;
@protocol ConnectionManagerDelegate <NSObject>

@optional
- (void)connectionManager:(ConnectionManager *)manager didReceiveData:(NSData *)data fromPeer:(NSString *)peer;// データ受信時に呼び出される
- (void)connectionManagerDidConnect:(ConnectionManager *)manager;   // P2P接続完了時に呼び出される
- (void)connectionManagerDidDisconnect:(ConnectionManager *)manager;// P2P接続切断時に呼び出される
- (void)connectionManagerDidConnecting:(ConnectionManager *)manager;// P2P接続中時に呼び出される
- (void)connectionManagerDidConnecAvailable:(ConnectionManager *)manager;// P2P接続できますよ
- (void)connectionManagerDidConnecUnavailable:(ConnectionManager *)manager;// P2P接続できない

@end

@interface ConnectionManager : NSObject <GKPeerPickerControllerDelegate, GKSessionDelegate>

@property (nonatomic, strong) id<ConnectionManagerDelegate> delegate;
@property (nonatomic, assign) BOOL isConnecting;

- (void)connect;
- (void)disconnect;
- (void)sendDataToAllPeers:(NSData *)data;
- (void)sendToPeers:(NSArray *)peers data:(NSData *)data;

@end
