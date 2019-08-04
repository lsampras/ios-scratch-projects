//
//  Marker+CoreDataProperties.m
//  demo-flickr
//
//  Created by HAP-86 on 03/08/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//
//

#import "Marker+CoreDataProperties.h"

@implementation Marker (CoreDataProperties)

+ (NSFetchRequest<Marker *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Marker"];
}

@dynamic lon;
@dynamic lat;
@dynamic images_rel;

@end
