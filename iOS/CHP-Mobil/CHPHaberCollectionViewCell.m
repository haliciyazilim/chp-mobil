//
//  CHPHaberCollectionViewCell.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 04/09/15.
//  Copyright (c) 2015 Halıcı. All rights reserved.
//

#import "CHPHaberCollectionViewCell.h"

@implementation CHPHaberCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initViews];
    }
    return self;
}

- (void) initViews {
    self.imageView = [[UIImageView alloc] init];
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.contentView addSubview:self.imageView];
    
    self.shadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news_shadow.png"]];
    [self.shadowView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.shadowView.contentMode = UIViewContentModeScaleToFill;
    self.shadowView.clipsToBounds = YES;
    [self.contentView addSubview:self.shadowView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"Futura-Medium" size:12.0];
    self.titleLabel.numberOfLines = 2;
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.titleLabel];
    
    NSDictionary* views = @{@"image":self.imageView,@"shadow":self.shadowView,@"title":self.titleLabel};
    
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"H:|[image]|"
                                      options:nil metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|[image]|"
                                      options:nil metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:[shadow(48)]|"
                                      options:nil metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"H:|[shadow]|"
                                      options:nil metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"H:|-5-[title]-5-|"
                                      options:nil metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:[title(shadow)]|"
                                      options:nil metrics:nil views:views]];
    
}

@end
