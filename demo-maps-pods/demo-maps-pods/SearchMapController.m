//
//  SearchMapController.m
//  demo-maps-pods
//
//  Created by HAP-86 on 17/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "SearchMapController.h"

@interface SearchMapController ()
@property (nonatomic) CLLocationCoordinate2D externalLoc;
@property (nonatomic) NSString * name;

@end

@implementation SearchMapController


- (instancetype)initWithLoc:(CLLocationCoordinate2D)loc name:(NSString *)name {
    
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.externalLoc = loc;
        self.name = name;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateCamera:self.externalLoc];
    [self addMarker:self.name :self.externalLoc];
}


@end
