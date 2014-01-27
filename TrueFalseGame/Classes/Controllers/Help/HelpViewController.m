//
//  HelpViewController.m
//  demoios6
//
//  Created by nagao on 12/11/05.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

#import "HelpViewController.h"
#import "UIColor+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"

#import "HelpContentView.h"
#import "HelpPlayView.h"
#import "HelpPlayView2.h"
#import "HelpConnectView.h"

#define kPageNumber 3

@interface HelpViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (void)setUpNavigationBar;
- (void)dissmiss;

@end

@implementation HelpViewController

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
    self.view.frame = CGRectMake(0, 0, ApplicationFrame.size.width, ApplicationFrame.size.height-44-20);
    [self setUpNavigationBar];
    [self setContentView];
    [self setUpPageControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Methods

- (void)setUpPageControl
{
    CGRect rect = self.pageControl.frame;
    rect.origin.y = self.view.frame.size.height - self.pageControl.frame.size.height - 10;

    [self.pageControl setFrame:rect];
    [self.pageControl setNumberOfPages:kPageNumber];
    [self.pageControl setCurrentPage:0];
    [self.pageControl setPageIndicatorTintColor:[UIColor cloudsColor]];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor sunflowerColor]];
}

- (void)setUpNavigationBar
{
//    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dissmiss)];
    UINavigationItem* item = [self.navigationController.navigationBar.items objectAtIndex:0];
    item.rightBarButtonItem = btn;
    
//    [self.navigationItem.rightBarButtonItem configureFlatButtonWithColor:[UIColor peterRiverColor] highlightedColor:[UIColor belizeHoleColor] cornerRadius:3];
//    [self.navigationItem.rightBarButtonItem removeTitleShadow];
}

- (void)setContentView
{
    [self.scrollView setBackgroundColor:[UIColor cloudsColor]];
    for (int i=0; i<kPageNumber; i++) {
        
        NSString *nibName;
        switch (i) {
            case 0:  nibName = @"HelpConnectView"; break;
            case 1:  nibName = @"HelpPlayView";    break;
            case 2:  nibName = @"HelpPlayView2";   break;
            default: nibName = nil;                break;
        }
        
        if (nibName) {
            UIView *view = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil][0];
            CGRect frame = view.frame;
            frame.origin.x = self.view.frame.size.width * i;
            view.frame = frame;
            [self.scrollView addSubview:view];
        } else {
            continue;
        }
        
    }
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width*kPageNumber, self.view.frame.size.height)];
}

- (void)dissmiss;
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    [self.pageControl setCurrentPage:page];
    
    [[self.scrollView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HelpContentView *contentView = obj;
        [contentView didChangeContainerViewOffset:self.scrollView.contentOffset withContainerSize:scrollView.contentSize];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
}

@end
