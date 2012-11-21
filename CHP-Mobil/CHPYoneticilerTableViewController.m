//
//  CHPYoneticilerTableViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPYoneticilerTableViewController.h"
#import "CHPYoneticilerDetailViewController.h"
#import "CHPYoneticilerKategoriViewController.h"
#import "CHPContactManager.h"

@interface CHPYoneticilerTableViewController ()

@end

@implementation CHPYoneticilerTableViewController

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
    
    if(self.unvanTitleArray == nil) {
        self.unvanTitleArray = @[
        @"Genel Başkan",
        @"MYK Üyesi",
        @"PM Üyesi",
        @"YDK Üyesi",
        @"Milletvekili",
        @"İl Başkanı",
        @"İlçe Başkanı",
        @"Büyükşehir Belediye Başkanı",
        @"İl Belediye Başkanı",
        @"İlçe Belediye Başkanı",
        ];
    }
    
    self.managerList = [[NSMutableDictionary alloc] initWithCapacity:[self.unvanTitleArray count]];
    
    for (int i = 0; i < 10; i++) {
        [[CHPContactManager sharedInstance] getContactsWithPosition:1<<i
                                                       onCompletion:^(NSArray *resultArray) {
                                                           [self.managerList setObject:resultArray forKey:[self.unvanTitleArray objectAtIndex:i]];
                                                       }
                                                            onError:^(NSError *error) {
                                                                //
                                                            }];
    }
    
    self.tableView.separatorColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    UIImage *searchIcon = [UIImage imageNamed:@"search_icon.png"];
    UIImageView *searchIconView = [[UIImageView alloc] initWithImage:searchIcon];
    [self.searchTextField setLeftView:searchIconView];
    [self.searchTextField setLeftViewMode:UITextFieldViewModeAlways];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UnvanCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [[cell textLabel] setText:[self.unvanTitleArray objectAtIndex:indexPath.row]];
    [[cell textLabel] setShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    selectedView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    cell.selectedBackgroundView = selectedView;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[self.managerList objectForKey:[self.unvanTitleArray objectAtIndex:indexPath.row]] count] == 1) {
        [self performSegueWithIdentifier:@"DetailSegue" sender:self];
    }
    else{
        [self performSegueWithIdentifier:@"KategoriSegue" sender:self];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"DetailSegue"]){
        int pos = [self.tableView indexPathForSelectedRow].row;
        CHPYoneticilerDetailViewController *chpYoneticilerDetailViewController = [segue destinationViewController];
        [[CHPContactManager sharedInstance] getContactWithId:[[[self.managerList objectForKey:[self.unvanTitleArray objectAtIndex:pos]] objectAtIndex:0] contactId]
                                                andInfoLevel:ContactInfoLevelFull
                                                onCompletion:^(CHPContact *contact) {
                                                    [chpYoneticilerDetailViewController setChpContact:contact];
                                                }
                                                     onError:^(NSError *error) {
                                                         //
                                                     }];
    }
    else if([[segue identifier] isEqualToString:@"KategoriSegue"]){
        int pos = [self.tableView indexPathForSelectedRow].row;
        CHPYoneticilerKategoriViewController *chpYoneticilerKategoriViewController = [segue destinationViewController];
        [chpYoneticilerKategoriViewController setContactsOfAPosition:[self.managerList objectForKey:[self.unvanTitleArray objectAtIndex:pos]]];
        [chpYoneticilerKategoriViewController setPosition:[self.unvanTitleArray objectAtIndex:pos]];
    }

}

- (IBAction)cancelSearchOperation:(id)sender {
    [self.searchTextField setText:@""];
    [self.searchTextField resignFirstResponder];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
@end
