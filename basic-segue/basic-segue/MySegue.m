//
//  MySegue.m
//  demo3
//
//  Created by HAP-86 on 10/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "MySegue.h"

@implementation MySegue


-(void)perform {
    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    UINavigationController *navigationController = sourceViewController.navigationController;
    UIViewController *rootController = [[navigationController viewControllers] firstObject];
    
    NSArray *arr = @[rootController,destinationController];
    
    [navigationController setViewControllers:arr animated:YES];
    
}

@end
