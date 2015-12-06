//
//  City.h
//  MapNerd
//
//  Created by Jose Manuel Ramírez Martínez on 06/12/15.
//  Copyright © 2015 Jose Manuel Ramírez Martínez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface MNCity : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;

@end
