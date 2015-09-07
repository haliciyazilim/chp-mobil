//
//  CHPSearchTableViewCell.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 22.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPSearchTableViewCell.h"

@implementation CHPSearchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
