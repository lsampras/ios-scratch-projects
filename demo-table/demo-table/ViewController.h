//
//  ViewController.h
//  demo-table
//
//  Created by HAP-86 on 11/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController < UITableViewDataSource, UITableViewDelegate > {
    NSMutableArray *myData;
    UITableView * tableView;
    UIImage *pict;
}



@end

