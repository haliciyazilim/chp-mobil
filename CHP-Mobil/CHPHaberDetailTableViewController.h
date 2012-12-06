//
//  CHPHaberDetailTableViewController.h
//  CHP-Mobil
//
//  Created by Yunus Eren Guzel on 11/19/12.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHPNewsItem.h"
@interface CHPHaberDetailTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *newsTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *newsContentHeight;
@property (weak, nonatomic) IBOutlet UITextView *newsContent;
-(void)setNewsObject:(CHPNewsItem*)item;
@end
