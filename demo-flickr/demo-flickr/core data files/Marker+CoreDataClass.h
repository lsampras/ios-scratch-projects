//
//  Marker+CoreDataClass.h
//  demo-flickr
//
//  Created by HAP-86 on 03/08/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@class Image;

NS_ASSUME_NONNULL_BEGIN

@interface Marker : NSManagedObject

- (CLLocationCoordinate2D)coordinate;

@end

NS_ASSUME_NONNULL_END

#import "Marker+CoreDataProperties.h"
