//
//  UIAlertViewCallback.h
//  demoios6
//
//  Created by nagao on 12/11/07.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UIAlertView+BlocksExtension.h"

@interface UIAlertViewCallback : NSObject <UIAlertViewDelegate> {
    UIAlertViewCallback_t callback;
}

@property (nonatomic, copy) UIAlertViewCallback_t callback;

- (id)initWithCallback:(UIAlertViewCallback_t) callback;

@end