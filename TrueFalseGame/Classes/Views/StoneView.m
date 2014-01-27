//
//  StoneView.m
//  demoios6
//
//  Created by nagao on 12/10/26.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

#import "StoneView.h"
#import <QuartzCore/QuartzCore.h>


#define constStoneViewWidth  90
#define constStoneViewHeight 90


@implementation StoneView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self setFrame:CGRectMake(5, 5, constStoneViewWidth, constStoneViewHeight)];
    [[self layer] setCornerRadius:constStoneViewWidth/2];
}

@end
