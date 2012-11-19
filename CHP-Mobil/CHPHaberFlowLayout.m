//
//  CHPHaberFlowLayout.m
//  CHP-Mobil
//
//  Created by Yunus Eren Guzel on 11/19/12.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPHaberFlowLayout.h"

@implementation CHPHaberFlowLayout

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray* arr =  [super layoutAttributesForElementsInRect:rect];
    if([arr count] == 0)
        return arr;
    
    NSMutableArray* mutArr = [arr mutableCopy];
    int startOffset = [(UICollectionViewLayoutAttributes*)[arr objectAtIndex:0] indexPath].item;
    for (UICollectionViewLayoutAttributes* attr in arr) {
        if(attr.indexPath.item == 0){
            attr.frame = CGRectMake(
                                    attr.frame.origin.x,
                                    attr.frame.origin.y,
                                    attr.frame.size.width + attr.frame.size.width + self.minimumInteritemSpacing,
                                    attr.frame.size.height);
        }
        else if(attr.indexPath.item % 2 == 0){
            attr.frame = CGRectMake(
                                    attr.frame.origin.x + attr.frame.size.width+self.minimumInteritemSpacing,
                                    attr.frame.origin.y,
                                    attr.frame.size.width,
                                    attr.frame.size.height);
        }
        else{
            attr.frame = CGRectMake(
                                    attr.frame.origin.x - attr.frame.size.width - self.minimumInteritemSpacing,
                                    attr.frame.origin.y + attr.frame.size.height +self.minimumLineSpacing,
                                    attr.frame.size.width,
                                    attr.frame.size.height);
        }
        [mutArr setObject:attr atIndexedSubscript:attr.indexPath.item-startOffset];
    }
    arr = (NSArray*) mutArr;
    return arr;
}



@end
