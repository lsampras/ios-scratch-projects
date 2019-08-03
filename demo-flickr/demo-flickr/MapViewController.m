//
//  ViewController.m
//  demo-flickr
//
//  Created by HAP-86 on 17/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"

@interface MapViewController ()
@property (nonatomic) CLLocationManager * locManager;
@property (nonatomic) MKPointAnnotation *curMarker;
@property (nonatomic) MKMapView * myMap;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSMutableArray<CLLocation *> *markers;
@property (nonatomic) NSArray<NSManagedObject *> *dblist;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.context = [self managedObjectContext];
    self.locManager = [[CLLocationManager alloc] init];
    self.locManager.delegate = self;
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locManager requestWhenInUseAuthorization];
    [self.locManager startUpdatingLocation];
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(19.0974373,72.872313);
    [self loadView:loc];
    UILongPressGestureRecognizer *longGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    self.myMap.delegate = self;
    [self.view addGestureRecognizer:longGR];
    [self fetchData];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longGR{
    NSLog(@"Long Press Detected");
    if(longGR.state == UIGestureRecognizerStateBegan){
        CGPoint touchPoint = [longGR locationInView:self.myMap];
        CLLocationCoordinate2D loc = [_myMap convertPoint:touchPoint toCoordinateFromView:self.myMap];
        [self addMarker:loc];
        [self saveMarker:loc];
    }

}

- (void)addMarker:(CLLocationCoordinate2D)location {
    MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
    marker.coordinate = location;
    [self.myMap addAnnotation:marker];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:marker.coordinate.latitude longitude:marker.coordinate.longitude];
    [self.markers addObject:loc];
}
    
- (void)loadView :(CLLocationCoordinate2D)location {
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"board"];
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    showBtn.tag = 0;
    for (CLLocation *i in self.markers) {
        if(i.coordinate.longitude == annotation.coordinate.longitude && i.coordinate.longitude == annotation.coordinate.longitude){
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
    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    NSLog(@"Image request received");
    ImageViewController *IVC = [[ImageViewController alloc] initWithLocation:[[self.markers objectAtIndex:sender.tag] coordinate]];
    [self.navigationController pushViewController:IVC animated:YES];
}


- (void)fetchData {
    self.markers = [[NSMutableArray alloc] init];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Markers"];
    self.dblist = [self.context executeFetchRequest:request error:nil];
    for (NSManagedObject *i in self.dblist) {
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake([[i valueForKey:@"lat"] doubleValue], [[i valueForKey:@"lon"] doubleValue]);
        [self addMarker:loc];
    }
}

- (void)saveMarker:(CLLocationCoordinate2D) location {
    // Create a new managed object
    NSManagedObject *marker = [NSEntityDescription insertNewObjectForEntityForName:@"Markers" inManagedObjectContext:self.context];
    [marker setValue:[NSNumber numberWithDouble:location.latitude] forKey:@"lat"];
    [marker setValue:[NSNumber numberWithDouble:location.longitude] forKey:@"lon"];
}

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return delegate.persistentContainer.viewContext;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
