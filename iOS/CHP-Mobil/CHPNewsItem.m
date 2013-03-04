//
//  CHPNewsItem.m
//  CHP-Mobil
//
//  Created by Eren Halici on 15.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPNewsItem.h"

@implementation CHPNewsItem

+ (id) newsItemFromDictionary:(NSDictionary *)aDictionary {
    return [[CHPNewsItem alloc] initFromDictionary:aDictionary];
}

- (id) initFromDictionary:(NSDictionary *)aDictionary {
    if(self = [super init]) {
        _date = aDictionary[@"Tarih"];
        _title = aDictionary[@"Baslik"];
        _content = aDictionary[@"Icerik"];
       _imageAddress = aDictionary[@"HaberResmi"];
        
        return self;
    }
    
    return nil;
}


@end
