//
//  CHPYoneticilerDetailViewController.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 15.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHPContact;

@interface CHPYoneticilerDetailViewController : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) CHPContact *chpContact;
@property (strong, nonatomic) NSArray *positionsOfContact;

@end
