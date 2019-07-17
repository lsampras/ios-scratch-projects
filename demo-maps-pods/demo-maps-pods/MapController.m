//
//  ViewController.m
//  demo-maps-pods
//
//  Created by HAP-86 on 16/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "MapController.h"

@interface MapController ()
@property (nonatomic) CLLocationManager * locManager;
@property (nonatomic) GMSCameraPosition *camera;
@property (nonatomic) CLLocationCoordinate2D externalLoc;

@end

@implementation MapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locManager = [[CLLocationManager alloc] init];
    self.locManager.delegate = self;
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locManager requestWhenInUseAuthorization];
    [self.locManager startUpdatingLocation];
    [self loadView:[self.locManager location].coordinate];
    [self addMarker:@"Your Location" :[self.locManager location].coordinate];
    
}

- (void)updateCamera:(CLLocationCoordinate2D)location{
    self.camera = [GMSCameraPosition cameraWithTarget:location zoom:16];
    [self.myMap setCamera:_camera];
}

- (void)initMapView:(GMSCameraPosition *) camera{
    
    self.myMap = [GMSMapView mapWithFrame:CGRectZero camera:self.camera];
    self.myMap.myLocationEnabled = YES;
}

- (UIButton *)gethomeBtn{
    
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    homeBtn.backgroundColor = UIColor.blueColor;
    homeBtn.layer.cornerRadius = 10;
    homeBtn.titleLabel.textColor = UIColor.whiteColor;
    homeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [homeBtn addTarget:self action:@selector(resetPosition) forControlEvents:UIControlEventTouchUpInside];
    [homeBtn setTitle:@"take me home" forState:UIControlStateNormal];
    return homeBtn;
}

- (void)loadView :(CLLocationCoordinate2D)location{
    
    self.camera = [GMSCameraPosition cameraWithTarget:location zoom:16];
    [self initMapView:_camera];
    
    UIButton *homeBtn = [self gethomeBtn];
    [self.view addSubview:self.myMap];
    [self.view addSubview:homeBtn];
    
    self.myMap.translatesAutoresizingMaskIntoConstraints  = NO;
    homeBtn.translatesAutoresizingMaskIntoConstraints  = NO;
    
    UILayoutGuide * bound;
    
    if (@available(iOS 11,*)){
        bound = self.view.safeAreaLayoutGuide;
    }else{
        bound = self.view.layoutMarginsGuide;
    }
    
    [NSLayoutConstraint activateConstraints:@[[self.myMap.topAnchor constraintEqualToAnchor:bound.topAnchor],
                                              [self.myMap.leftAnchor constraintEqualToAnchor:bound.leftAnchor],
                                              [self.myMap.rightAnchor constraintEqualToAnchor:bound.rightAnchor],
                                              [self.myMap.bottomAnchor constraintEqualToAnchor:bound.bottomAnchor],
                                              [homeBtn.bottomAnchor constraintEqualToAnchor:self.myMap.bottomAnchor constant:-20],
                                              [homeBtn.rightAnchor constraintEqualToAnchor:self.myMap.rightAnchor constant:-20],
                                              [homeBtn.widthAnchor constraintEqualToConstant:100],
                                              [homeBtn.heightAnchor constraintEqualToConstant:30]]];
    
}

- (void)resetPosition{
    GMSCameraPosition *cam = [GMSCameraPosition cameraWithTarget:[self.locManager location].coordinate zoom:16];
    [self.myMap setCamera:cam];
}
    
    
- (void) viewWillLayoutSubviews{
    
}

- (void)addMarker:(NSString *)title :(CLLocationCoordinate2D)location{
    GMSMarker *marker = [GMSMarker markerWithPosition:location];
    marker.title = title;
    marker.map = self.myMap;
}
    
@end
