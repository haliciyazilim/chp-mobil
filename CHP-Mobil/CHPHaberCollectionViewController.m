//
//  CHPHaberCollectionViewController.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPHaberCollectionViewController.h"

#import "CHPNewsItem.h"

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
    
    [(UILabel *)[cell viewWithTag:1] setText:item.title];
    
    return cell;
}

- (void)setNewsItemArray:(NSArray *)newsItemArray {
    _newsItemArray = newsItemArray;
    
    [self.collectionView reloadData];
}


@end
