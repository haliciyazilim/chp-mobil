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
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation CHPHaberCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.loadingAlert = [[UIAlertView alloc] initWithTitle:@"Lütfen Bekleyiniz." message:@"Seçmen bilgileriniz yükleniyor.." delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        UIActivityIndicatorView *myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        myIndicator.hidesWhenStopped = YES;
        //    myIndicator.color = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:1];
        [self.loadingAlert addSubview:myIndicator];
        [self.loadingAlert show];
        [myIndicator setFrame: CGRectMake(110, 64, 60, 60)];
        [myIndicator startAnimating];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self refreshNews];
    
    // Configure layout
    CHPHaberFlowLayout *flowLayout = [[CHPHaberFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(158, 180)];
    [flowLayout setMinimumInteritemSpacing:4];
    [flowLayout setMinimumLineSpacing:4];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView setCollectionViewLayout:flowLayout];

    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, -44*0, 320, 44)];
    [self.collectionView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshNews) forControlEvents:UIControlEventValueChanged];
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
    if(item != nil)
    {
        //set title
        UILabel* titleLabel = (UILabel*)[cell viewWithTag:1];
        [titleLabel setText:item.title];
        
        //set image
        [[APIManager sharedInstance] getImageWithURLString:item.imageAddress
                                              onCompletion:^(UIImage *resultImage) {
                                                  [(UIImageView *)[cell viewWithTag:2] setImage:resultImage];
                                              } onError:^(NSError *error) {
                                                  
                                              }];
        
        
        //set background
        [(UIImageView *)[cell viewWithTag:3] setImage:[UIImage imageNamed:@"news_shadow.png"]];
        
        //set font
        if(indexPath.row == 0){
            [titleLabel setFont:[titleLabel.font fontWithSize:16]];
            //        [titleLabel set ]
        }
        else{
            [titleLabel setFont:[titleLabel.font fontWithSize:12]];
            
        }
        
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

-(void)refreshNews
{
    [[APIManager sharedInstance] getLatestNewsOnCompletion:^(NSArray *newsArray) {
        self.newsItemArray = newsArray;
        [self.refreshControl endRefreshing];
    } onError:^(NSError *error) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Hata" message:@"İnternet bağlantısı sağlanamadı, lütfen bağlantı ayarlarınızı kontrol ederek tekrar deneyiniz." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
        [myAlert show];
        [self.refreshControl endRefreshing];
    }];
}

-(void)dismissLoadingView {
    [self.loadingAlert dismissWithClickedButtonIndex:11 animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    NSLog(@"event is called");
}

@end
