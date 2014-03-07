//
//  CHPWebTVViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 7.03.2014.
//  Copyright (c) 2014 Halıcı. All rights reserved.
//

#import "CHPWebTVViewController.h"
#import "APIManager.h"

@interface CHPWebTVViewController ()

@end

@implementation CHPWebTVViewController
{
    UIActivityIndicatorView* activity;
}
- (CGRect) webViewFrame
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    return CGRectMake(0.0, 0.0, screenSize.width, screenSize.height-navBarHeight-tabBarHeight);
}

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
    
    [self initMainComponents];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:WEB_TV_URL]]];
}
- (void) initMainComponents
{
    self.webView = [[UIWebView alloc] initWithFrame:[self webViewFrame]];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.delegate = self;
    [self.view addSubview:self.webView];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (activity == nil) {
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGRect webViewFrame = [self webViewFrame];
        [activity setFrame:CGRectMake(0.0,0.0,webViewFrame.size.width,webViewFrame.size.height)];
        [self.webView addSubview:activity];
        [activity setHidesWhenStopped:YES];
    }
    [activity startAnimating];
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [activity stopAnimating];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
