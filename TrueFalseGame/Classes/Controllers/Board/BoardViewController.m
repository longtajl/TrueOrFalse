//
//  BoardViewController.m
//  demoios6
//
//  Created by nagao on 12/11/02.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

#import "BoardViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "StoneView.h"
#import "UIUtil.h"
#import "ContainerViewController.h"
#import "ContainerViewController+P2P.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"

@interface BoardViewController ()

@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet BoardView *boardView;
@property (nonatomic, weak) IBOutlet UILabel *connectStatusLabel;
@property (nonatomic, weak) IBOutlet UILabel *turnLabel;
@property (nonatomic, weak) IBOutlet UIView  *colorView;
@property (nonatomic, assign) NSInteger selectX;
@property (nonatomic, assign) NSInteger selectY;

@end

@implementation BoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor       = [UIColor cloudsColor];
    self.headerView.backgroundColor = self.view.backgroundColor;
    self.boardView.backgroundColor  = [UIColor midnightBlueColor];
    
    self.turnLabel.textColor = [UIColor midnightBlueColor];
    self.turnLabel.font = [UIFont boldFlatFontOfSize:14.f];
    self.connectStatusLabel.textColor = [UIColor midnightBlueColor];
    self.connectStatusLabel.font = [UIFont boldFlatFontOfSize:14.f];
    
    [self setupBoardView];
    
     self.gameStatus = WAIT;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setTurnLabelText];
    [self setTurnColor];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
}

#pragma mark - Handler Methods

- (void)didTouchDown:(id)sender
{
    if (self.turn) {
        UIButton *button = sender;
        [button setBackgroundColor:kColorTouchDownColor];
    }
}

- (void)didTouchUpInside:(id)sender
{
    UIButton *button = sender;
    [button setBackgroundColor:[UIColor clearColor]];
    
    if (!self.turn)
        return;
    
    if (!self.parentController.connectionManager.isConnecting)
        return;
    
    [self tapBoardView:button.tag];
}

- (void)didTouchUpOutside:(id)sender
{
    UIButton *button = sender;
    [button setBackgroundColor:[UIColor clearColor]];
}

- (void)didTouchCancel:(id)sender
{
    UIButton *button = sender;
    [button setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - Private Methods

- (void)setTurn:(BOOL)turn
{
    _turn = turn;
    [self setTurnLabelText];
    [self setTurnColor];
}

- (UIColor *)myColor
{
    if ([self.order isEqualToString:kFistAttack])
        return kColorFirst;
    else
        return kColorSecond;
}

- (UIColor *)enemyColor
{
    if ([self.order isEqualToString:kFistAttack])
        return kColorSecond;
    else
        return kColorFirst;
}

- (NSNumber *)myOrder
{
    if ([self.order isEqualToString:kFistAttack])
        return [NSNumber numberWithInteger:FIRST];
    else
        return [NSNumber numberWithInteger:SECOND];
}

- (NSNumber *)enemyOrder
{
    if ([self.order isEqualToString:kFistAttack])
        return [NSNumber numberWithInteger:SECOND];
    else
        return [NSNumber numberWithInteger:FIRST];
}

- (void)setupBoardView
{
    [self initBoardData];
    [self.boardView reflectBoardData:_board];
    [self.boardView setupButtons:self];
}

- (void)initBoardData
{
    NSMutableArray *board = [[NSMutableArray alloc] init];
    for (int i=0; i<zConstBoardRow; i++) {
        NSMutableArray *line = [[NSMutableArray alloc] init];
        [board addObject:line];
        for (int j=0; j<zConstBoardRow; j++) {
            NSNumber *number = [[NSNumber alloc] initWithInt:EMPTY];
            [line addObject:number];
        }
    }
    self.board = board;
}

- (void)setTurnLabelText
{
    if (_gameStatus == PLAYING) {
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationCurveEaseIn
                         animations:^{
                             self.turnLabel.text = self.turn ? @"あなたの番です" : @"相手の番です";
                         }
                         completion:^(BOOL finished) {
                                
                         }];
    }
}

- (void)tapBoardView:(NSInteger)index
{
    if (_gameStatus != PLAYING) {
        return;
    }
    
    NSArray *indexs = [UIUtil convertToIndexs:index];
    NSInteger x = [[indexs objectAtIndex:0] intValue];
    NSInteger y = [[indexs objectAtIndex:1] intValue];
    NSNumber *currentData = [[self.board objectAtIndex:x] objectAtIndex:y];
    if ([self isLimitMyColor]) {
        if ([currentData intValue] == EMPTY) {
            NSMutableArray *line = [self.board objectAtIndex:x];
            [line replaceObjectAtIndex:y withObject:self.myOrder];
        } else {
            return;
        }
    } else {
        if (_isMove) {
            if ([currentData intValue] == MOVE) {
                NSMutableArray *line = [self.board objectAtIndex:x];
                [line replaceObjectAtIndex:y withObject:self.myOrder];
                NSMutableArray *rline = [self.board objectAtIndex:_selectX];
                [rline replaceObjectAtIndex:_selectY withObject:[NSNumber numberWithInt:EMPTY]];
                [self moveComplete];
            } else if ([currentData intValue] == [self.myOrder intValue]) {
                _selectX = x;
                _selectY = y;
                [self clearMoveBoardData];
                [self showMovePossibleBoardView:index];
                return;
            } else {
                return;
            }
        } else {
            if ([currentData intValue] == [self.myOrder intValue]) {
                _selectX = x;
                _selectY = y;
                [self showMovePossibleBoardView:index];
            }
            return;
        }
    }
    
    [self.boardView reflectBoardData:_board];
    [[self parentController] dispatchToBoardData:_board selfColor:[self.myOrder stringValue]];
    
    if ([self win]) {
        self.gameStatus = FINISH;
        [[self parentController] showResult:YES];
        return;
    }

    [self setTurn:NO];
}

- (void)moveComplete
{
    _isMove = NO;
    [self.boardView clearColor];
    [self clearMoveBoardData];
}

- (void)showMovePossibleBoardView:(NSInteger)index
{
    [self.boardView clearColor];
    [self.boardView showMovePossibleArea:index board:_board];
    _isMove = YES;
}

- (BOOL)isLimitMyColor
{
    if ([self myColorCount] < 3) {
        return YES;
    }
    return NO;
}

- (NSInteger)myColorCount
{
    NSInteger count = 0;
    for (NSMutableArray *line in self.board) {
        for (NSNumber *d in line) {
            if (d == self.myOrder)
                count++;
        }
    }
    return count;
}

- (void)clearMoveBoardData
{
    for (int i=0; i<[self.board count]; i++) {
        NSMutableArray *line = [self.board objectAtIndex:i];
        for (int j=0; j<[line count]; j++) {
            NSNumber *number = [line objectAtIndex:j];
            if ([number intValue] == MOVE) {
                [[self.board objectAtIndex:i] replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:EMPTY]];
            }
        }
    }
}

- (BOOL)decide:(NSNumber *)color
{
    int count = 0;
    
    // 横
    for (NSMutableArray *line in self.board) {
        count = 0;
        for (NSNumber *d in line) {
            if (d == color) {
                count++;
            }
        }
        if (count == 3) {
            return YES;
        }
    }
    
    // 縦判定
    count = 0;
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            NSMutableArray *line = [self.board objectAtIndex:j];
            NSNumber *d = [line objectAtIndex:i];
            if (d == color)
                count++;
        }
        if (count == 3) {
            return YES;
        } else {
            count = 0;
        }
    }
    
    count = 0;
    for (int i=0; i<3; i++) {
        NSMutableArray *line = [self.board objectAtIndex:i];
        NSNumber *d = [line objectAtIndex:i];
        if (d == color)
            count++;
    }
    if (count == 3) {
        return YES;
    }
    
    count = 0;
    for (int i=0; i<3; i++) {
        NSMutableArray *line = [self.board objectAtIndex:i];
        NSNumber *d = [line objectAtIndex:2-i];
        if (d == color)
            count++;
    }
    if (count == 3) {
        return YES;
    }
    
    return NO;
}

- (void)clearBoardData
{
    for (NSMutableArray *line in self.board) {
        for (int i=0; i<[line count]; i++) 
            [line replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:EMPTY]];
    }
}

- (void)setTurnColor
{
    [[self.colorView layer] setCornerRadius:_colorView.frame.size.width/2];
    
    void (^ _animation )(void) = ^(void) {
        if (self.turn)
            self.colorView.backgroundColor = [self myColor];
        else
            self.colorView.backgroundColor = [self enemyColor];
    };
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationCurveEaseIn
                     animations:_animation
                     completion:^(BOOL finished) {
                         
                     }];
}

- (ContainerViewController *)parentController
{
    if (self.parentViewController && [self.parentViewController isKindOfClass:[ContainerViewController class]]) {
        return (ContainerViewController *) self.parentViewController;
    }
    return nil;
}

#pragma mark - Public Methods

- (BOOL)win
{
    return [self decide:[self myOrder]];
}

- (BOOL)lose
{
    return [self decide:[self enemyOrder]];
}

- (void)clear
{
    [self setOrder:nil];
    [self clearBoardData];
    [self.boardView clearColor];
    [self.boardView reflectBoardData:_board];
    self.gameStatus = WAIT;
}

- (void)setConnectStatus:(NSInteger)status
{
    self.connectStatusLabel.text = (status == LOST) ? kLostconnectMessage : kConnectMessage;
}

- (void)setUp:(BOOL)isFirstMover
{
    self.gameStatus = PLAYING;
    
    self.headerView.alpha = 0;
    
    if (isFirstMover) {
        [self setOrder:kFistAttack];
        [self setTurn:YES];
    } else {
        [self setOrder:kSecondAttack];
        [self setTurn:NO];
    }
}

- (void)setReceiveBoardData:(NSMutableArray *)data
{
    self.board = data;
    [self.boardView reflectBoardData:_board];
    if ([self lose]) {
        [[self parentController] showResult:NO];
        [self setGameStatus:FINISH];
    } else {
        [self setTurn:YES];
    }
}

- (void)showHeaderViewAtAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        self.headerView.alpha = 1;
    }];
}

@end
