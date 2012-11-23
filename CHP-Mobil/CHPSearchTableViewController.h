//
//  CHPSearchTableViewController.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 22.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHPContact.h"

@protocol SearchTableViewDelegate <NSObject>

- (void) searchTableViewWillBeginDragging:(UIScrollView *)scrollView;
- (void) contactSelected:(CHPContact *)selectedContact;

@end

@interface CHPSearchTableViewController : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) NSArray *searchResult;
@property (weak, nonatomic) id <SearchTableViewDelegate> delegate;

@end
