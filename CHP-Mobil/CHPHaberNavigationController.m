//
//  CHPHaberNavigationController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPHaberNavigationController.h"

#import "APIManager.h"

#import "CHPHaberCollectionViewController.h"

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
    [[APIManager sharedInstance] getLatestNewsOnCompletion:^(NSArray *newsArray) {
        ((CHPHaberCollectionViewController*)self.viewControllers[0]).newsItemArray = newsArray;
    } onError:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue destinationViewController] isMemberOfClass:[CHPHaberCollectionViewController class]] == YES)
    {
        [[APIManager sharedInstance] getLatestNewsOnCompletion:^(NSArray *newsArray) {
            ((CHPHaberCollectionViewController*)[segue destinationViewController]).newsItemArray = newsArray;
        } onError:^(NSError *error) {
            
        }];
    }
    
}

@end
