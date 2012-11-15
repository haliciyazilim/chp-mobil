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

}

-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES];
    
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
