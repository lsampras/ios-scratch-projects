//
//  ImageViewController.h
//  demo-flickr
//
//  Created by HAP-86 on 17/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCell.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewController : UIViewController <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil  NS_UNAVAILABLE;
- (instancetype)initWithLocation :(CLLocationCoordinate2D) loc NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
