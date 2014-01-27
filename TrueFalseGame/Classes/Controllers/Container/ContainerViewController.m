//
//  TopViewController.m
//  demoios6
//
//  Created by nagao on 2013/08/23.
//  Copyright (c) 2013年 com.appirits. All rights reserved.
//

#import "ContainerViewController.h"
#import "HelpViewController.h"
#import "ContainerViewController+P2P.h"
#import "ContainerViewController+FUIAlertViewDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface ContainerViewController () <ConnectionManagerDelegate, ADBannerViewDelegate> {

}

@property (weak, nonatomic) IBOutlet FUIButton *connectButton;
@property (weak, nonatomic) IBOutlet FUIButton *helpButton;
@property (weak, nonatomic) IBOutlet FUIButton *endButton;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) ADBannerView *adView;

- (IBAction)tapButton:(id)sender;

@end

@implementation ContainerViewController

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
    
    self.view.frame = CGRectMake(0, 0, ApplicationFrame.size.width, ApplicationFrame.size.height);
    self.view.backgroundColor = [UIColor cloudsColor];
    
    self.boardViewController = [[BoardViewController alloc] initWithNibName:@"BoardViewController" bundle:nil];
    CGFloat y = self.endButton.frame.size.height + self.endButton.frame.origin.y + self.boardViewController.view.frame.size.height/2;
    self.boardViewController.view.center = CGPointMake(self.view.frame.size.width/2, y);
    
    self.connectButton.buttonColor = [UIColor turquoiseColor];
    self.connectButton.shadowColor = [UIColor greenSeaColor];
    self.connectButton.shadowHeight = 2.0f;
    self.connectButton.cornerRadius = 12.0f;
    self.connectButton.titleLabel.font = [UIFont boldFlatFontOfSize:16.f];
    [self.connectButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.connectButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.helpButton.buttonColor = [UIColor peterRiverColor];
    self.helpButton.shadowColor = [UIColor belizeHoleColor];
    self.helpButton.shadowHeight = 2.f;
    self.helpButton.cornerRadius = 12.f;
    self.helpButton.titleLabel.font = [UIFont boldFlatFontOfSize:16.f];
    [self.helpButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.helpButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.endButton.alpha = 0;
    self.endButton.buttonColor = [UIColor wetAsphaltColor];
    self.endButton.shadowColor = [UIColor belizeHoleColor];
    self.endButton.shadowHeight = 2.f;
    self.endButton.cornerRadius = 12.f;
    self.endButton.titleLabel.font = [UIFont boldFlatFontOfSize:15.f];
    [self.endButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.endButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    [self.logo sizeToFit];
    //self.logo.center = CGPointMake(self.view.frame.size.width/2, 140);
    self.logo.frame = CGRectMake(0, 0, _logo.frame.size.width, _logo.frame.size.height);
    self.logo.backgroundColor = [UIColor clearColor];
    self.logo.layer.borderColor  = [UIColor sunflowerColor].CGColor;
    self.logo.layer.borderWidth  = 1.f;
    
    ADBannerView *adView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    adView.frame = CGRectMake(0, self.view.frame.size.height - adView.frame.size.height, adView.frame.size.width, adView.frame.size.width);
    adView.autoresizesSubviews = YES;
    adView.hidden = YES;
    adView.delegate = self;
    self.adView = adView;
    [self.view addSubview:_adView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods

- (IBAction)tapButton:(id)sender
{
    UIButton *button = sender;
    switch (button.tag) {
        case 0: [self beginConnection];        break;
        case 1: [self pushHelpViewController]; break;
        case 2: [self popBoardViewController]; break;
        default: break;
    }
}

- (void)pushHelpViewController
{
    HelpViewController *controller = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navigationController animated:YES completion:^{
        
    }];
}

- (void)dismissAlertView
{
    if (self.alertView) {
        [self.alertView dismissWithClickedButtonIndex:-1 animated:NO];
        self.alertView = nil;
    }
}

- (void)beginConnection
{
    self.connectionManager = [[ConnectionManager alloc] init];
    self.connectionManager.delegate = self;
    [self.connectionManager connect];
}

- (void)endConnection
{
    if (_connectionManager) {
        [self.connectionManager disconnect];
        self.connectionManager = nil;
    }
}

#pragma mark - Public Methods

- (void)popBoardViewController
{
    [self endConnection];
    
    if (self.boardViewController.view.superview) {
        [self hideEndButtonWithCompletion:nil];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self.boardViewController.view removeFromSuperview];
            [self.boardViewController removeFromParentViewController];
            [self.boardViewController clear];
            [self visibleTopViewsWithCompletion:^(BOOL finished) {
                
            }];
        }];
        
        CGFloat positionY = _boardViewController.view.frame.origin.y + _boardViewController.view.frame.size.height/2;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.duration = 0.4;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width/2, positionY)];
        animation.toValue   = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width*-2, positionY)];
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :0.5 :0.5 :1.00];
        [self.boardViewController.view.layer addAnimation:animation forKey:@"animation"];
        
        [CATransaction commit];
        
    }
}

- (void)pushBoardViewController:(BOOL)isFirstMover
{
    [self dismissAlertView];
    [self.boardViewController setUp:isFirstMover];
    
    if(!self.boardViewController.view.superview) {
        
        [self hideTopViewsWithCompletion:^(BOOL finished) {
            [self visibleEndButtonWithCompletion:nil];
            [self.view addSubview:_boardViewController.view];
            [self addChildViewController:_boardViewController];
            
            [CATransaction begin];
            [CATransaction setCompletionBlock:^{
                [self.boardViewController didMoveToParentViewController:self];
                [self.boardViewController showHeaderViewAtAnimation];
            }];
            CGFloat positionY = _boardViewController.view.frame.origin.y + _boardViewController.view.frame.size.height/2;
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
            animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :1.25 :0.5 :1.2];
            animation.duration  = 0.3;
            animation.toValue   = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width/2, positionY)];
            animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width*2, positionY)];
            [self.boardViewController.view.layer addAnimation:animation forKey:@"animation"];
            [CATransaction commit];
            
        }];
        
    } else {
        [self.boardViewController showHeaderViewAtAnimation];
    }
}

- (void)hideTopViewsWithCompletion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.logo.alpha = self.helpButton.alpha = self.connectButton.alpha = 0;
                         self.logo.transform = CGAffineTransformMakeScale(0.7, 0.7);
                     }
                     completion:completion];
}

- (void)visibleTopViewsWithCompletion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.logo.alpha = self.helpButton.alpha = self.connectButton.alpha = 1;
                     }
                     completion:completion];
}

- (void)hideEndButtonWithCompletion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:0.3
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.endButton.alpha = 0;
                     }
                     completion:completion];
}

- (void)visibleEndButtonWithCompletion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:0.2
                          delay:2.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.endButton.alpha = 1;
                     }
                     completion:completion];
}

#pragma mark - ADBannerViewDelegate

- (void)bannerViewWillLoadAd:(ADBannerView *)banner
{
    AppLog;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    AppLog;
    banner.hidden = NO;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    AppLog;
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    banner.hidden = YES;
}

@end
