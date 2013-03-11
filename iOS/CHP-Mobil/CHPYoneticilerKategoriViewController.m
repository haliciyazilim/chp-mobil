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
#import "CHPPerson.h"

@interface CHPYoneticilerKategoriViewController ()

@end

@implementation CHPYoneticilerKategoriViewController{
    BOOL shouldEmptyTable;
}

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
    shouldEmptyTable = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setCurrentObject:(CHPList *)currentObject {
    _currentObject = currentObject;
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (![self.currentObject content]) {
//        return 0;
//    } else {
        return [[self.currentObject content] count];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"KategoriCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CHPObject *curObj = [[self.currentObject content] objectAtIndex:indexPath.row];
    
    if ([curObj isKindOfClass:[CHPList class]]) {
        [[cell textLabel] setText:[(CHPList *)curObj name]];
    } else {
        [[cell textLabel] setText:[[(CHPPerson *)curObj contact] name]];
    }

    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    selectedView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    cell.selectedBackgroundView = selectedView;

    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:0.502 green:0.0 blue:0.0 alpha:0.85]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 14, tableView.bounds.size.width - 10, 24)];
    if (![self.currentObject header]) {
        label.text = [self.currentObject name];
    } else {
        label.text = [self.currentObject header];
    }
    label.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:18];
    label.textColor = [UIColor whiteColor];
    label.shadowColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([[[[self.currentObject content] objectAtIndex:indexPath.row] content] count] == 0) {
//        shouldEmptyTable = YES;
//
//    }
    id myObj = [[self.currentObject content] objectAtIndex:indexPath.row];
    if ([myObj isKindOfClass:[CHPList class]]) {
        // chp list will open -> kategori view
        if ([[myObj content] count] == 0) {
            shouldEmptyTable = YES;
            [self performSegueWithIdentifier:@"KategoriToKategoriSegue" sender:self];
        } else {
            if ([[[(CHPList *)myObj content] objectAtIndex:0] isKindOfClass:[CHPPerson class]] && [[(CHPList *)myObj content] count] == 1) {
                self.selectedContact = [[[myObj content] objectAtIndex:0] contact];
                [self performSegueWithIdentifier:@"KategoriToDetailSegue" sender:self];
            } else {
                [self performSegueWithIdentifier:@"KategoriToKategoriSegue" sender:self];
            }
        }
    } else if ([[[self.currentObject content] objectAtIndex:indexPath.row] isKindOfClass:[CHPPerson class]]){
        self.selectedContact = [[[self.currentObject content] objectAtIndex:indexPath.row] contact];
        [self performSegueWithIdentifier:@"KategoriToDetailSegue" sender:self];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"KategoriToDetailSegue"]){
        CHPYoneticilerDetailViewController *chpYoneticilerDetailViewController = [segue destinationViewController];
        [[CHPContactManager sharedInstance] getContactWithId:[self.selectedContact contactId]
                                                andInfoLevel:ContactInfoLevelFull
                                                onCompletion:^(CHPContact *contact) {
                                                    [chpYoneticilerDetailViewController setChpContact:contact];
                                                }
                                                     onError:^(NSError *error) {
                                                         UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Hata" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
                                                         [myAlert show];
                                                         [myAlert setCancelButtonIndex:0];
                                                     }];
    }
    else if([[segue identifier] isEqualToString:@"KategoriToKategoriSegue"]){
        int pos = [self.tableView indexPathForSelectedRow].row;
        CHPYoneticilerKategoriViewController *chpYoneticilerKategoriViewController = [segue destinationViewController];
        if (!shouldEmptyTable) {
            [chpYoneticilerKategoriViewController setCurrentObject:[[self.currentObject content] objectAtIndex:pos]];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
