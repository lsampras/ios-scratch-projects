//
//  MyTableCell.m
//  demo-table
//
//  Created by HAP-86 on 11/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "MyTableCell.h"

@implementation MyTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizesSubviews = YES;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        CGRect frame = self.contentView.frame;
        frame.origin.x = 16;
        frame.size.width = frame.size.width -32;
        UIView *canvas = [[UIView alloc]initWithFrame:frame];
        canvas.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        canvas.backgroundColor = UIColor.blueColor;
        canvas.clipsToBounds = YES;
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 25,25)];
        image.image = [UIImage imageNamed:@"image.png"];
//        image.autoresizingMask = UIviewauto;
        image.layer.cornerRadius = 5;
        image.layer.masksToBounds = YES;
        
        [canvas addSubview:image];
        
        [self.contentView addSubview:canvas];
        self.contentView.backgroundColor=UIColor.redColor;
        
    }
    return self;
}

-(void) setContent:(NSString*)text{
    UITextView * label = [[UITextView alloc] initWithFrame:CGRectMake(60, 5, 150, 50)];
    label.text = text;
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.clipsToBounds = YES;
    [self.contentView addSubview:label];
    
}

//-(void)setBackgroundColor:(UIColor *)backgroundColor{
//    NSLog(@"print from custom");
////    [super setBackgroundColor: backgroundColor];
//    [UIView animateWithDuration:0.5 animations:^(void){
//        [super setBackgroundColor: backgroundColor];
//    } ];
//}

@end
