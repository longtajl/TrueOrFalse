//
//  UIUtil.m
//  demoios6
//
//  Created by nagao on 12/11/07.
//  Copyright (c) 2012年 com.appirits. All rights reserved.
//

#import "UIUtil.h"

@implementation UIUtil


+ (NSArray *)convertToIndexs:(NSInteger)index
{
    int indexs[2];
    switch (index) {
        case 0:
            indexs[0] = 0; indexs[1] = 0;
            break;
            
        case 1:
            indexs[0] = 0; indexs[1] = 1;
            break;
            
        case 2:
            indexs[0] = 0; indexs[1] = 2;
            break;
            
        case 3:
            indexs[0] = 1; indexs[1] = 0;
            break;
            
        case 4:
            indexs[0] = 1; indexs[1] = 1;
            break;
            
        case 5:
            indexs[0] = 1; indexs[1] = 2;
            break;
            
        case 6:
            indexs[0] = 2; indexs[1] = 0;
            break;
            
        case 7:
            indexs[0] = 2; indexs[1] = 1;
            break;
            
        case 8:
            indexs[0] = 2; indexs[1] = 2;
            break;
            
        default:
            indexs[0] = 0; indexs[1] = 0;
            break;
    }
    NSArray *array = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:indexs[0]],[NSNumber numberWithInt:indexs[1]], nil];
    return array;
}


@end
