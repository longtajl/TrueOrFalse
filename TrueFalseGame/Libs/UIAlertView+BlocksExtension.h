//
//  UIAlertView.h
//  demoios6
//
//  Created by nagao on 12/11/07.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

 #import <UIKit/UIKit.h>

@interface UIAlertView (BlocksExtension)

typedef void (^UIAlertViewCallback_t)(NSInteger buttonIndex);

- (id)initWithTitle:(NSString *)title message:(NSString *)message callback:(UIAlertViewCallback_t)callback  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end

