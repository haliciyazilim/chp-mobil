//
//  CHPYoneticilerTableViewController.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHPSearchTableViewController.h"
#import "CHPContact.h"
#import "Reachability.h"
#import "CHPList.h"

@interface CHPYoneticilerTableViewController : UITableViewController <UITableViewDelegate, UITextFieldDelegate, SearchTableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cancelSearchButton;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
- (IBAction)cancelSearchOperation:(id)sender;

@property (strong, nonatomic) NSArray *unvanTitleArray;
@property (strong, nonatomic) NSMutableDictionary *managerList;
@property (strong, nonatomic) CHPContact *selectedContact;
@property (strong, nonatomic) UITableView *searchTable;
@property (strong, nonatomic) UIView *dummyView;
@property (strong, nonatomic) Reachability *reachability;
@property (nonatomic) CHPList *rootList;
@property (nonatomic) BOOL isListSet;
@property (nonatomic) BOOL isSearchModeEnabled;
@property (nonatomic) BOOL isAlertShown;
@property (weak, nonatomic) IBOutlet UIView *searchFieldView;

-(void)getListFromServer;
@end
