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
#import "CHPHaberCollectionViewCell.h"

@interface CHPHaberCollectionViewController () 
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation CHPHaberCollectionViewController
{
    bool isRefreshNeeded;
}
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
        isRefreshNeeded = false;
        
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
    [self.collectionView registerClass:[CHPHaberCollectionViewCell class] forCellWithReuseIdentifier:@"CHPHaberCell"];

    //refresh control
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, -44*0, 320, 44)];
    [self.refreshControl addTarget:self action:@selector(refreshNews) forControlEvents:UIControlEventValueChanged];
    
    [self.refreshControl setTintColor:[UIColor whiteColor]];
//    [self.refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Son güncelleme: "]];
    [self.collectionView addSubview:self.refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
    
    //reachibility observer
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNetworkChange:)
                                                 name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    
    //set timer
    [self startTimer];
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.collectionView.alpha = 1.0;
    }];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [UIView animateWithDuration:0.2 animations:^{
        self.collectionView.alpha = 0.0;
    }];
    [super viewWillDisappear:animated];
}
- (void) startTimer {
    [NSTimer scheduledTimerWithTimeInterval:1800
                                     target:self
                                   selector:@selector(tick:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void) tick:(NSTimer *) timer {
    [self refreshNews];
    
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
    static NSString *cellIdentifier = @"CHPHaberCell";
    CHPHaberCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    CHPNewsItem *item = (CHPNewsItem*)self.newsItemArray[indexPath.row];
    if(item != nil)
    {
        //set title
        cell.titleLabel.text = item.title;
        //set font
        if(indexPath.row == 0){
            cell.titleLabel.font = [cell.titleLabel.font fontWithSize:16];
        }
        else{
            cell.titleLabel.font = [cell.titleLabel.font fontWithSize:12];
        }
        
        
        //set image
        if(indexPath.row > 0) {
            cell.imageView.image = [UIImage imageNamed:@"bosh_kucuk.png"];
        }
        else{
            cell.imageView.image = [UIImage imageNamed:@"bosh_buyuk.png"];
        }
        
        [[APIManager sharedInstance] getImageWithURLString:item.imageAddress
                                              onCompletion:^(UIImage *resultImage) {
                                                  cell.imageView.image = resultImage;
                                              } onError:^(NSError *error) {
                                                  
                                              }];
        
        
        
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"HaberDetaySegue" sender:self];
}

- (void)setNewsItemArray:(NSArray *)newsItemArray {
    _newsItemArray = newsItemArray;
    
    [self.collectionView reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    int order = ((NSIndexPath*)[self.collectionView.indexPathsForSelectedItems objectAtIndex:0]).row;
    CHPHaberDetailTableViewController* view = (CHPHaberDetailTableViewController*)[segue destinationViewController];
    [view setNewsObject:(CHPNewsItem *)[self.newsItemArray objectAtIndex:order]];
}

-(void)refreshNews
{
    [[APIManager sharedInstance]
     getLatestNewsOnCompletion:^(NSArray *newsArray) {
         self.newsItemArray = newsArray;
         [self.refreshControl endRefreshing];
//         NSDate *now = [NSDate date];
//         NSDateFormatter *formatter = nil;
//         formatter = [[NSDateFormatter alloc] init];
//         [formatter setTimeStyle:NSDateFormatterShortStyle];
//         [formatter setDateStyle:NSDateFormatterShortStyle];
//         NSString* text = @"Son güncelleme: ";
//         text = [text stringByAppendingString:[formatter stringFromDate:now]];
//         [self.refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:text]];
    } onError:^(NSError *error) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Hata" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
        isRefreshNeeded = true;
        [myAlert show];
        [self.refreshControl endRefreshing];
    }];
}

-(void)handleNetworkChange:(NSNotification *)notice{
    NetworkStatus status = [self.reachability currentReachabilityStatus];
//    NSLog(@"network changed");
    if (status == NotReachable) {
        //Change to offline Message
    } else {
        if(isRefreshNeeded)
            [self refreshNews];
    }
}

-(void)dismissLoadingView {
    [self.loadingAlert dismissWithClickedButtonIndex:11 animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

@end
