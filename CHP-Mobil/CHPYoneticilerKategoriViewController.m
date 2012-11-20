//
//  CHPYoneticilerKategoriViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 15.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPYoneticilerKategoriViewController.h"
#import "CHPYoneticilerDetailViewController.h"
#import "CHPContactManager.h"

@interface CHPYoneticilerKategoriViewController ()

@end

@implementation CHPYoneticilerKategoriViewController

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
    
    self.tableView.separatorColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contactsOfAPosition count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"KategoriCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    selectedView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    cell.selectedBackgroundView = selectedView;
    
    [[cell textLabel] setText:[[self.contactsOfAPosition objectAtIndex:indexPath.row] name]];
    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:0.502 green:0.0 blue:0.0 alpha:0.85]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 14, tableView.bounds.size.width - 10, 24)];
    label.text = self.position;
    label.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:18];
    label.textColor = [UIColor whiteColor];
    label.shadowColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    int pos = [self.tableView indexPathForSelectedRow].row;
    CHPYoneticilerDetailViewController *chpYoneticilerDetailViewController = [segue destinationViewController];
    [[CHPContactManager sharedInstance] getContactWithId:[[self.contactsOfAPosition objectAtIndex:pos] contactId]
                                            andInfoLevel:ContactInfoLevelFull
                                            onCompletion:^(CHPContact *contact) {
                                                [chpYoneticilerDetailViewController setChpContact:contact];
                                            }
                                                 onError:^(NSError *error) {
                                                     //
                                                 }];
}

-(void)setContactsOfAPosition:(NSArray *)contactsOfAPosition {
    _contactsOfAPosition = [[NSArray alloc] initWithArray:contactsOfAPosition];
    [self.tableView reloadData];
}
-(void)setPosition:(NSString *)position{
    _position = position;
    [self.tableView reloadData];
}

@end
