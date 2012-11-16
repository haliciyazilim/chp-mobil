//
//  CHPNavigationController.m
//  CHP-Mobil
//
//  Created by Yunus Eren Guzel on 11/16/12.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPNavigationController.h"

@interface CHPNavigationController ()

@end

@implementation CHPNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UINavigationBar *navBar = self.navigationBar;
    UIImage *image = [UIImage imageNamed:@"header_bg.png"];
    UIImage *shadowImage = [UIImage imageNamed:@"header_shadow.png"];
    
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:shadowImage];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chp_logo.png"]];
    logoView.frame = CGRectMake(62,20,196,55);
    [self.navigationBar.superview addSubview:logoView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
