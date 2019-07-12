//
//  ViewController.m
//  demo-table
//
//  Created by HAP-86 on 11/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "ViewController.h"
#import "MyTableCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myData = [[NSMutableArray alloc]initWithObjects:
              @"Data 0 in array",@"Data 1 in array",@"Data 2 in array",@"Data 3 in array",
              @"Data 4 in array",@"Data 5 in array",
              @"Data 6 in array",@"Data 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in array",@"Data 8 in array",
              @"Data 9 in array", nil];
    
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate = self;
//    pict = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,20,10)];
//    pict =[UIImage imageNamed:@"image.png"];
    
    [self.view addSubview:tableView];
}

#pragma mark - datasource methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MyTableCell *cell = [[MyTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
//    cell.imageView.image = pict;
    
//    [cell setContent:]
    [cell setContent:[myData objectAtIndex:(indexPath.section ==0)?indexPath.row:indexPath.row+4]];
//    [cell sette]
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Header";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"Footer";
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}



#pragma mark - table view delegate methods



@end
