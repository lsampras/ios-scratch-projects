//
//  Marker+CoreDataProperties.h
//  demo-flickr
//
//  Created by HAP-86 on 03/08/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//
//

#import "Marker+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Marker (CoreDataProperties)

+ (NSFetchRequest<Marker *> *)fetchRequest;

@property (nonatomic) double lon;
@property (nonatomic) double lat;
@property (nullable, nonatomic, retain) NSSet<Image *> *images_rel;

@end

@interface Marker (CoreDataGeneratedAccessors)

- (void)addImages_relObject:(Image *)value;
- (void)removeImages_relObject:(Image *)value;
- (void)addImages_rel:(NSSet<Image *> *)values;
- (void)removeImages_rel:(NSSet<Image *> *)values;

@end

NS_ASSUME_NONNULL_END
