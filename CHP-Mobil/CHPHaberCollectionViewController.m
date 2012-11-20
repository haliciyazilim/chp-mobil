//
//  CHPHaberCollectionViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPHaberCollectionViewController.h"

#import "CHPNewsItem.h"

#import "APIManager.h"

#import "CHPHaberFlowLayout.h"

#import "CHPHaberDetailTableViewController.h"

@interface CHPHaberCollectionViewController ()

@end

@implementation CHPHaberCollectionViewController

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
        self.newsItemArray = newsArray;
    } onError:^(NSError *error) {
        
    }];
    
    
    // Configure layout
    CHPHaberFlowLayout *flowLayout = [[CHPHaberFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(158, 180)];
    [flowLayout setMinimumInteritemSpacing:4];
    [flowLayout setMinimumLineSpacing:4];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView setCollectionViewLayout:flowLayout];
//    flowLayout layoutAttributesForItemAtIndexPath:<#(NSIndexPath *)#>
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.newsItemArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"NewsItemCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    CHPNewsItem *item = (CHPNewsItem*)self.newsItemArray[indexPath.row];
    
    //set title
    UILabel* titleLabel = (UILabel*)[cell viewWithTag:1];
    [titleLabel setText:item.title];
    
    NSLog(@"\nObject at index:\n%d\n",indexPath.item);
    
    //set image
    NSURL * imageURL = item.imageAddress;
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    [(UIImageView *)[cell viewWithTag:2] setImage:image];
    
    
    //set background
    [(UIImageView *)[cell viewWithTag:3] setImage:[UIImage imageNamed:@"news_shadow.png"]];
    
    //set font
    if(indexPath.row == 0){
        [titleLabel setFont:[titleLabel.font fontWithSize:18]];
    }
    else{
        [titleLabel setFont:[titleLabel.font fontWithSize:14]];
        
    }
    
    
    return cell;
}

- (void)setNewsItemArray:(NSArray *)newsItemArray {
    _newsItemArray = newsItemArray;
    
    [self.collectionView reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    UITableViewCell* cell = (UITableViewCell*) sender;
    
//    [segue ];
    
    int order = ((NSIndexPath*)[self.collectionView.indexPathsForSelectedItems objectAtIndex:0]).row;
//    NSLog(@"\n\nindex path: %d\n\n",order);
    
    CHPHaberDetailTableViewController* view = (CHPHaberDetailTableViewController*)[segue destinationViewController];
    
    [view setNewsObject:(CHPNewsItem *)[self.newsItemArray objectAtIndex:order]];
    
    
}


@end
