//
//  ConnectionManager.m
//  demoios6
//
//  Created by nagao on 12/10/26.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

#import "ConnectionManager.h"

@interface ConnectionManager () {
    
}


@property (strong, nonatomic) GKSession *currentSession;

@end

@implementation ConnectionManager


#pragma mark - GKPeerPickerControllerDelegate methods


- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type
{
    GKSession *session = [[GKSession alloc] initWithSessionID:@"123456789123421322２6789123456789" displayName:nil sessionMode:GKSessionModePeer];
    return session;
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    self.currentSession = session;
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
    
    // piclerを削除
    picker.delegate = nil;
    [picker dismiss];
}

- (void)peerPickerController:(GKPeerPickerController *)picker didSelectConnectionType:(GKPeerPickerConnectionType)type
{
    picker.delegate = nil;
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    AppLog;
}


#pragma mark - GKSession methods

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    NSLog(@" displayName >> %@  ", session.displayName);
    NSLog(@" displayName >>> %@", [session displayNameForPeer:peerID]);
    
    switch (state) {
        case GKPeerStateAvailable:
            NSLog(@"- GKPeerStateAvailable　-");
            [self.delegate connectionManagerDidConnecAvailable:self];
            //[_currentSession connectToPeer:peerID withTimeout:10];
            break;
            
        case GKPeerStateUnavailable:
            NSLog(@"- GKPeerStateUnavailable　-");
            [self.delegate connectionManagerDidConnecUnavailable:self];
            break;
            
        case GKPeerStateConnecting:
            NSLog(@"- GKPeerStateConnecting　-");
            [self.delegate connectionManagerDidConnecting:self];
            break;
            
        case GKPeerStateConnected:
            NSLog(@"- GKPeerStateConnected　-");
            self.isConnecting = YES;
            [self.delegate connectionManagerDidConnect:self];
            break;
            
        case GKPeerStateDisconnected:
            NSLog(@"- GKPeerStateDisconnected　-");
            self.currentSession = nil;
            self.isConnecting = NO;
            [self.delegate connectionManagerDidDisconnect:self];
            break;
            
        default:
            break;
    }
}

-(void)session:(GKSession*) session didReceiveConnectionRequestFromPeer:(NSString*) peerID
{
    AppLog;
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
{
    AppLog;
    [self.delegate connectionManager:self didReceiveData:data fromPeer:peer];
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
    AppLog;
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error
{
    AppLog;
}


#pragma mark - Public methods


- (void)connect
{
    GKPeerPickerController *picker = [[GKPeerPickerController alloc] init];
    picker.delegate = self;
    picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    [picker show];
}

- (void)disconnect
{
    if (_currentSession) {
        [_currentSession disconnectFromAllPeers];
        self.currentSession = nil;
    }
    self.isConnecting = NO;
}

- (void)sendDataToAllPeers:(NSData *)data
{
    if (_currentSession) {
        NSError *error = nil;
        [_currentSession sendDataToAllPeers:data withDataMode:GKSendDataReliable error:&error];
        if (error)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

- (void)sendToPeers:(NSArray *)peers data:(NSData *)data
{
    if (_currentSession) {
        NSError *error = nil;
        [_currentSession sendData:data toPeers:peers withDataMode:GKSendDataReliable error:&error];
        if (error)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

@end
