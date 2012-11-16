//
//  CHPYoneticilerNavigationController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPYoneticilerNavigationController.h"

@interface CHPYoneticilerNavigationController ()

@end

@implementation CHPYoneticilerNavigationController

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
	
    UINavigationBar *navBar = self.navigationBar;
    UIImage *image = [UIImage imageNamed:@"header_bg.png"];
    UIImage *shadowImage = [UIImage imageNamed:@"header_shadow.png"];
    
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:shadowImage];
    
}
-(void)viewWillAppear:(BOOL)animated {
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
