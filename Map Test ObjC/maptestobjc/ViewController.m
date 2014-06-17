//
//  ViewController.m
//  maptestobjc
//
//  Created by Sergey Garazha on 10/06/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    __weak IBOutlet UISlider *slider;
}
            
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)showUserLocation:(id)sender;

@end

@implementation ViewController
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    
    mapView.showsUserLocation = YES;
    [self showUserLocation:self];
    
    [slider addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Text field delegate methods

- (BOOL)textField:(UITextField *)textField_ shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *str = @"0123456789";
    
    if ([str rangeOfString:string].location != NSNotFound ||
        [string isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

- (void)sliderChanged {
    MKUserLocation *userLocation = mapView.userLocation;
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(slider.value, slider.value));
    [mapView setRegion:region animated:NO];
}

#pragma mark - Location manager helpers

- (IBAction)showUserLocation:(id)sender {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        [locationManager requestWhenInUseAuthorization];
    } else {
        [locationManager startUpdatingLocation];
    }
    [self sliderChanged];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusNotDetermined) {
        [locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self sliderChanged];
}

@end
