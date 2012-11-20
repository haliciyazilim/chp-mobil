//
//  CHPHaberDetailTableViewController.m
//  CHP-Mobil
//
//  Created by Yunus Eren Guzel on 11/19/12.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPHaberDetailTableViewController.h"
#import "CHPNewsItem.h"

#import "CHPHaberFlowLayout.h"

@interface CHPHaberDetailTableViewController ()
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
    [[self newsContent] setText:currentItem.content];
    NSURL * imageURL = [currentItem imageAddress];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    [[self newsImage] setImage:image];
    
//    NSLog(@"\n\nheight: %f\nwidth: %f\n\n",[[self newsContent] contentSize].height,[[self newsContent] contentSize].width);
//    self.newsContentCell.frame.origin.
    [[self newsContentCell] setAccessibilityFrame:CGRectMake(
                                                self.newsContentCell.frame.origin.x,
                                                self.newsContentCell.frame.origin.y,
                                                self.newsContentCell.frame.size.width,
                                                self.newsContent.contentSize.height)];
//    [[self newsContentCell] set]
    CGRect frame = self.newsContent.frame;
    frame.size.height = self.newsContent.contentSize.height;
    self.newsContent.frame = frame;
    NSLog(@"%@",currentItem.content);
    
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2)
    {
//        [self.newsContent set];
        
        return  ceil([currentItem.content length] / 40 ) * [self.newsContent font].lineHeight + 20;
        
    }
    else if(indexPath.row == 1)
        return 200;
    else if(indexPath.row == 0)
        return 84;
    
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
