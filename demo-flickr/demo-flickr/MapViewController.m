//
//  ViewController.m
//  demo-flickr
//
//  Created by HAP-86 on 17/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property (nonatomic) CLLocationManager * locManager;
@property (nonatomic) MKPointAnnotation *curMarker;
@property (nonatomic) MKMapView * myMap;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locManager = [[CLLocationManager alloc] init];
    self.locManager.delegate = self;
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locManager requestWhenInUseAuthorization];
    [self.locManager startUpdatingLocation];
    [self loadView:[self.locManager location].coordinate];
    UILongPressGestureRecognizer *longGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    self.myMap.delegate = self;
    [self.view addGestureRecognizer:longGR];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longGR{
    NSLog(@"Long Press Detected");
    if(longGR.state == UIGestureRecognizerStateBegan){
        [self.myMap removeAnnotation:self.curMarker];
        CGPoint touchPoint = [longGR locationInView:self.myMap];
        self.curMarker = [[MKPointAnnotation alloc] init];
        self.curMarker.coordinate = [_myMap convertPoint:touchPoint toCoordinateFromView:self.myMap];
        [self.myMap addAnnotation:self.curMarker];
    }
}

- (void)loadView :(CLLocationCoordinate2D)location{
    CLLocationDistance radius = 1000;
    self.myMap = [[MKMapView alloc] initWithFrame:CGRectZero];
    MKCoordinateRegion  region = MKCoordinateRegionMakeWithDistance(location,radius, radius);
    [self.myMap setRegion:region animated:YES];
    [self.view addSubview:self.myMap];
    self.myMap.translatesAutoresizingMaskIntoConstraints  = NO;
    UILayoutGuide * bound;
    if (@available(iOS 11,*)){
        bound = self.view.safeAreaLayoutGuide;
    }else{
        bound = self.view.layoutMarginsGuide;
    }
    [NSLayoutConstraint activateConstraints:@[[self.myMap.topAnchor constraintEqualToAnchor:bound.topAnchor],
                                              [self.myMap.leftAnchor constraintEqualToAnchor:bound.leftAnchor],
                                              [self.myMap.rightAnchor constraintEqualToAnchor:bound.rightAnchor],
                                              [self.myMap.bottomAnchor constraintEqualToAnchor:bound.bottomAnchor]]];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"board"];
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [showBtn addTarget:self action:@selector(openLocation) forControlEvents:UIControlEventTouchUpInside];
    pin.rightCalloutAccessoryView = showBtn;
    pin.calloutOffset = CGPointMake(-5, -10);
    UILabel *pinLabel = [[UILabel alloc] init];
    pinLabel.text = @"Photos";
    pin.detailCalloutAccessoryView = pinLabel;
    return pin;
}

- (void)openLocation{
    NSLog(@"Image request received");
    ImageViewController *IVC = [[ImageViewController alloc]initWithLocation:self.curMarker.coordinate];
    [self.navigationController pushViewController:IVC animated:YES];
}

@end
