//
//  ButtonController.m
//  segue-objc
//
//  Created by HAP-86 on 10/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "buttonController.h"

@interface ButtonController ()

@end

@implementation ButtonController

#pragma mark - Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(_count >0){
        [self addButton];
    }
    
}

#pragma mark - Initializers

- (id)initWithCount:(int)count{
    
    self = [super init];
    NSArray * mapping = @[@"c",@"b",@"a"];
    self.navigationItem.title = mapping[count];
    _count = count;
    return self;
}

- (void)buttonListener {
    NSLog(@"button pressed");
    UIViewController * next = [[ButtonController alloc] initWithCount:(_count-1)];
    
    NSMutableArray *arr = [[self.navigationController viewControllers] mutableCopy];
    if([arr count] > 1){
        [arr removeLastObject];
    }
    [arr addObject:next];
    [self.navigationController setViewControllers:arr animated:YES];
}

- (void)addButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(buttonListener)
     forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = UIColor.blueColor;
    [button setTitle:@"Show next View" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    button.center = self.view.center;
    [self.view addSubview:button];
    
}


@end
