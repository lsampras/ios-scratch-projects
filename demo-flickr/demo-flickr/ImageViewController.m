//
//  ImageViewController.m
//  demo-flickr
//
//  Created by HAP-86 on 17/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "ImageViewController.h"
#import "AppDelegate.h"

#import <CoreData/CoreData.h>

@interface ImageViewController ()

@property (nonatomic) UILayoutGuide *bound;
@property (nonatomic) NSMutableArray<NSURL *> * myData;
@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSArray<NSManagedObject *> *dblist;
@property (nonatomic) NSMutableSet<NSManagedObject *> *imageSet;
@property (nonatomic) NSManagedObject *marker;

@end

@implementation ImageViewController

- (instancetype)initWithLocation:(CLLocationCoordinate2D) loc{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self = [storyBoard instantiateViewControllerWithIdentifier:@"imageVC"];
    self.myData = [[NSMutableArray alloc] init];
    self.session = [NSURLSession sharedSession];
    self.context = [self managedObjectContext];
    [self fetchData:loc];
    
    if([self.myData count] == 0) {
        int pageNum = arc4random_uniform(20);
        int latMax = loc.latitude + 15;
        int lonMax = loc.longitude + 15;
        int latMin = loc.latitude - 15;
        int lonMin = loc.longitude - 15;
        int imageCount = 3;
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
    }
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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Images"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url == %@", [self.myData objectAtIndex:indexPath.row]];
    [request setPredicate:predicate];
    NSArray<NSManagedObject *> *results  = [self.context executeFetchRequest:request error:nil];
    if([results count]){
        [cell setImageData:[[results firstObject] valueForKey:@"image"]];
    }else{
        NSURLSessionDataTask *downTask = [self.session dataTaskWithURL:[self.myData objectAtIndex:indexPath.row] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSManagedObject *image = [NSEntityDescription insertNewObjectForEntityForName:@"Images" inManagedObjectContext:self.context];
                [image setValue:data forKey:@"image"];
                [image setValue:[self.myData objectAtIndex:indexPath.row].absoluteString forKey:@"url"];
//                [image setValue:self.marker forKey:@"markers"];
                [self.imageSet addObject:image];
                [cell setImageData:data];
            });
        }];
        [downTask resume];
    }
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

- (void)fetchData:(CLLocationCoordinate2D)loc {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Markers"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lat == %lf AND lon == %lf", loc.latitude,loc.longitude];
    [request setPredicate:predicate];
    NSArray<NSManagedObject *> *results  = [self.context executeFetchRequest:request error:nil];
    if ([results count]){
        self.marker = [results firstObject];
        self.imageSet = [self.marker mutableSetValueForKey:@"images_rel"];
//        results = [NSMutableSet setWithArray:results];
        for (NSManagedObject *i in self.imageSet) {
            [self.myData addObject:[i valueForKey:@"url"]];
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return delegate.persistentContainer.viewContext;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSError *error = nil;
    [self.marker setValue:self.imageSet forKey:@"images_rel"];
    if ([self.context hasChanges] && ![self.context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
