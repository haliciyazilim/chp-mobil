//
//  CHPSearchTableViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 22.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPSearchTableViewController.h"
#import "CHPYoneticilerDetailViewController.h"
#import "CHPContactManager.h"

@interface CHPSearchTableViewController ()

@end

@implementation CHPSearchTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchResultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Futura-Medium" size:16.0];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Futura-Medium" size:12.0];
    [[cell textLabel] setText:[[self.searchResult objectAtIndex:indexPath.row] name]];
    cell.textLabel.textColor  = [UIColor whiteColor];
    NSArray *positions = [[self.searchResult objectAtIndex:indexPath.row] getPositionStringsArray];
    NSString *positionsOfCurrentContact = [[positions valueForKey:@"description"] componentsJoinedByString:@", "];
    if([cell detailTextLabel]){
        [[cell detailTextLabel] setText:positionsOfCurrentContact];
    }
    
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    selectedView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    cell.selectedBackgroundView = selectedView;
    
    UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_ok.png"]];
    cell.accessoryView = accessoryView;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate contactSelected:[self.searchResult objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.delegate searchTableViewWillBeginDragging:(UIScrollView *)scrollView];
}

-(void)setSearchResult:(NSArray *)searchResult{
    if(_searchResult != searchResult){
        _searchResult = searchResult;
    }
    if([self.searchResult count] == 0){
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    else{
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [self.tableView setSeparatorColor:[UIColor colorWithRed:0.192 green:0.192 blue:0.192 alpha:1.0]];
    }
    [self.tableView reloadData];
}



@end
