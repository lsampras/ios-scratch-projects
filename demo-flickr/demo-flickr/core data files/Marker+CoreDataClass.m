//
//  Marker+CoreDataClass.m
//  demo-flickr
//
//  Created by HAP-86 on 03/08/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//
//

#import "Marker+CoreDataClass.h"

@implementation Marker

- (CLLocationCoordinate2D)coordinate{
    return CLLocationCoordinate2DMake(self.lat, self.lon);
}
@end
