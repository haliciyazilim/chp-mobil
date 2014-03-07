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
    UILabel* infoLabel;
    UITapGestureRecognizer* tapGesture;
}
- (CGRect) webViewFrame
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    return CGRectMake(0.0, 0.0, screenSize.width, screenSize.height-navBarHeight-tabBarHeight);
}
- (NSString*) infoStringWithLoadingMode:(BOOL)loadingMode
{
    if (loadingMode) {
        return @"WebTV yükleniyor, lütfen bekleyiniz.";
    } else {
        return @"WebTV yüklenirken bir sorun oluştu. Tekrar denemek için buraya dokununuz.";
    }
}
- (CGRect) infoLabelFrameWithLoadingMode:(BOOL)loadingMode
{
    NSString* infoString = [self infoStringWithLoadingMode:loadingMode];
    
    CGSize labelSize = [infoString sizeWithFont:[UIFont fontWithName:@"Futura-Medium" size:14.0] constrainedToSize:CGSizeMake(260.0, 1000.0) lineBreakMode:NSLineBreakByWordWrapping];
    
    labelSize = CGSizeMake(floorf(labelSize.width), floorf(labelSize.height));
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    
    return CGRectMake(30.0, (screenSize.height-navBarHeight-tabBarHeight-labelSize.height)*0.5, 260.0, labelSize.height);
}
- (CGRect) activityFrameWithLoadingMode:(BOOL)loadingMode
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    CGRect infoLabelFrame = [self infoLabelFrameWithLoadingMode:loadingMode];
    
    return CGRectMake((screenSize.width-30.0)*0.5, infoLabelFrame.origin.y-30.0, 30.0, 30.0);
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
    [self loadWebTV];
}
- (void) removeInformationComponents
{
    [activity removeFromSuperview];
    activity = nil;
    
    [infoLabel removeFromSuperview];
    infoLabel = nil;
    
    [self.view removeGestureRecognizer:tapGesture];
}
- (void) placeInformationComponentsWithLoadingMode:(BOOL)loadingMode
{
    if (loadingMode) {
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activity setFrame:[self activityFrameWithLoadingMode:loadingMode]];
        [self.webView addSubview:activity];
        [activity setHidesWhenStopped:YES];
        [activity startAnimating];
    }
    
    infoLabel = [[UILabel alloc] initWithFrame:[self infoLabelFrameWithLoadingMode:loadingMode]];
    [infoLabel setBackgroundColor:[UIColor clearColor]];
    [infoLabel setTextAlignment:NSTextAlignmentCenter];
    [infoLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:14.0]];
    [infoLabel setTextColor:[UIColor grayColor]];
    [infoLabel setNumberOfLines:0];
    [infoLabel setText:[self infoStringWithLoadingMode:loadingMode]];
    [infoLabel setUserInteractionEnabled:YES];
    [self.webView addSubview:infoLabel];
    
    if (!loadingMode) {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadWebTV)];
        [infoLabel addGestureRecognizer:tapGesture];
    }
}
- (void) loadWebTV
{
    [self removeInformationComponents];
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:WEB_TV_URL]]];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void) initMainComponents
{
    self.webView = [[UIWebView alloc] initWithFrame:[self webViewFrame]];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.webView];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self removeInformationComponents];
    [self placeInformationComponentsWithLoadingMode:YES];
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self removeInformationComponents];
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self removeInformationComponents];
    [self placeInformationComponentsWithLoadingMode:NO];
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
