//
//  SearchController.h
//  demo-maps-pods
//
//  Created by HAP-86 on 16/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapController.h"
#import "SearchMapController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchBarController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *table;
    
@end

NS_ASSUME_NONNULL_END
