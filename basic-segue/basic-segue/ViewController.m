//
//  ViewController.m
//  demo3
//
//  Created by HAP-86 on 09/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) NSString *text;
- (int) getFibonacci:(int)n;

- (void) printFbSeries:(int)n;


- (NSMutableArray *) fibonacciDP:(int)n;

@end

@implementation ViewController
@synthesize text;

- (void)viewDidLoad {
    [super viewDidLoad];
     
     
//     [self printSeries:5];
    NSMutableArray * fbSeries = [self fibonacciDP:9];
    NSLog(@"FIBONACCI:\n%@", fbSeries);
}


- (NSMutableArray *)fibonacciDP:(int)n {
    
    NSMutableArray *myArray = [NSMutableArray array];
    int temp1 = 1;
    int temp2 = 1;
    int curr;
    for(int i = 0; i < n; i++) {
        if(i == 1 || i == 0){
            [myArray addObject:@(1)];
            continue;
        }
        curr = temp1+ temp2;
        temp1 = temp2;
        temp2 = curr;
        [myArray addObject:@(curr)];
    }
    return myArray;
}

- (void)printFbSeries:(int)n {
    
    NSLog(@"Fibonacci series upto %d terms.",n);
    for (int i = 0; i< n; i++) {
        NSLog(@"%d,",[self getFibonacci:i+1]);
    }
}

- (int)getFibonacci:(int)n {
    
    if(n < 2){
        return n;
    }
    else {
        return [self getFibonacci:n-1] + [self getFibonacci:n-2];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (IBAction)buttonPressed:(UIButton *)sender {
    
//    NSLog(@"Button Presed");
//    int red = arc4random_uniform(256);
//    int blue = arc4random_uniform(256);
//    int green = arc4random_uniform(256);
//
//    UIColor *newcolor = [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:0.5];
//    self.view.backgroundColor = newcolor;
}


@end
