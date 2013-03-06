//
//  CHPList.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 01.03.2013.
//  Copyright (c) 2013 Halıcı. All rights reserved.
//

#import "CHPList.h"

@implementation CHPList

+ (CHPList *)CHPListFromDictionary:(NSDictionary *)listDictionary {
    return [[CHPList alloc] initFromDictionary:listDictionary];
}

- (id) initFromDictionary:(NSDictionary *)listDictionary {
    if (self = [super init]) {
        self.name = [listDictionary objectForKey:@"Name"];
        self.header = [listDictionary objectForKey:@"Header"];
        self.content = [[NSMutableArray alloc] initWithCapacity:3];
        for (NSDictionary* dict in [listDictionary objectForKey:@"Content"]) {
            [self.content addObject:[CHPObject CHPObjectWithDictionary:dict]];
        }
    }
    return self;
}

@end
