//
//  CHPYoneticilerTableViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPYoneticilerTableViewController.h"
#import "CHPYoneticilerDetailViewController.h"

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
    
    if(self.unvanArray == nil) {
        self.unvanArray = @[
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
    
    
//    if([[UIScreen mainScreen] bounds].size.height == 568){
//        UIImage *image = [UIImage imageNamed:@"main_bg-568h@2x.png"];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        self.tableView.backgroundView = imageView;
//    }
//    else{
//        UIImage *image = [UIImage imageNamed:@"main_bg.png"];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        self.tableView.backgroundView = imageView;
//    }
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UnvanCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [[cell textLabel] setText:[self.unvanArray objectAtIndex:indexPath.row]];
    
    UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    selectedView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    cell.selectedBackgroundView = selectedView;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        [self performSegueWithIdentifier:@"DetailSegue" sender:self];
    }
    else{
        [self performSegueWithIdentifier:@"KategoriSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"DetailSegue"]){
        CHPYoneticilerDetailViewController *chpYoneticilerDetailViewController = [segue destinationViewController];
        [chpYoneticilerDetailViewController setSurname:@"Kilicdaroglu"];
    }
    else if([[segue identifier] isEqualToString:@"KategoriSegue"]){
        
    }
}

@end
