//
//  CHPSearchTableViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 22.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPSearchTableViewController.h"
#import "CHPContact.h"

@interface CHPSearchTableViewController ()

@end

@implementation CHPSearchTableViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[self.searchResult count]);
    return [self.searchResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"entered cellForRowAt...");
    static NSString *CellIdentifier = @"SearchResultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    [[cell textLabel] setText:[[self.searchResult objectAtIndex:indexPath.row] name]];
    cell.textLabel.textColor  = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    NSArray *positions = [[self.searchResult objectAtIndex:indexPath.row] getPositionStrings];
    NSString *positionsOfCurrentContact = [[positions valueForKey:@"description"] componentsJoinedByString:@", "];
    NSLog(@"%@",positionsOfCurrentContact);
    [[cell detailTextLabel] setText:positionsOfCurrentContact];
    
    
    
    // Configure the cell...
    
    return cell;
}

-(void)setSearchResult:(NSArray *)searchResult{
    NSLog(@"entered setSearchResult");
    NSLog(@"%@", searchResult);
    if(_searchResult != searchResult){
        _searchResult = searchResult;
    }
    NSLog(@"%@",self.searchResult);
    [self.tableView reloadData];
}



@end
