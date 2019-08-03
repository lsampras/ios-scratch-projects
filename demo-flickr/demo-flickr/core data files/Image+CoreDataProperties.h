//
//  Image+CoreDataProperties.h
//  demo-flickr
//
//  Created by HAP-86 on 03/08/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//
//

#import "Image+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Image (CoreDataProperties)

+ (NSFetchRequest<Image *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *data;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) Marker *marker;

@end

NS_ASSUME_NONNULL_END
