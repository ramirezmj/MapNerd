//
//  ViewController.m
//  BaseProject
//
//  Created by Jose Manuel Ramírez Martínez on 29/11/15.
//  Copyright © 2015 Jose Manuel Ramírez Martínez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *satelliteMap;
@property (weak, nonatomic) IBOutlet MKMapView *standardMap;
@property (weak, nonatomic) IBOutlet UIView *controlsContainerView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation ViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Game methods

- (void)initGame
{
    
}

- (void)selectRandomCity
{
    
}

- (void)showCity
{
    
}

- (void)setRegion:(CLLocationCoordinate2D)center distance:(int)distance inMap:(MKMapView *)map
{
    
}

#pragma mark - Annotation methods

- (void)eraseAnnotations
{
    
}

- (void)showAnnotaton:(CLLocationCoordinate2D)coordinates title:(NSString *)title subtitle:(NSString *)subtitle
{
    
}

#pragma mark - UIGestureRecognizer

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    
}


#pragma mark - IBActions

- (IBAction)checkAnswer:(UIButton *)button
{
    
}

- (IBAction)nextCity:(UIButton *)button
{
    
}

#pragma mark - Helper methods

- (int)getRandomNumberBetween:(int)from to:(int)to
{
    return (int)from + arc4random() % (to - from+ 1);
}

- (int)distance:(CLLocation *)from to:(CLLocation *)to
{
    return 0;
}

- (void)drawLineFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to
{
    
}

@end
