//
//  CollectionViewCell.m
//  demo-flickr
//
//  Created by HAP-86 on 18/07/19.
//  Copyright © 2019 HAP-86. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell()
@property (nonatomic) NSURLSession *session;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) NSLayoutConstraint *aspectConstraint;
@end

@implementation ImageCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = UIColor.whiteColor;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imageView];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.image = [UIImage imageNamed:@"image.png"];
    CGFloat aspectRatio = self.imageView.image.size.width/self.imageView.image.size.height;
    self.aspectConstraint = [self.imageView.widthAnchor constraintEqualToAnchor:self.imageView.heightAnchor multiplier:aspectRatio constant:0];
    self.aspectConstraint.active = TRUE;
    [NSLayoutConstraint activateConstraints:@[[self.imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:0],
                                              [self.imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:0],
                                              [self.imageView.heightAnchor constraintLessThanOrEqualToAnchor:self.heightAnchor constant:0],
                                              [self.imageView.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor constant:0]
                                              ]];
    self.session = [NSURLSession sharedSession];
}

- (void)setImageData:(NSData *)data{
    self.imageView.image = [UIImage imageWithData:data];
}

@end
