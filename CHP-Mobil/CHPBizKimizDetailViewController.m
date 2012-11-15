//
//  CHPBizKimizDetailViewController.m
//  CHP-Mobil
//
//  Created by Yunus Eren Guzel on 11/15/12.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPBizKimizDetailViewController.h"

@interface CHPBizKimizDetailViewController ()
-(void)configureView;
@end

@implementation CHPBizKimizDetailViewController

NSString* contentType;

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
    NSLog(@"setContent is called with string: %@",i);
    contentType = i;
    
}

-(void) configureView
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
}

-(void) viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO];
    [[self textView] setText:contentType];
    [self setTitle:contentType];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
