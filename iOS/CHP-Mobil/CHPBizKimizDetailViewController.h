//
//  CHPBizKimizDetailViewController.h
//  CHP-Mobil
//
//  Created by Yunus Eren Guzel on 11/15/12.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHPBizKimizDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
-(void) setContent:(NSString*) i;
@end
