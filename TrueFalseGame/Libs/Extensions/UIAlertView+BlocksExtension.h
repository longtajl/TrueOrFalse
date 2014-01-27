//
//  UIAlertView+BlocksExtension.h
//  eCarrierJobSearch
//
//  Created by Appirits on 2013/08/07.
//  Copyright (c) 2013年 appirits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FUIAlertView.h"

@interface UIAlertView (BlocksExtension)
- (void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion;
@end

//@interface FUIAlertView (BlocksExtension)
//- (void)showWithCompletion:(void(^)(FUIAlertView *alertView, NSInteger buttonIndex))completion;
//@end
