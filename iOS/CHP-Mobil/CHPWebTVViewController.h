//
//  CHPWebTVViewController.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 7.03.2014.
//  Copyright (c) 2014 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WEB_TV_URL @"http://www.chp.org.tr/custom-scripts/webtv.html"

@interface CHPWebTVViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>

@property UIWebView* webView;

@end
