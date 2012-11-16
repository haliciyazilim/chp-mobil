//
//  CHPContact.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 16.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPContact.h"

@implementation CHPContact

- (id) initWithName:(NSString *)name phones:(NSArray *)phones eMails:(NSArray *)eMails {
    
    if (self = [super init]){
        _name = name;
        _phones = phones;
        _eMails = eMails;
        return self;
    }
    return nil;
}
+ (id) chpContactWithName:(NSString *)name phones:(NSArray *)phones eMails:(NSArray *)eMails {
    return [[CHPContact alloc] initWithName:name
                                     phones:phones
                                     eMails:eMails];
}

@end
