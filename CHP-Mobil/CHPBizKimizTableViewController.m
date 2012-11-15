//
//  CHPBizKimizTableViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPBizKimizTableViewController.h"

#import "CHPBizKimizDetailViewController.h"

@interface CHPBizKimizTableViewController ()

@end

@implementation CHPBizKimizTableViewController

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
    
}

-(void)viewWillAppear:(BOOL)animated
{
//    [[self navigationController] setNavigationBarHidden:YES];
    [[self tuzukCell] setSelected:NO animated:YES];
    [[self tarihceCell] setSelected:NO animated:YES];
    [[self programCell] setSelected:NO animated:YES];
    
//    [[[self tuzukCell] selectedBackgroundView] setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8]];
    //    UITableViewCellSelectionStyle s = self.tuzukCell.selectionStyle;
    self.tuzukCell.selectionStyle = UITableViewCellSelectionStyleGray;
    self.tarihceCell.selectionStyle = UITableViewCellSelectionStyleGray;
    self.programCell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    if([[segue destinationViewController] isMemberOfClass:[CHPBizKimizDetailViewController class]] == YES)
    {
        [[segue destinationViewController] setContent:[segue identifier]];
    }
    
}
@end
