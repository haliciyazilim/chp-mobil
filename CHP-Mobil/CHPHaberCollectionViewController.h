//
//  CHPHaberCollectionViewController.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHPHaberCollectionViewController : UICollectionViewController <UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *newsItemArray;

@property (nonatomic, strong) UIAlertView* loadingAlert;

- (void)dismissLoadingView;

@end
