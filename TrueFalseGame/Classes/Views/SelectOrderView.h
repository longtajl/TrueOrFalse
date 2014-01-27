//
//  SelectOrderView.h
//  demoios6
//
//  Created by nagao on 2013/09/02.
//  Copyright (c) 2013年 com.appirits. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatUIKit.h"

@protocol SelectOrderViewDelegate <NSObject>
@optional
- (void)tapFirstButton:(id)sender;
- (void)tapLastButton:(id)sender;
@end

@interface SelectOrderView : UIView

@property (strong, nonatomic) FUIButton *firstButton;
@property (strong, nonatomic) FUIButton *lastButton;
@property (assign, nonatomic) id<SelectOrderViewDelegate> delegate;

@end
