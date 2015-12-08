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

+ (int)calculateDistanceFrom:(CLLocation *)from to:(CLLocation *)to
{
    CLLocationDistance kilometers = [to distanceFromLocation:from] / 1000;
    
    return (int)roundf(kilometers);
}

+ (MKPolyline *)drawLineFrom:(CLLocation *)from to:(CLLocation *)to
{
    CLLocationCoordinate2D points[2];
    
    points[0] = from.coordinate;
    points[1] = to.coordinate;

    return [MKPolyline polylineWithCoordinates:points count:2];
}

+ (void)setRegion:(CLLocationCoordinate2D)center distance:(int)distance inMap:(MKMapView *)map
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, distance, distance);
    [map setRegion:region animated:YES];
    [map regionThatFits:region];
}

#pragma mark - Annotation methods

+ (void)removeAnnotations:(MKMapView *)map
{
    for (id annotation in map.annotations) {
        [map removeAnnotation:annotation];
    }
}

+ (BOOL)isAnnotationInMap:(MKMapView *)map
{
    BOOL flag = false;
    for (id annotation in map.annotations)
    {
        if (annotation) {
            flag = YES;
        }
    }
    return flag;
}

+ (void)showAnnotaton:(CLLocationCoordinate2D)coordinates title:(NSString *)title subtitle:(NSString *)subtitle inMap:(MKMapView *)map
{
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinates];
    [annotation setTitle:title];
    [annotation setSubtitle:subtitle];
    [map addAnnotation:annotation];
}



@end
