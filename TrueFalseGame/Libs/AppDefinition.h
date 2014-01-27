//
//  AppDefinition.h
//  demoios6
//
//  Created by nagao on 2013/08/26.
//  Copyright (c) 2013年 com.appirits. All rights reserved.
//
#import "UIColor+FlatUI.h"

/*******************************************
  Dispatch Methods Name
********************************************/
static NSString * const kDispatchMethodToPut      = @"put";
static NSString * const kDispatchMethodToOrder    = @"order";
static NSString * const kDispatchMethodToRematch  = @"rematch";
static NSString * const kDispatchMethodToFinish   = @"finish";
static NSString * const kDispatchMethodToOrderAsk = @"orderAsk";


/******************************************
  Dispatch Data Values Key
*******************************************/
static NSString * const kDispatchKeyMethod        = @"key_method";
static NSString * const kDispatchKeyBoardData     = @"key_boarddata";
static NSString * const kDispatchKeyPlaymateColor = @"key_playmatecolor";
static NSString * const kDispatchKeyOrder         = @"key_order";


/******************************************
 Game Const
*******************************************/
static NSString * const kFistAttack   = @"0";
static NSString * const kSecondAttack = @"1";


/*******************************************
 Board Mass Status
********************************************/
enum {
    EMPTY,
    FIRST,
    SECOND,
    MOVE,
} BOARD_MAS_STATUS;

/*******************************************
 Game Status
*********************************************/
enum {
    WAIT = 0,
    SEND_ORDER,
    PLAYING,
    FINISH,
}GAME_STATUS;

/*******************************************
 P2P Status 
********************************************/
enum {
    CONNECT,
    LOST,
}P2P_STATUS;

/*********************************************
 Message 
 *********************************************/
static NSString * const kConnectMessage     = @"接続中";
static NSString * const kLostconnectMessage = @"接続が中断されました";

// Color
#define kColorFirst  [UIColor pomegranateColor]
#define kColorSecond [UIColor nephritisColor]
#define kColorTouchDownColor [UIColor colorWithRed:0.15f green:0.15f blue:0.15f alpha:0.50f]
