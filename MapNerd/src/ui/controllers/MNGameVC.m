//
//  ViewController.m
//  BaseProject
//
//  Created by Jose Manuel Ramírez Martínez on 29/11/15.
//  Copyright © 2015 Jose Manuel Ramírez Martínez. All rights reserved.
//

#import "MNGameVC.h"
#import "MNFactory.h"
#import "MNHelpers.h"

static const CGFloat kRegionDistance = 2000;

@interface MNGameVC ()

@property (weak, nonatomic) IBOutlet MKMapView *satelliteMap;
@property (weak, nonatomic) IBOutlet MKMapView *standardMap;
@property (weak, nonatomic) IBOutlet UIView *controlsContainerView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *cityNumberLabel;

@property (strong, nonatomic) NSMutableArray *cities;
@property (strong, nonatomic) MNCity *currentCity;
@property (strong, nonatomic) NSNumber *totalCities;
@property (nonatomic, assign) CGFloat pages;

@property (strong, nonatomic) MKPointAnnotation *annotation;
@property (strong, nonatomic) CLLocation *annotationLocation;
@property (strong, nonatomic) MKPolyline *overlayPolyline;

@end

@implementation MNGameVC

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initGame];
}

#pragma mark - Game methods

- (void)initGame
{
    MNFactory *factory = [[MNFactory alloc] init];
    self.cities = [[NSMutableArray alloc] initWithArray:[factory cities]];
    self.pages = 0;
    self.totalCities = @([_cities count]);
    
    // Sets the Standard Map to World View
    _standardMap.region = MKCoordinateRegionForMapRect(MKMapRectWorld);
    
    // Register Long Press gesture to the Standard Map
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    longPressGR.allowableMovement = 100.0f;
    
    [_standardMap addGestureRecognizer:longPressGR];
    
    [self selectRandomCity];
    [self updateInterface];
    [self disableNextButton:YES];
}

- (void)selectRandomCity
{
    if ([_cities count] == 0) {
        UIAlertController *alert = [UIAlertController
                                     alertControllerWithTitle:@"Congratulations!"
                                     message:@"You've reached the end of the game"
                                     preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *restart = [UIAlertAction
                                  actionWithTitle:@"Restart"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
                                      [self initGame];
                                  }];
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDestructive
                                 handler:nil];
        [alert addAction:restart];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    
    } else {
        int dice = [MNHelpers getRandomNumberBetween:0 to:(int)[_cities count] - 1];
        if (dice != 0) {
            dice -= 1;
        }
        self.currentCity = _cities[dice];
        [self.cities removeObjectAtIndex:dice];
    }
}

- (void)showCity
{
    CLLocation *cityLocation = [[CLLocation alloc] initWithLatitude:_currentCity.latitude longitude:_currentCity.longitude];
    [self setRegion:cityLocation.coordinate distance:kRegionDistance inMap:_satelliteMap];
}

- (void)setRegion:(CLLocationCoordinate2D)center distance:(int)distance inMap:(MKMapView *)map
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, distance, distance);
    [map setRegion:region animated:YES];
    [map regionThatFits:region];
}

#pragma mark - UIGestureRecognizer

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
        // First remove annotations
        [MNHelpers removeAnnotations:_standardMap];
        CGPoint touch = [gestureRecognizer locationInView:_standardMap];
        self.annotation = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D coord = [_standardMap convertPoint:touch toCoordinateFromView:_standardMap];
        [self.annotation setCoordinate:coord];

        self.annotationLocation = [[CLLocation alloc]
                                   initWithLatitude:[_annotation coordinate].latitude
                                   longitude:[_annotation coordinate].longitude];
        
        [_standardMap addAnnotation:[MNHelpers showAnnotaton:_annotationLocation.coordinate
                                                       title:@"User selection"
                                                    subtitle:[NSString stringWithFormat:@"%f - %f", _currentCity.latitude, _currentCity.longitude]]];
    }
}

#pragma mark - IBActions

- (IBAction)checkAnswer:(UIButton *)button
{
    // Show City
    [self switchToAnswer:YES];
    
    // Enable/Disable buttons
    [self disableNextButton:NO];
    [self disableCheckAnswerButton:YES];
    
    // Calculate error distance
    CLLocation *cityLocation = [[CLLocation alloc] initWithLatitude:_currentCity.latitude longitude:_currentCity.longitude];
    
    [_standardMap addAnnotation:[MNHelpers showAnnotaton:cityLocation.coordinate
                                              title:_currentCity.name
                                           subtitle:[NSString stringWithFormat:@"%f - %f", _currentCity.latitude, _currentCity.longitude]]];
    
//    [MNHelpers calculateDistanceFrom:annotationLocation to:cityLocation];
    _overlayPolyline = [MNHelpers drawLineFrom:_annotationLocation to:cityLocation];
    [_standardMap addOverlay:_overlayPolyline];
}

- (IBAction)nextCity:(UIButton *)button
{
    // Update UI
    [self disableNextButton:YES];
    [self disableCheckAnswerButton:NO];
    [MNHelpers removeAnnotations:_standardMap];
    [_standardMap removeOverlay:_overlayPolyline];
    [self switchToAnswer:NO];
    
    // Setup next city
    [self selectRandomCity];
    [self updateInterface];
}

#pragma mark - Private methods

- (void)updateInterface
{
    if (_pages < [_totalCities intValue]) {
        _pages ++;
        self.cityNumberLabel.text = [NSString stringWithFormat:@"%.f/%@", _pages, _totalCities];
        self.scoreLabel.text = [NSString stringWithFormat:@"%d points", 5000];
        [self showCity];
    }
}

- (void)disableNextButton:(BOOL)flag
{
    if (flag) {
        self.nextButton.alpha = 0.5;
        self.nextButton.userInteractionEnabled = NO;
    } else {
        self.nextButton.alpha = 1.0;
        self.nextButton.userInteractionEnabled = YES;
    }
}

- (void)disableCheckAnswerButton:(BOOL)flag
{
    if (flag) {
        self.okButton.alpha = 0.5;
        self.okButton.userInteractionEnabled = NO;
    } else {
        self.okButton.alpha = 1;
        self.okButton.userInteractionEnabled = YES;
    }
}

- (void)switchToAnswer:(BOOL)flag
{
    if (flag) {
        self.cityLabel.text = _currentCity.name;
    } else {
        self.cityLabel.text = @"Situa esta cuidad en el mapa";
    }
}

#pragma mark - MapKit Delegate Methods

- (MKOverlayRenderer *) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *polylineRender  = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    polylineRender.lineWidth            = 3.0f;
    polylineRender.lineDashPattern      = @[@2, @5];
    polylineRender.alpha                = 0.5;
    UIColor *lineColor                  = [UIColor redColor];
    polylineRender.strokeColor          = lineColor;
    
    return polylineRender;
}

@end
