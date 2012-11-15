//
//  CHPYoneticilerTableViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPYoneticilerTableViewController.h"

@interface CHPYoneticilerTableViewController ()

@end

@implementation CHPYoneticilerTableViewController

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
    
    self.tableView.separatorColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    UIView *selectedView1 = [[UIView alloc] initWithFrame:CGRectMake(self.firstCell.frame.origin.x, self.firstCell.frame.origin.y, self.firstCell.frame.size.width, self.firstCell.frame.size.height)];
    selectedView1.backgroundColor = [UIColor redColor];
    self.firstCell.selectedBackgroundView = selectedView1;
    
}


- (void)viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
