//
//  CustomTableViewCell.h
//  autolayout-table
//
//  Created by HAP-86 on 12/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelOut;
@property (weak, nonatomic) IBOutlet UIImageView *imageOut;
@property (weak, nonatomic) IBOutlet UIImageView *accessory;

@end

NS_ASSUME_NONNULL_END
