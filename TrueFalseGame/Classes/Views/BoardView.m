//
//  BoardView.m
//  demoios6
//
//  Created by nagao on 12/11/07.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

#import "BoardView.h"
#import "StoneView.h"
#import "BoardViewController.h"
#import "UIUtil.h"
#import "UIColor+FlatUI.h"

@interface BoardView()
- (NSMutableArray *)movePossibleArea:(NSInteger)index;
@end

@implementation BoardView

#pragma mark  - Public Methods

- (void)setupButtons:(id)target
{
    NSArray *views = [self subviews];
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *v = obj;
        [v setBackgroundColor:[UIColor whiteColor]];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, v.frame.size.width, v.frame.size.height)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:target action:@selector(didTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:target action:@selector(didTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:target action:@selector(didTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [button addTarget:target action:@selector(didTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [button setTag:idx];
        [v addSubview:button];
    }];
}

- (void)reflectBoardData:(NSMutableArray *)board
{
    NSMutableArray *trace = [[NSMutableArray alloc] init];
    for(NSMutableArray *line in board)
        [trace addObjectsFromArray:line];
    
    for (int i=0; i<[trace count]; i++) {
        UIView *view = [[self subviews] objectAtIndex:i];
        [view setBackgroundColor:[UIColor whiteColor]];
        for (UIView *subview in [view subviews]) {
            if (![subview isKindOfClass:[UIButton class]])
                [subview removeFromSuperview];
        }
        
        StoneView *stoneView = [[StoneView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        NSNumber *data = [trace objectAtIndex:i];
        if ([data intValue] == FIRST)
            [stoneView setBackgroundColor:kColorFirst];
        else if ([data intValue] == SECOND)
            [stoneView setBackgroundColor:kColorSecond];
        else
            continue;
        
        [view insertSubview:stoneView atIndex:0];
    }
}

- (void)clearColor
{
    for (UIView *v in [self subviews])
        [v setBackgroundColor:[UIColor whiteColor]];
}

- (void)showMovePossibleArea:(NSInteger)index board:(NSMutableArray *)board
{
    NSMutableArray *permissionArray = [self movePossibleArea:index];
    NSArray *boardviews = [self subviews];
    for (int i=0; i<[boardviews count]; i++) {
        UIView *view = [boardviews objectAtIndex:i];
        NSArray *indexs = [UIUtil convertToIndexs:i];
        NSInteger x = [[indexs objectAtIndex:0] intValue];
        NSInteger y = [[indexs objectAtIndex:1] intValue];
        NSString *string = [[NSString alloc] initWithFormat:@"%i%i", x, y];
        if ([permissionArray containsObject:string]) {
            NSNumber *d = [[board objectAtIndex:x] objectAtIndex:y];
            if ([d intValue] == EMPTY) {
                [view setBackgroundColor:[UIColor tangerineColor]];
                [[board objectAtIndex:x] replaceObjectAtIndex:y withObject:[NSNumber numberWithInt:MOVE]];
            } else {
                [view setBackgroundColor:[UIColor whiteColor]];
            }
        } else {
            [view setBackgroundColor:[UIColor whiteColor]];
        }
    }
}

#pragma mark - Private Methods

- (NSMutableArray *)movePossibleArea:(NSInteger)index
{
    NSMutableArray *permissionArray = [[NSMutableArray alloc] init];
    NSArray *indexs = [UIUtil convertToIndexs:index];
    NSInteger x = [[indexs objectAtIndex:0] intValue];
    NSInteger y = [[indexs objectAtIndex:1] intValue];
    
    NSInteger m[3];
    m[0] = -1; m[1] =  0; m[2] =  1;
    
    for (int i=0; i<3; i++) {
        NSInteger xv = x + m[i];
        for (int j=0; j<3; j++) {
            NSInteger yv = y + m[j];
            if (m[i] == 0 && m[j] == 0)
                continue;
            if (0 <= xv && xv <3 && 0 <= yv && yv < 3) {
                NSString *string = [[NSString alloc] initWithFormat:@"%i%i", xv, yv];
                [permissionArray addObject:string];
            }
        }
    }
    return permissionArray;
}

@end
