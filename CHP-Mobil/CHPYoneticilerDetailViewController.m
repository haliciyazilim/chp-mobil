//
//  CHPYoneticilerDetailViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 15.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPYoneticilerDetailViewController.h"

@interface CHPYoneticilerDetailViewController ()

@end

@implementation CHPYoneticilerDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if([[UIScreen mainScreen] bounds].size.height == 568){
        UIImage *image = [UIImage imageNamed:@"main_bg-568h@2x.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        self.tableView.backgroundView = imageView;
    }
    else{
        UIImage *image = [UIImage imageNamed:@"main_bg.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        self.tableView.backgroundView = imageView;
    }
    
    self.tableView.separatorColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
}
- (void)viewWillAppear:(BOOL)animated {
    self.detailLabel.text = self.surname;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 3;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"Telefon";
    }
    else {
        return @"E-posta";
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"detailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    return cell;
}


@end
