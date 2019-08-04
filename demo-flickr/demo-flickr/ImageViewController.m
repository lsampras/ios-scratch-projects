//
//  ImageViewController.m
//  demo-flickr
//
//  Created by HAP-86 on 17/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "ImageViewController.h"
#import "core data files/Marker+CoreDataClass.h"
#import "core data files/Image+CoreDataClass.h"
#import "AppDelegate.h"

@interface ImageViewController ()

@property (nonatomic) UILayoutGuide *bound;
@property (nonatomic) NSMutableArray<Image *> * myData;
@property (nonatomic) NSURLSession *session;
@property (nonatomic) BOOL isDownloaded;
@property (nonatomic) Marker *marker;
@property (nonatomic) NSManagedObjectContext *context;

@end

@implementation ImageViewController

- (instancetype)initWithLocation:(Marker *) loc{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self = [storyBoard instantiateViewControllerWithIdentifier:@"imageVC"];
    self.isDownloaded = false;
    self.myData = [[NSMutableArray alloc] init];
    self.session = [NSURLSession sharedSession];
    self.marker =loc;
    self.context = [self managedContext];
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
    int pageNum = arc4random_uniform(20);
    int latMax = self.marker.lat + 15;
    int lonMax = self.marker.lon + 15;
    int latMin = self.marker.lat - 15;
    int lonMin = self.marker.lon - 15;
    int imageCount = 3;
    self.myData = [NSMutableArray arrayWithArray:[self.marker.images_rel allObjects]];
    if ([self.myData count]) {
        
    }
    else {
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=APIKEYHERE&format=json&nojsoncallback=1&page=%d&per_page=%d&bbox=%d,%d,%d,%d&extras=url_m",pageNum,imageCount,lonMin,latMin,lonMax,latMax]];
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                //TODO : handle cases where less images then imageCount are returned
                for(int i =0;i<imageCount;i++){
                    NSString *temp =[NSString stringWithFormat:@"%@",json[@"photos"][@"photo"][i][@"url_m"]];
                    Image *img = [[Image alloc] initWithContext:self.context];
                    img.url = temp;
                    [self.myData addObject:img];
                }
                [self.collectionView reloadData];
            });
        }];
        [dataTask resume];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveContext];
}

#pragma mark - datasource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_myData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell * cell= [self.collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    Image *img = [self.myData objectAtIndex:indexPath.row];
    
    if (img.data) {
        [cell setImageData:img.data];
    }
    else {
        NSURLSessionDataTask *downTask = [self.session dataTaskWithURL:[NSURL URLWithString:img.url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                img.data = data;
                img.marker = self.marker;
                [self.marker addImages_relObject:img];
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


#pragma mark - core data methods

- (NSManagedObjectContext *)managedContext{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return app.persistentContainer.viewContext;
}

- (void)saveContext {
    NSError *error = nil;
    if ([self.context hasChanges] && ![self.context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"MAPc: Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
