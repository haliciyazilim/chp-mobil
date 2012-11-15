//
//  CHPHaberNavigationController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPHaberNavigationController.h"

@interface CHPHaberNavigationController ()

@end

@implementation CHPHaberNavigationController

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
//    UITabBarItem *haberItem = [[UITabBarItem alloc] initWithTitle:@"Haberler" image:[UIImage imageNamed:@"btn_haber_beyaz_.png"] tag:0];
//    [haberItem setFinishedSelectedImage:[UIImage imageNamed:@"btn_haber_kirmizi_.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"btn_haber_beyaz_.png"]];
//    [self setTabBarItem:haberItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
