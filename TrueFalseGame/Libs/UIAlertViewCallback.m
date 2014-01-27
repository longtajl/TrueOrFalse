//
//  UIAlertViewCallback.m
//  demoios6
//
//  Created by nagao on 12/11/07.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

#import "UIAlertViewCallback.h"

@implementation UIAlertViewCallback

@synthesize callback;

- (id)initWithCallback:(UIAlertViewCallback_t)aCallback
{
    if (self = [super init]) {
        // コールバックブロックをセット
        self.callback = aCallback;
        
        // 自分自身を保持！
    }
    return self;
}

// UIAlertView の delegate メソッド
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // コールバックを呼ぶ
    if (callback)
        callback(buttonIndex);
    
    // コールバックを呼び終えたら自分自身を解放する！
}


@end