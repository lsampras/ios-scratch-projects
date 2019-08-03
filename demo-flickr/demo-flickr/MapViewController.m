//
//  ViewController.m
//  demo-flickr
//
//  Created by HAP-86 on 17/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "MapViewController.h"
#import "core data files/Marker+CoreDataClass.h"
#import "AppDelegate.h"

@interface MapViewController ()
@property (nonatomic) CLLocationManager * locManager;
@property (nonatomic) MKPointAnnotation *curMarker;
@property (nonatomic) MKMapView * myMap;
@property (nonatomic) NSMutableArray<CLLocation *> *markers;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSMutableArray<Marker *> *markerData;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locManager = [[CLLocationManager alloc] init];
    self.context = [self managedContext];
    self.locManager.delegate = self;
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locManager requestWhenInUseAuthorization];
    [self.locManager startUpdatingLocation];
    [self loadView:[self.locManager location].coordinate];
    UILongPressGestureRecognizer *longGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    self.myMap.delegate = self;
    [self.view addGestureRecognizer:longGR];
    [self fetchData];
//    self.markerData = [[NSMutableArray alloc] init];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longGR{
    NSLog(@"Long Press Detected");
    if(longGR.state == UIGestureRecognizerStateBegan){
        CGPoint touchPoint = [longGR locationInView:self.myMap];
        CLLocationCoordinate2D loc = [_myMap convertPoint:touchPoint toCoordinateFromView:self.myMap];
        [self saveMarker:loc];
    }
}

- (void)loadView :(CLLocationCoordinate2D)location{
    CLLocationDistance radius = 100000;
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

- (void)addMarker:(Marker *)location {
    MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
    marker.coordinate = CLLocationCoordinate2DMake(location.lat, location.lon);
//    [self.markers addObject: [[CLLocation alloc] initWithLatitude:location.lat longitude:location.lon]];
    [self.myMap addAnnotation:marker];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"board"];
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    showBtn.tag = 0;
    for (Marker *i in self.markerData) {
        if(i.lon == annotation.coordinate.longitude && i.lat == annotation.coordinate.latitude){
            showBtn.tag = [self.markers indexOfObject:i];
            break;
        }
    }
    [showBtn addTarget:self action:@selector(openLocation:) forControlEvents:UIControlEventTouchUpInside];
    pin.rightCalloutAccessoryView = showBtn;
    pin.calloutOffset = CGPointMake(-5, -10);
    UILabel *pinLabel = [[UILabel alloc] init];
    pinLabel.text = @"Photos";
    pin.detailCalloutAccessoryView = pinLabel;
    return pin;
}

- (void)openLocation:(UIButton *)sender {
    ImageViewController *IVC = [[ImageViewController alloc] initWithLocation:[self.markerData objectAtIndex:sender.tag]];
    [self.navigationController pushViewController:IVC animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self saveContext];
}

#pragma mark - core data methods

- (NSManagedObjectContext *)managedContext{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return app.persistentContainer.viewContext;
}

- (void)fetchData{
    NSFetchRequest *request = [Marker fetchRequest];
    NSError *err = nil;
    self.markerData = [NSMutableArray arrayWithArray:[self.context executeFetchRequest:request error:&err]];
    if (err) {
        abort();
    }
    for (Marker *i in self.markerData) {
        [self addMarker:i];
    }
}


- (void)saveMarker:(CLLocationCoordinate2D)location {
    Marker *m = [[Marker alloc] initWithContext:self.context];
    m.lat = location.latitude;
    m.lon = location.longitude;
    [self.markerData addObject:m];
    [self addMarker:m];
}

- (void)saveContext {

    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"MAPc: Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
