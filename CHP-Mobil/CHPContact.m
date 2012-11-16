//
//  CHPContact.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 16.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPContact.h"

@implementation CHPContact

+ (id) contactFromDictionary:(NSDictionary *)aDictionary {
    return [[CHPContact alloc] initFromDictionary:aDictionary];
}

+ (id) chpContactWithName:(NSString *)name phones:(NSArray *)phones eMails:(NSArray *)eMails {
    return [[CHPContact alloc] initWithName:name
                                     phones:phones
                                     eMails:eMails];
}

- (id) initFromDictionary:(NSDictionary *)aDictionary {
    if (self = [super init]){
        _name = aDictionary[@"AdSoyad"];
        
        NSMutableArray *phonesArray = [NSMutableArray array];
        if (![aDictionary[@"CepTelefonu"] isKindOfClass:[NSNull class]]) {
            [phonesArray addObject:[NSString stringWithFormat:@"+90%@", aDictionary[@"CepTelefonu"]]];
        }
        if (![aDictionary[@"PartiTelefonu"] isKindOfClass:[NSNull class]]) {
            [phonesArray addObject:[NSString stringWithFormat:@"+90%@", aDictionary[@"PartiTelefonu"]]];
        }
        _phones = phonesArray;

        if (![aDictionary[@"Email"] isKindOfClass:[NSNull class]]) {
            _eMails = @[aDictionary[@"Email"]];
        } else {
            _eMails = @[];
        }
        
        return self;
    }
    return nil;
}

- (id) initWithName:(NSString *)name phones:(NSArray *)phones eMails:(NSArray *)eMails {
    
    if (self = [super init]){
        _name = name;
        _phones = phones;
        _eMails = eMails;
        return self;
    }
    return nil;
}

@end
