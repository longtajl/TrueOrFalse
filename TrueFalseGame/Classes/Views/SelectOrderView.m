//
//  SelectOrderView.m
//  demoios6
//
//  Created by nagao on 2013/09/02.
//  Copyright (c) 2013年 com.appirits. All rights reserved.
//

#import "SelectOrderView.h"

@interface SelectOrderView ()

@property (strong, nonatomic) UILabel *titleLabel;

- (void)setUpViews;

@end

@implementation SelectOrderView

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 280, 170)];
    if (self) {
        [self setUpViews];
    }
    return self;
}

#pragma mark - Private Methods

- (void)setUpViews
{
    self.backgroundColor = [UIColor midnightBlueColor];
    
    UILabel *titileLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5,
                                                                    self.frame.size.width,
                                                                     40)];
    titileLabel.text = @"接続が完了しました。\n 先手or後手を決めてください";
    titileLabel.textColor = [UIColor cloudsColor];
    titileLabel.font = [UIFont boldFlatFontOfSize:15.f];
    titileLabel.backgroundColor = [UIColor clearColor];
    titileLabel.numberOfLines = 2;
    titileLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titileLabel;
    [self addSubview:_titleLabel];
    
    FUIButton *firstButton = [[FUIButton alloc] initWithFrame:CGRectMake(15, 55, 250, 44)];
    firstButton.tag = 0;
    firstButton.cornerRadius = 3;
    firstButton.buttonColor = [UIColor cloudsColor];
    firstButton.shadowColor = [UIColor asbestosColor];
    firstButton.titleLabel.textColor = [UIColor asbestosColor];
    firstButton.shadowHeight = 3;
    [firstButton setTitle:@"先手" forState:UIControlStateNormal];
    [firstButton setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
    [firstButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:firstButton];
    self.firstButton = firstButton;
    
    FUIButton *lastButton = [[FUIButton alloc] initWithFrame:CGRectMake(15, 109, 250, 44)];
    lastButton.tag = 1;
    lastButton.cornerRadius = 3;
    lastButton.buttonColor = [UIColor cloudsColor];
    lastButton.shadowColor = [UIColor asbestosColor];
    lastButton.shadowHeight = 3;
    [lastButton setTitle:@"後手" forState:UIControlStateNormal];
    [lastButton setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
    [lastButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lastButton];
    self.lastButton = lastButton;
}

- (void)buttonPressed:(id)sender
{
    if (!_delegate) return;
    FUIButton *button = sender;
    switch (button.tag) {
        case 0: [self.delegate tapFirstButton:sender]; break;
        case 1: [self.delegate tapLastButton:sender];  break;
    }
}

@end
