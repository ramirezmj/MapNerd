//
//  MNHelpers.m
//  MapNerd
//
//  Created by Jose Manuel Ramírez Martínez on 06/12/15.
//  Copyright © 2015 Jose Manuel Ramírez Martínez. All rights reserved.
//

#import "MNHelpers.h"

@implementation MNHelpers

#pragma mark - Helper methods

+ (int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to - from+ 1);
}

+ (int)distance:(CLLocation *)from to:(CLLocation *)to
{
    return 0;
}

+ (void)drawLineFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to
{
    
}

@end
