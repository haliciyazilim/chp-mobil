//
//  CHPYoneticilerDetailViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 15.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPYoneticilerDetailViewController.h"

@interface CHPYoneticilerDetailViewController ()

-(void)configureViews;

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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    if (section == 0){
        return 5;
    }
    else if(section == 1){
        return 3;
    }
    else {
        return 0;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
        return nil;
    }
    else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50.0, 30.0)];
        
        [headerView setBackgroundColor:[UIColor colorWithRed:0.420 green:0.227 blue:0.227 alpha:0.85]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, tableView.bounds.size.width - 10, 18)];
        label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
        label.font = [UIFont fontWithName:@"Futura" size:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.75];
        label.backgroundColor = [UIColor clearColor];
        [headerView addSubview:label];
        
        return headerView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
        return 0;
    }
    else{
        return 32;
    }
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

- (void)setChpContact:(CHPContact *)chpContact{
    if (_chpContact != chpContact) {
        _chpContact = chpContact;
    }
    [self configureViews];
}

- (void)configureViews{
    
}


@end
