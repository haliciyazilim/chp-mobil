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
#import "CHPSearchTableViewCell.h"
#import "CHPPerson.h"

@interface CHPYoneticilerTableViewController ()

@end

@implementation CHPYoneticilerTableViewController
{
    CHPSearchTableViewController *searchDelegate;
    UILabel *loadingLabel;
    UIActivityIndicatorView *activity;
    BOOL isDummyHolderAdded;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}
- (id)init {

    if (self = [super init]) {
        
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.searchTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNetworkChange:)
                                                 name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    
    self.isAlertShown = NO;
    self.isListSet = NO;
    [self.searchTextField setPlaceholder:@"Arama devredışı"];
    self.searchTextField.enabled = NO;
    self.searchTextField.backgroundColor = [UIColor colorWithRed:0.651 green:0.302 blue:0.302 alpha:1.0];
//    if ([self.reachability currentReachabilityStatus] != NotReachable) {
        [self getListFromServer];
//    }
    
    self.tableView.separatorColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    UIImage *searchIcon = [UIImage imageNamed:@"search_icon.png"];
    UIImageView *searchIconView = [[UIImageView alloc] initWithImage:searchIcon];
    [self.searchTextField setLeftView:searchIconView];
    [self.searchTextField setLeftViewMode:UITextFieldViewModeAlways];
    
    self.isSearchModeEnabled = NO;
    self.searchFieldView.alpha = 0.0;
    
}
-(void)getListFromServer{
    
    [[CHPContactManager sharedInstance] getWholeContactsOnCompletion:^(CHPObject *resultList) {
        self.rootList = (CHPList *)resultList;
        self.isListSet = YES;
        [self.searchTextField setPlaceholder:@"Ara"];
        self.searchTextField.enabled = YES;
        self.searchTextField.backgroundColor = [UIColor whiteColor];
        [self removeDummyHolder];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        self.searchFieldView.alpha = 1.0;
    } onError:^(NSError *error) {
        if(!self.isAlertShown){
            UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Hata" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
            [myAlert show];
            self.isAlertShown = YES;
            self.isListSet = NO;
            [self removeDummyHolder];
        }
    }];
    [self addDummyHolder];
}
- (void)addDummyHolder {
    if (!isDummyHolderAdded) {
        isDummyHolderAdded = YES;
        
        loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, self.view.frame.size.height*0.5-80.0, self.view.frame.size.width-40.0, 100.0)];
        [loadingLabel setBackgroundColor:[UIColor clearColor]];
        [loadingLabel setText:@"Bilgiler yükleniyor! \nLütfen bekleyiniz."];
        [loadingLabel setNumberOfLines:3];
        [loadingLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:18.0]];
        [loadingLabel setTextAlignment:NSTextAlignmentCenter];
        [loadingLabel setTextColor:[UIColor whiteColor]];
        
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activity setHidesWhenStopped:YES];
        activity.frame = CGRectMake(self.view.frame.size.width*0.5-30.0, self.view.frame.size.height*0.5-140.0, 60.0, 60.0);
        [activity startAnimating];
        
        [self.view addSubview:activity];
        [self.view addSubview:loadingLabel];
        
    }
}
- (void)removeDummyHolder {
    [activity stopAnimating];
    [activity removeFromSuperview];
    activity = nil;
    [loadingLabel removeFromSuperview];
    loadingLabel = nil;
    isDummyHolderAdded = NO;
}
- (void)setRootList:(CHPList *)rootList {
    _rootList = rootList;
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!self.isSearchModeEnabled && self.rootList){
        if([self.tableView contentOffset].y < 49.0){
            NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
        }
        else{
            [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
        }    
    }
    else{
        [self.searchTable deselectRowAtIndexPath:self.searchTable.indexPathForSelectedRow animated:YES];
    }
}

- (void)handleNetworkChange:(NSNotification *)notice{
    NetworkStatus status = [self.reachability currentReachabilityStatus];
    if (status == NotReachable) {
    } else {
        if(!self.isListSet){
            [self.searchTextField setPlaceholder:@"Arama devredışı"];
            self.searchTextField.enabled = NO;
            self.searchTextField.backgroundColor = [UIColor colorWithRed:0.651 green:0.302 blue:0.302 alpha:1.0];
            [self getListFromServer];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [super viewWillDisappear:animated];
}

- (void)textFieldDidChange:(NSNotification *)notif {
    [searchDelegate setSearchResult:[[CHPContactManager sharedInstance] searchContactsWithString:self.searchTextField.text]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(!self.isSearchModeEnabled){
        CGFloat heightOfSearchView = ((UIView *)[[self.view subviews] objectAtIndex:[[self.view subviews] count]-3]).frame.size.height;
        self.searchTable = [[UITableView alloc] initWithFrame:
                            CGRectMake(
                                       self.tableView.frame.origin.x,
                                       self.tableView.frame.origin.y+heightOfSearchView,
                                       self.tableView.frame.size.width,
                                       self.tableView.frame.size.height-heightOfSearchView
                                       )
                            style:UITableViewStylePlain];
        self.dummyView = [[UIView alloc] initWithFrame:
                             CGRectMake(
                                        self.tableView.frame.origin.x,
                                        self.tableView.frame.origin.y+heightOfSearchView,
                                        self.tableView.contentSize.width,
                                        self.tableView.contentSize.height
                                        )];
        self.dummyView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0];
        
        searchDelegate = [[CHPSearchTableViewController alloc] init];
        [self.searchTable registerClass:[CHPSearchTableViewCell class] forCellReuseIdentifier:@"SearchResultCell"];
        searchDelegate.tableView = self.searchTable;
        [self.searchTable setDelegate:searchDelegate];
        searchDelegate.delegate = self;
        
        [self.searchTable setBackgroundColor:[UIColor clearColor]];
        [self.searchTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.searchTable setUserInteractionEnabled:YES];
        
        [self.view addSubview:self.dummyView];
        [self.view addSubview:self.searchTable];
        
        [self.tableView setScrollEnabled:NO];
        self.isSearchModeEnabled = YES;
    }
}


- (void) searchTableViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchTextField resignFirstResponder];
}
- (void) contactSelected:(CHPContact *)selectedContact{
    [[self searchTextField] resignFirstResponder];
    [self setSelectedContact:selectedContact];
}

- (IBAction)cancelSearchOperation:(id)sender {
    [self.searchTextField setText:@""];
    [self.searchTextField resignFirstResponder];
    [self.searchTable removeFromSuperview];
    [self.dummyView removeFromSuperview];
    [self.tableView setScrollEnabled:YES];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.isSearchModeEnabled = NO;
    self.searchTable = nil;
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
    return [[self.rootList content] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UnvanCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [[cell textLabel] setText:[[[self.rootList content] objectAtIndex:indexPath.row] name]];
    [[cell textLabel] setShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    selectedView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    cell.selectedBackgroundView = selectedView;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id myObj = [[self.rootList content] objectAtIndex:indexPath.row];
    if ([myObj isKindOfClass:[CHPList class]]) {
        // chp list will open -> kategori view
        if ([[myObj content] count] == 0) {
            [self performSegueWithIdentifier:@"KategoriSegue" sender:self];
        }
        else {
            if ([[[(CHPList *)myObj content] objectAtIndex:0] isKindOfClass:[CHPPerson class]] && [[(CHPList *)myObj content] count] == 1) {
                self.selectedContact = [[[myObj content] objectAtIndex:0] contact];
                [self performSegueWithIdentifier:@"DetailSegue" sender:self];
            }
            else {
                [self performSegueWithIdentifier:@"KategoriSegue" sender:self];
            }
        }
    }
    else if ([myObj isKindOfClass:[CHPPerson class]]) {
        self.selectedContact = [myObj contact];
        [self performSegueWithIdentifier:@"DetailSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"DetailSegue"]){
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
    else if([[segue identifier] isEqualToString:@"KategoriSegue"]){
        if(!self.isListSet){
            UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Hata" message:@"İnternet bağlantısı sağlanamadı, lütfen bağlantı ayarlarınızı kontrol ederek tekrar deneyiniz." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
            [myAlert show];
            [myAlert setCancelButtonIndex:0];
        }
        else{
            int pos = [self.tableView indexPathForSelectedRow].row;
            CHPYoneticilerKategoriViewController *chpYoneticilerKategoriViewController = [segue destinationViewController];
            [chpYoneticilerKategoriViewController setCurrentObject:[[self.rootList content] objectAtIndex:pos]];
        }
    }

}

-(void)setSelectedContact:(CHPContact *)selectedContact{
    if(_selectedContact != selectedContact){
        _selectedContact = selectedContact;
    }
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
