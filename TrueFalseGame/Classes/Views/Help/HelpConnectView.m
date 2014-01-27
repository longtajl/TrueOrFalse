//
//  HelpConnectView.m
//  demoios6
//
//  Created by nagao on 2013/09/09.
//  Copyright (c) 2013年 com.appirits. All rights reserved.
//

#import "HelpConnectView.h"
#import "FlatUIKit.h"
#import <QuartzCore/QuartzCore.h>

@interface HelpConnectView ()

@end

@implementation HelpConnectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupDefault];
}

- (void)setupDefault
{
//    self.backgroundColor = [UIColor concreteColor];
    self.label.textColor = [UIColor midnightBlueColor];
    self.label.font      = [UIFont flatFontOfSize:15.f];
    
    CGRect frame = self.imageView.frame;
    frame.size.width  = kImageViewWidth;
    frame.size.height = kImageViewHeight;
    frame.origin.x    = self.frame.size.width/2 - frame.size.width/2;
    frame.origin.y    = self.label.frame.size.height + self.label.frame.origin.y;
    
    self.imageView.frame = frame;
    self.imageView.layer.borderColor = [UIColor silverColor].CGColor;
    self.imageView.layer.borderWidth = 1.f;
}

- (void)didChangeContainerViewOffset:(CGPoint)offset withContainerSize:(CGSize)containerSize
{
    CGFloat positionX = self.imageView.layer.position.x - offset.x;
    CGFloat positionY = self.imageView.layer.position.y;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{ }];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.removedOnCompletion = NO;
    animation.duration  = 0.3;
    animation.fillMode  = kCAFillModeForwards;
    animation.toValue   = [NSValue valueWithCGPoint:CGPointMake(positionX, positionY)];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(positionX, positionY)];
    [self.imageView.layer addAnimation:animation forKey:@"animation"];
    [CATransaction commit];
}

@end
