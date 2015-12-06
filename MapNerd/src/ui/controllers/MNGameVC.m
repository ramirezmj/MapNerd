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

@end

@implementation MNGameVC

#pragma mark - Life cycle

- (void)viewDidLoad {
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
    
    [self selectRandomCity];
    [self updateLabels];
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
        [alert addAction:restart];
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
    [self selectRandomCity];
    [self updateLabels];
}

#pragma mark - Private methods

- (void)updateLabels
{
    if (_pages < [_totalCities intValue]) {
        _pages ++;
        self.cityLabel.text = _currentCity.name;
        self.cityNumberLabel.text = [NSString stringWithFormat:@"%.f/%@", _pages, _totalCities];
        self.scoreLabel.text = [NSString stringWithFormat:@"%d points", 5000];
    }
}



@end
