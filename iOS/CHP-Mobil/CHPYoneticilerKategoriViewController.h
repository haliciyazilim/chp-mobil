//
//  CHPYoneticilerKategoriViewController.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 15.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHPList.h"
#import "CHPContact.h"

@interface CHPYoneticilerKategoriViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) CHPList *currentObject;
@property (strong, nonatomic) CHPContact *selectedContact;

@end
