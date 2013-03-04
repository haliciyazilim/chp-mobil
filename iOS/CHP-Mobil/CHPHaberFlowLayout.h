//
//  CHPHaberFlowLayout.h
//  CHP-Mobil
//
//  Created by Yunus Eren Guzel on 11/19/12.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHPHaberFlowLayout : UICollectionViewFlowLayout


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect;
- (CGSize)collectionViewContentSize;
@end