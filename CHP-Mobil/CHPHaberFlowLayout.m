//
//  CHPHaberFlowLayout.m
//  CHP-Mobil
//
//  Created by Yunus Eren Guzel on 11/19/12.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPHaberFlowLayout.h"

@implementation CHPHaberFlowLayout

- (CGSize)collectionViewContentSize
{
    int count = [[self collectionView] numberOfItemsInSection:0];
    return CGSizeMake(
                      [self itemSize].width * 2 + [self minimumInteritemSpacing],
                      [self itemSize].height * (floor(count/2)+1) + floor(count/2)*self.minimumLineSpacing
                      );
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* arr =  [super layoutAttributesForElementsInRect:rect];
    if([arr count] == 0)
        return arr;
    
//    UICollectionViewLayoutAttributes* attr = (UICollectionViewLayoutAttributes*)[arr objectAtIndex:0];
    
//    NSLog(@"\n\ntransform: %@\n\n",[attr transform3D]);
    
    NSMutableArray* attributes = [[NSMutableArray alloc] init];
    for(int i=0; i<[self.collectionView numberOfItemsInSection:0];i++){
        UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        CGRect rect ;
        if(i==0){
           rect = CGRectMake(
                                     0,
                                     0,
                                     self.itemSize.width * 2 + self.minimumInteritemSpacing,
                                     self.itemSize.height);
        }else{
            rect = CGRectMake(
                              i%2==1?0:(self.itemSize.width + self.minimumInteritemSpacing),
                              ceil((double)i/(double)2)*(self.itemSize.height +self.minimumLineSpacing),
                              self.itemSize.width,
                              self.itemSize.height);
            
        }
        
        [attr setFrame:rect];
        [attributes addObject:attr];
        
    }
    
    
    
//
//    NSMutableArray* mutArr = [arr mutableCopy];
//    int startOffset = [(UICollectionViewLayoutAttributes*)[arr objectAtIndex:0] indexPath].item;
//    for (UICollectionViewLayoutAttributes* attr in arr) {
//        if(attr.indexPath.row == 0){
//            attr.frame = CGRectMake(
//                                    attr.frame.origin.x,
//                                    attr.frame.origin.y,
//                                    attr.frame.size.width + attr.frame.size.width + self.minimumInteritemSpacing,
//                                    attr.frame.size.height);
//        }
//        else if(attr.indexPath.row % 2 == 0){
//            attr.frame = CGRectMake(
//                                    attr.frame.origin.x + attr.frame.size.width+ self.minimumInteritemSpacing,
//                                    attr.frame.origin.y,
//                                    attr.frame.size.width,
//                                    attr.frame.size.height);
//        }
//        else{
//            attr.frame = CGRectMake(
//                                    attr.frame.origin.x - attr.frame.size.width - self.minimumInteritemSpacing,
//                                    attr.frame.origin.y + attr.frame.size.height + self.minimumLineSpacing,
//                                    attr.frame.size.width,
//                                    attr.frame.size.height);
//        }
//        [mutArr setObject:attr atIndexedSubscript:attr.indexPath.item-startOffset];
//    }
//    arr = (NSArray*) mutArr;
//    return arr;
    return (NSArray*) attributes;
}



@end
