//
//  CHPPerson.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 01.03.2013.
//  Copyright (c) 2013 Halıcı. All rights reserved.
//

#import "CHPPerson.h"
#import "CHPContact.h"

@implementation CHPPerson

+ (CHPPerson *)CHPPersonFromDictionary:(NSDictionary *)personDictionary {
    return [[CHPPerson alloc] initFromDictionary:personDictionary];
}

- (id) initFromDictionary:(NSDictionary *)personDictionary {
    if (self = [super init]) {
        CHPContact *contact = [CHPContact contactFromDictionary:personDictionary];
        self.contact = [CHPContact addContact:contact];
    }
    
    return self;
}

- (void) content {
    NSLog(@"I'm here");
}

@end
