//
//  SearchMapController.h
//  demo-maps-pods
//
//  Created by HAP-86 on 17/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "MapController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchMapController : MapController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(nonnull NSCoder *) coder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithLoc:(CLLocationCoordinate2D)loc name:(NSString *)name NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
