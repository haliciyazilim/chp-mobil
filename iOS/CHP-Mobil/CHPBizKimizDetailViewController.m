//
//  CHPBizKimizDetailViewController.m
//  CHP-Mobil
//
//  Created by Yunus Eren Guzel on 11/15/12.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPBizKimizDetailViewController.h"
#import "APIManager.h"
@interface CHPBizKimizDetailViewController ()
-(void)configureView;
@end

@implementation CHPBizKimizDetailViewController
{
    UIActivityIndicatorView* activity;
}
NSString* contentType;

- (CGRect) webViewFrame
{
    return self.webView.frame;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        contentType = nil;
    }
    return self;
}

-(void) setContent:(NSString*) i
{
    contentType = i;
}

-(void) configureView
{
    [[self webView] setScalesPageToFit:YES];
//    NSString* fileName;
    NSString* fileUrl;
    if([contentType compare:@"Tarihçe"] == 0){
//        fileName = @"chp-tarih";
        fileUrl = @"http://www.chp.org.tr/wp-content/uploads/chp-tarihi.pdf";
    }
    else if([contentType compare:@"Program"] == 0){
//        fileName = @"chp-program";
        fileUrl = @"http://www.chp.org.tr/wp-content/uploads/chpprogram.pdf";
    }
    else if([contentType compare:@"Tüzük"]==0){
//        fileName = @"chp-tuzuk";
        fileUrl = @"http://www.chp.org.tr/wp-content/uploads/2014/08/tuzuk-son-baski.pdf";
    }
    NSURL* url = [NSURL URLWithString:fileUrl];
//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:fileName ofType:@"pdf" inDirectory:nil]];
    [[self webView] loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activity stopAnimating];
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
- (void) viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.webView.delegate = self;
    [self configureView];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[self navigationController] setNavigationBarHidden:NO animated:YES];
//    [[self textView] setText:contentType];
//    [self setTitle:contentType];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
