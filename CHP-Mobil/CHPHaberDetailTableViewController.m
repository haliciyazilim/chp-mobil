//
//  CHPHaberDetailTableViewController.m
//  CHP-Mobil
//
//  Created by Yunus Eren Guzel on 11/19/12.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPHaberDetailTableViewController.h"
#import "CHPNewsItem.h"
#import "APIManager.h"
#import "CHPHaberFlowLayout.h"

@interface CHPHaberDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *newsContentCell;

@end

@implementation CHPHaberDetailTableViewController
{
    CHPNewsItem* currentItem;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        currentItem = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self configureUI];
}

- (void)setNewsObject:(CHPNewsItem*)item
{
    if(item != currentItem){
        currentItem = item;
        [self configureUI];
    }
}

-(void) configureUI
{
    if(currentItem == nil)
        return;
    [[self newsTitle] setText:currentItem.title];
    [[self dateLabel] setText:currentItem.date];
    [[self newsContent] setText:currentItem.content];
    [[APIManager sharedInstance] getImageWithURLString:[currentItem imageAddress]
                                          onCompletion:^(UIImage *resultImage) {
                                              [[self newsImage] setImage:resultImage];
                                          } onError:^(NSError *error) {
                                              
                                          }];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 3)
    {
        
        
        NSMutableString* string = [NSMutableString stringWithString:self.newsContent.text];
        int nCount = [string replaceOccurrencesOfString:@"\n" withString:@"\n" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
        CGFloat height = floor([self.newsContent.text length]/42 + nCount) * self.newsContent.font.lineHeight+30;
        [self.newsContentHeight setConstant:height];
        
        return height;
        
    }
    else if(indexPath.row == 2)
        return 25;
    else if(indexPath.row == 0)
        return 200;
    else if(indexPath.row == 1)
        return 70;
    
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
