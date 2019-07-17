//
//  ViewController.h
//  demo-maps-pods
//
//  Created by HAP-86 on 16/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface MapController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic) GMSMapView *myMap;

- (void)updateCamera:(CLLocationCoordinate2D)location;
- (void)addMarker:(NSString *)title :(CLLocationCoordinate2D)location;

@end

