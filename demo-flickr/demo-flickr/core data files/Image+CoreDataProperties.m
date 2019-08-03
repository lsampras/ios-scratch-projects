//
//  Image+CoreDataProperties.m
//  demo-flickr
//
//  Created by HAP-86 on 03/08/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//
//

#import "Image+CoreDataProperties.h"

@implementation Image (CoreDataProperties)

+ (NSFetchRequest<Image *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Image"];
}

@dynamic data;
@dynamic url;
@dynamic marker;

@end
