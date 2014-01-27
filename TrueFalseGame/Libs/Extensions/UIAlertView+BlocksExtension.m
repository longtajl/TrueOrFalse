//
//  UIAlertView+BlocksExtension.m
//  eCarrierJobSearch
//
//  Created by Appirits on 2013/08/07.
//  Copyright (c) 2013年 appirits. All rights reserved.
//

#import "UIAlertView+BlocksExtension.h"
#import <objc/runtime.h>

@interface NSCBAlertWrapper : NSObject
@property (copy) void(^completionBlock)(UIAlertView *alertView, NSInteger buttonIndex);
@end

@implementation NSCBAlertWrapper

#pragma mark - UIAlertViewDelegate

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.completionBlock)
        self.completionBlock(alertView, buttonIndex);
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView
{
    // Just simulate a cancel button click
    if (self.completionBlock)
        self.completionBlock(alertView, alertView.cancelButtonIndex);
}

@end

static const char kNSCBAlertWrapper;
@implementation UIAlertView (BlocksExtension)

#pragma mark - Public Method

- (void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion
{
    NSCBAlertWrapper *alertWrapper = [[NSCBAlertWrapper alloc] init];
    alertWrapper.completionBlock = completion;
    self.delegate = alertWrapper;
    
    // Set the wrapper as an associated object
    objc_setAssociatedObject(self, &kNSCBAlertWrapper, alertWrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // Show the alert as normal
    [self show];
}

@end


//@interface NSCBFUIAlertWrapper : NSObject
//@property (copy) void(^completionBlock)(FUIAlertView *alertView, NSInteger buttonIndex);
//@end
//
//@implementation NSCBFUIAlertWrapper
//
//#pragma mark - FUIAlertViewDelegate
//
//- (void)alertView:(FUIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@" ........................................... ");
//}
//
//- (void)willPresentAlertView:(FUIAlertView *)alertView
//{
//    
//}
//
//- (void)didPresentAlertView:(FUIAlertView *)alertView
//{
//    
//}
//
//- (void)alertView:(FUIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    
//}
//
//- (void)alertView:(FUIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    
//}
//
//@end
//
//static const char kNSCBFUIAlertWrapper;
//@implementation FUIAlertView (BlocksExtension)
//
//#pragma mark - Public Method
//
//- (void)showWithCompletion:(void(^)(FUIAlertView *alertView, NSInteger buttonIndex))completion
//{
//    NSCBFUIAlertWrapper *alertWrapper = [[NSCBFUIAlertWrapper alloc] init];
//    alertWrapper.completionBlock = completion;
//    self.delegate = alertWrapper;
//    
//    // Set the wrapper as an associated object
//    objc_setAssociatedObject(self, &kNSCBFUIAlertWrapper, alertWrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    // Show the alert as normal
//    [self show];
//}
//
//@end


