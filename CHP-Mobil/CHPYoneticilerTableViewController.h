//
//  CHPYoneticilerTableViewController.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHPYoneticilerTableViewController : UITableViewController <UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cancelSearchButton;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
- (IBAction)cancelSearchOperation:(id)sender;

@property (strong, nonatomic) NSArray *unvanTitleArray;
@property (strong, nonatomic) NSMutableDictionary *managerList;

@end
