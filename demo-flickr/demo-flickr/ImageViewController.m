//
//  ImageViewController.m
//  demo-flickr
//
//  Created by HAP-86 on 17/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@property (nonatomic) UILayoutGuide *bound;
@property (nonatomic) NSMutableArray<NSURL *> * myData;
@property (nonatomic) NSURLSession *session;
@property (nonatomic) BOOL isDownloaded;

@end

@implementation ImageViewController

- (instancetype)initWithLocation:(CLLocationCoordinate2D) loc{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self = [storyBoard instantiateViewControllerWithIdentifier:@"imageVC"];
    self.isDownloaded = false;
    self.myData = [[NSMutableArray alloc] init];
    self.session = [NSURLSession sharedSession];
    int pageNum = arc4random_uniform(20);
    int latMax = loc.latitude + 15;
    int lonMax = loc.longitude + 15;
    int latMin = loc.latitude - 15;
    int lonMin = loc.longitude - 15;
    int imageCount = 30;
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=APIKEYHERE&format=json&nojsoncallback=1&page=%d&per_page=%d&bbox=%d,%d,%d,%d&extras=url_m",pageNum,imageCount,lonMin,latMin,lonMax,latMax]];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            for(int i =0;i<imageCount;i++){
                NSString *temp =[NSString stringWithFormat:@"%@",json[@"photos"][@"photo"][i][@"url_m"]];
                [self.myData addObject:[NSURL URLWithString:temp]];
            }
            [self.collectionView reloadData];
        });
    }];
    [dataTask resume];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    if(@available(iOS 11,*)){
        _bound = self.view.safeAreaLayoutGuide;
    }else{
        _bound = self.view.layoutMarginsGuide;
    }
}

#pragma mark - datasource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_myData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell * cell= [self.collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    [cell setImageUrl:[self.myData objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - flow layout delegate methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.collectionView.frame.size.width/3)-20, (self.collectionView.frame.size.height/4)-20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.collectionView performBatchUpdates:^{
        [self.myData removeObjectAtIndex:indexPath.row];
        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    } completion:^(BOOL finished) {
        
    }];
}

@end
