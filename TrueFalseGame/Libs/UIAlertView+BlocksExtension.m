//
//  UIAlertView.m
//  demoios6
//
//  Created by nagao on 12/11/07.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//
#import "UIAlertView+BlocksExtension.h"
#import "UIAlertViewCallback.h"

@implementation UIAlertView(BlocksExtension)

- (id)initWithTitle:(NSString *)title message:(NSString *)message callback:(UIAlertViewCallback_t)callback  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    self = [self initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if(self) {
        // otherButtonTitles, ... を手動でセット
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*)) {
            [self addButtonWithTitle:arg];
        }
        va_end(args);
        
        // delegateにUIAlertViewCallbackをセット
        self.delegate = [[UIAlertViewCallback alloc] initWithCallback:callback];
    }
    return self;
}

@end
