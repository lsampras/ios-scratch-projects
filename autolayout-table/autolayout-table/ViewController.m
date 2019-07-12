//
//  ViewController.m
//  autolayout-table
//
//  Created by HAP-86 on 12/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()
@property NSMutableArray *myData;
@property UITableView* tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myData = [[NSMutableArray alloc]initWithObjects:
              @"Data 0 in array",@"Data 1 in array",@"Data 2 in array",@"Data 3 in array",
              @"Data 4 in array",@"Data 5 in array",
              @"Data 6 in array",@"Data 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in arrayData 7 in array",@"Data 8 in array",
              @"Data 9 in array", nil];
    
//   self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
    //    pict = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,20,10)];
    //    pict =[UIImage imageNamed:@"image.png"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 300;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 30;
    self.tableView.estimatedSectionHeaderHeight = 30;
    
    
    [self.view addSubview:self.tableView];
}

#pragma mark - datasource methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
//    CustomTableViewCell *cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass(CustomTableViewCell.class)];
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.labelOut.text = [_myData objectAtIndex:(indexPath.section ==0)?indexPath.row:indexPath.row+4];
//    cell.labelOut.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
//    cell.labelout = [[UILabel alloc] init];
//    cell.labelOut.text =
    
    cell.imageOut.image = [UIImage imageNamed:@"image.png"];
    cell.accessory.image = [UIImage imageNamed:@"image.png"];
//    NSLayoutConstraint *imageConst = [[NSLayoutConstraint alloc] set]
//    cell.imageOut.center.y = cell.contentView.center.y;

    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Header";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"Footer";
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_myData count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



#pragma mark - table view delegate methods



@end
