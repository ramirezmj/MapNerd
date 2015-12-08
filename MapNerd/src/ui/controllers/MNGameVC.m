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
#import "SoundManager.h"

#define _SoundManager [SoundManager sharedManager]

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

@property (strong, nonatomic) MKPointAnnotation *annotation;
@property (strong, nonatomic) CLLocation *annotationLocation;
@property (strong, nonatomic) MKPolyline *overlayPolyline;

@property (nonatomic, assign) CGFloat pages;
@property (nonatomic, assign) CGFloat score;
@property (nonatomic, assign) BOOL canPressOkButton;

@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGR;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeGR;

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
    MNFactory *factory      = [[MNFactory alloc] init];
    self.cities             = [[NSMutableArray alloc] initWithArray:[factory cities]];
    self.totalCities        = @([_cities count]);
    self.pages              = 0;
    self.score              = 0;
    self.scoreLabel.text    = @"- - -";
    
    // Register and Add Long Press gesture to the Standard Map
    self.longPressGR        = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(handleLongPressGesture:)];
    self.longPressGR.allowableMovement = 100.0f;
    [_standardMap addGestureRecognizer:_longPressGR];
    
    //Register and Add Swipe gesture to the Standard Map
    self.swipeGR            = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(nextCityWithSwipe:)];
    self.swipeGR.direction  = UISwipeGestureRecognizerDirectionLeft;
    self.swipeGR.numberOfTouchesRequired = 1;
    [_controlsContainerView addGestureRecognizer:_swipeGR];
    
    [self initializeUserInterface];
}

- (void)initializeUserInterface
{
    [self selectRandomCity];
    
    // Update UI
    [self disableNextButton:YES];
    [self switchToAnswer:NO];
    [self disableCheckAnswerButton:YES];
    
    _canPressOkButton = NO;
    _longPressGR.enabled = YES;
    
    [MNHelpers removeAnnotations:_standardMap];
    [_standardMap removeOverlay:_overlayPolyline];
    
    [self updateInterface];
}

- (void)selectRandomCity
{
    int dice = [MNHelpers getRandomNumberBetween:0 to:(int)[_cities count]];
    if (dice != 0) {
        dice -= 1;
    }
    self.currentCity = _cities[dice];
    [self.cities removeObjectAtIndex:dice];
}

- (void)showCity
{
    CLLocation *cityLocation = [[CLLocation alloc] initWithLatitude:_currentCity.latitude longitude:_currentCity.longitude];
    [MNHelpers setRegion:cityLocation.coordinate distance:kRegionDistance inMap:_satelliteMap];
}

#pragma mark - UIGestureRecognizer

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
        // First remove annotations if any
        [MNHelpers removeAnnotations:_standardMap];
        
        CGPoint touch = [gestureRecognizer locationInView:_standardMap];
        self.annotation = [[MKPointAnnotation alloc] init];
        
        CLLocationCoordinate2D coord = [_standardMap convertPoint:touch toCoordinateFromView:_standardMap];
        [self.annotation setCoordinate:coord];
        
        self.annotationLocation = [[CLLocation alloc]
                                   initWithLatitude:[_annotation coordinate].latitude
                                   longitude:[_annotation coordinate].longitude];
        
        [MNHelpers showAnnotaton:_annotationLocation.coordinate
                           title:@"User selection"
                        subtitle:[NSString stringWithFormat:@"%f - %f", _currentCity.latitude, _currentCity.longitude]
                           inMap:_standardMap];
        [self disableCheckAnswerButton:NO];
    }
}

#pragma mark - IBActions

- (IBAction)checkAnswer:(UIButton *)button
{
    if ([MNHelpers isAnnotationInMap:_standardMap]){
        // Show City
        [self switchToAnswer:YES];
        
        // Enable/Disable buttons and gestures
        [self disableNextButton:NO];
        [self disableCheckAnswerButton:YES];
        _canPressOkButton = YES;
        _longPressGR.enabled = NO;
        
        // Calculate error distance
        CLLocation *cityLocation = [[CLLocation alloc] initWithLatitude:_currentCity.latitude longitude:_currentCity.longitude];
        
        int distance = [MNHelpers calculateDistanceFrom:_annotationLocation to:cityLocation];
        
        [MNHelpers showAnnotaton:cityLocation.coordinate
                           title:_currentCity.name
                        subtitle:[NSString stringWithFormat:@"%d kilometers", distance]
                           inMap:_standardMap];

        [self checkDistance:distance];
        
        // Calculate distance and update interface
        _score += distance;
        self.scoreLabel.text = [NSString stringWithFormat:@"%.f km", _score];
        
        _overlayPolyline = [MNHelpers drawLineFrom:_annotationLocation to:cityLocation];
        [_standardMap addOverlay:_overlayPolyline];

        // Center the map between the two annotations
        [_standardMap showAnnotations:@[_annotationLocation, cityLocation] animated:YES];
        
    } else {
        [self showInstructions];
    }
}
// Deprecated since we are using swipe gestures
- (IBAction)nextCity:(UIButton *)button
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
        [self initializeUserInterface];
    }
}

- (void)nextCityWithSwipe:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer.direction & UISwipeGestureRecognizerDirectionLeft) {
        
        if ([MNHelpers isAnnotationInMap:_standardMap] && _canPressOkButton){
            
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
                [self initializeUserInterface];
            }
        } else {
            [self showInstructions];
        }
    }
}

#pragma mark - Private methods

- (void)updateInterface
{
    if (_pages < [_totalCities intValue]) {
        // Sets the Standard Map to World View
        _standardMap.region = MKCoordinateRegionForMapRect(MKMapRectWorld);
        _pages ++;
        self.cityNumberLabel.text = [NSString stringWithFormat:@"%.f/%@", _pages, _totalCities];
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

- (void)checkDistance:(int)distance
{
    if (distance < 300) {
        [_SoundManager playSound:@"applause-moderate-03.wav"];
    } else if ( distance > 300 && distance < 1000) {
        [_SoundManager playSound:@"applause-light-02.wav"];
    } else {
        [_SoundManager playSound:@"boo-01.wav"];
    }
}

- (void)showInstructions
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Instructions"
                                message:@"You have to provide a location first."
                                preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:nil];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
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
