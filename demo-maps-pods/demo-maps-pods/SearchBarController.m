//
//  SearchController.m
//  demo-maps-pods
//
//  Created by HAP-86 on 16/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "SearchBarController.h"

@interface SearchBarController ()

@property (nonatomic) NSArray<GMSAutocompletePrediction *> *myData;
@property (nonatomic) GMSAutocompleteSessionToken *token;
@property (nonatomic) BOOL valid;
@property (nonatomic) GMSPlacesClient *placesClient;
@property (nonatomic) GMSAutocompleteFilter * filter;
    
@end

@implementation SearchBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.valid = false;
    self.placesClient = [GMSPlacesClient sharedClient];
    
    self.table.dataSource = self;
    self.table.delegate = self;
    self.searchBar.delegate = self;
    self.filter = [[GMSAutocompleteFilter alloc] init];
    self.filter.type = kGMSPlacesAutocompleteTypeFilterEstablishment;
    
    [self.view addSubview:self.table];
}
#pragma mark search bar methods
    
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if(self.token == nil){
        self.token = [[GMSAutocompleteSessionToken alloc]init];
    }
    
    if (searchText.length > 0) {
     
        [_placesClient findAutocompletePredictionsFromQuery:searchText bounds:nil boundsMode:kGMSAutocompleteBoundsModeBias
                                                     filter:_filter sessionToken:self.token
                                                   callback:^(NSArray<GMSAutocompletePrediction *> * _Nullable results, NSError * _Nullable error) {
                                                       if (error != nil) {
                                                           self.valid = false;
                                                           NSLog(@"An error occurred %@", [error localizedDescription]);
                                                           return;
                                                       }
                                                       if (results != nil) {
                                                           self.valid = true;
                                                           self.myData = results;
                                                           [self.table reloadData];
                                                       }
                                                   }
         ];
    }
    else {
        self.myData = @[];
        [self.table reloadData];
    }
}
    
    
#pragma mark table methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.valid?[self.myData count]:1;
}
    
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}
    
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    cell.userInteractionEnabled = YES;
    if(self.valid){
        cell.textLabel.text = [[_myData objectAtIndex:indexPath.row].attributedPrimaryText string];
        
    }else{
        cell.textLabel.text = @"No results";
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GMSAutocompletePrediction * pred = [self.myData objectAtIndex:indexPath.row];
    GMSPlaceField fields = (GMSPlaceFieldName | GMSPlaceFieldCoordinate);
    
    [_placesClient fetchPlaceFromPlaceID:pred.placeID
                                       placeFields:fields sessionToken:self.token
                                          callback:^(GMSPlace * _Nullable result, NSError * _Nullable error) {
        {
            CLLocationCoordinate2D loc;
            NSString *name;
            if(error){
                NSLog(@"log:%@",error.localizedDescription);
                /* I am using a placeholder location for handling errors since I wanted to test rest of the functionality
                 * handle your errors appropriately. BTW placeholder location is Mumbai T2 airport.
                 */
                
                CLLocationDegrees lat = 19.0895088;
                CLLocationDegrees lon =  72.8697249;
                loc = CLLocationCoordinate2DMake(lat, lon);
                name = @"Mumbai Airport";
            }else{
                loc = result.coordinate;
                name = result.name;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.token = nil;
                SearchMapController *map = [[SearchMapController alloc] initWithLoc:loc name:name];
                [self.navigationController pushViewController:map animated:YES];
            });
        }
    }];
}

@end
