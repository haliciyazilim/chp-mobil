//
//  CHPMainTabBarViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPMainTabBarViewController.h"

@interface CHPMainTabBarViewController ()

@end

@implementation CHPMainTabBarViewController

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
    
    UITabBar *appTabBar = [self tabBar];
    
    [appTabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg.png"]];
    [appTabBar setShadowImage:[UIImage imageNamed:@"tab_shadow.png"]];
    
    [appTabBar setSelectionIndicatorImage:[[UIImage alloc] init]];
    
    UITabBarItem *item0 = [[appTabBar items] objectAtIndex:0];
    UITabBarItem *item1 = [[appTabBar items] objectAtIndex:1];
    UITabBarItem *item2 = [[appTabBar items] objectAtIndex:2];
    UITabBarItem *item3 = [[appTabBar items] objectAtIndex:3];
    [item0 setFinishedSelectedImage:[UIImage imageNamed:@"btn_haber_beyaz_.png"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"btn_haber_kirmizi_.png"]];
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"btn_kurumsal_beyaz_.png"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"btn_kurumsal_kirmizi_.png"]];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"btn_yonetim_beyaz_.png"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"btn_yonetim_kirmizi_.png"]];
    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"btn_webtv_beyaz_.png"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"btn_webtv_kirmizi_.png"]];
    [item0 setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor redColor], UITextAttributeTextColor,
      [UIColor blackColor], UITextAttributeTextShadowColor,
      nil] forState:UIControlStateNormal];
    [item0 setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], UITextAttributeTextColor,
      [UIColor blackColor], UITextAttributeTextShadowColor,
      nil] forState:UIControlStateSelected];
    [item1 setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor redColor], UITextAttributeTextColor,
      [UIColor blackColor], UITextAttributeTextShadowColor,
      nil] forState:UIControlStateNormal];
    [item1 setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], UITextAttributeTextColor,
      [UIColor blackColor], UITextAttributeTextShadowColor,
      nil] forState:UIControlStateSelected];
    [item2 setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor redColor], UITextAttributeTextColor,
      [UIColor blackColor], UITextAttributeTextShadowColor,
      nil] forState:UIControlStateNormal];
    [item2 setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], UITextAttributeTextColor,
      [UIColor blackColor], UITextAttributeTextShadowColor,
      nil] forState:UIControlStateSelected];
    [item3 setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor redColor], UITextAttributeTextColor,
      [UIColor blackColor], UITextAttributeTextShadowColor,
      nil] forState:UIControlStateNormal];
    [item3 setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], UITextAttributeTextColor,
      [UIColor blackColor], UITextAttributeTextShadowColor,
      nil] forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
