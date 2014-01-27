//
//  ContainerViewController+FUIAlertViewDelegate.h
//  demoios6
//
//  Created by nagao on 2013/08/30.
//  Copyright (c) 2013年 com.appirits. All rights reserved.
//

#import "ContainerViewController.h"

enum {
    ASK_ORDER = 0,
    RESULT = 1,
}ALERT_INDEX;

@interface ContainerViewController (FUIAlertViewDelegate) <FUIAlertViewDelegate>

@end
