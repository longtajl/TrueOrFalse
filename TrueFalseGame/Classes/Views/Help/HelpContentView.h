//
//  HelpContentView.h
//  demoios6
//
//  Created by 長尾昇太 on 2013/09/09.
//  Copyright (c) 2013年 com.appirits. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kImageViewHeight 280
#define kImageViewWidth  kImageViewHeight*0.666

@interface HelpContentView : UIView

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)didChangeContainerViewOffset:(CGPoint)offset withContainerSize:(CGSize)containerSize;

@end
