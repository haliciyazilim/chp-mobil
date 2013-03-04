//
//  CHPContact.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 16.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPContact.h"

static NSMutableArray* wholeContacts;

@implementation CHPContact

+(CHPContact *)getContactWithId:(NSString *)contactId {
    for (CHPContact* contact in wholeContacts) {
        if ([contact.contactId isEqualToString:contactId]) {
            return contact;
        }
    }
    return nil;
}

+(CHPContact *)addContact:(CHPContact *)contact {
//    if (!wholeContacts) {
//        wholeContacts = [[NSMutableArray alloc] initWithCapacity:10];
//    }
//    
//    [wholeContacts addObject:contact];
    
    return nil;
}

+ (id) contactFromDictionary:(NSDictionary *)aDictionary {
    return [[CHPContact alloc] initFromDictionary:aDictionary];
}

- (id) initFromDictionary:(NSDictionary *)aDictionary {
    if (self = [super init]){
        _positionStrings = [NSMutableDictionary dictionaryWithCapacity:5];
        
        _name = aDictionary[@"AdSoyad"];
        
        NSMutableArray *phonesArray = [NSMutableArray array];
        if (aDictionary[@"PartiTelefonu"] && ![aDictionary[@"PartiTelefonu"] isKindOfClass:[NSNull class]]) {
            if ([aDictionary[@"PartiTelefonu"] isKindOfClass:[NSArray class]]) {
                for (NSString *phoneString in aDictionary[@"PartiTelefonu"]) {
                    [phonesArray addObject:[NSString stringWithFormat:@"+90%@", phoneString]];
                }
            } else {
                [phonesArray addObject:[NSString stringWithFormat:@"+90%@", aDictionary[@"PartiTelefonu"]]];
            }
        }
        _phones = phonesArray;
        
        NSMutableArray *cellPhonesArray = [NSMutableArray array];
        if (aDictionary[@"CepTelefonu"] && ![aDictionary[@"CepTelefonu"] isKindOfClass:[NSNull class]]) {
            if ([aDictionary[@"CepTelefonu"] isKindOfClass:[NSArray class]]) {
                for (NSString *phoneString in aDictionary[@"CepTelefonu"]) {
                    [cellPhonesArray addObject:[NSString stringWithFormat:@"+90%@", phoneString]];
                }
            } else {
                [cellPhonesArray addObject:[NSString stringWithFormat:@"+90%@", aDictionary[@"CepTelefonu"]]];
            }
        }
        _cellPhones = cellPhonesArray;
        
        if (aDictionary[@"Email"] && ![aDictionary[@"Email"] isKindOfClass:[NSNull class]] && ![aDictionary[@"Email"] isEqualToString:@""]) {
            _eMails = @[aDictionary[@"Email"]];
        } else {
            _eMails = @[];
        }
        
        if (aDictionary[@"YoneticiId"] && ![aDictionary[@"YoneticiId"] isKindOfClass:[NSNull class]]) {
            _contactId = [aDictionary objectForKey:@"YoneticiId"];
        } else {
            _contactId = nil;
        }
        
        if (aDictionary[@"FotoUrl"] && [aDictionary[@"FotoUrl"] isKindOfClass:[NSString class]] && ![aDictionary[@"FotoUrl"] isEqualToString:@""]) {
            _imageURL = [aDictionary objectForKey:@"FotoUrl"];
        } else {
            _imageURL = nil;
        }
        
        _infoLevel = ContactInfoLevelNone;
        
        return self;
    }
    return nil;
}

-(CHPContact *) mergeInfoFromContact:(CHPContact *)otherContact {
    if (otherContact.name) {
        self.name = otherContact.name;
    }
    
    if (otherContact.imageURL) {
        self.imageURL = otherContact.imageURL;
    }
    
    if (otherContact.phones.count > 0) {
        self.phones = otherContact.phones;
    }
    
    if (otherContact.cellPhones.count > 0) {
        self.cellPhones = otherContact.cellPhones;
    }
    
    if (otherContact.eMails.count > 0) {
        self.eMails = otherContact.eMails;
    }
    
    if (otherContact.infoLevel > self.infoLevel) {
        self.infoLevel = otherContact.infoLevel;
    }
    
    if (otherContact.positionStrings) {
        [otherContact.positionStrings enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            self.positionStrings[key] = obj;
        }];
    }
    
    self.contactId = otherContact.contactId;
    
    self.position = self.position | otherContact.position;
    
    return self;
}

-(CHPContact *) addPosition:(CHPPosition)newPosition {
    self.position = self.position | newPosition;

    return self;
}

-(NSArray *)getPositionStringsArray {
    NSMutableArray *stringsArray = [NSMutableArray arrayWithCapacity:5];
    
    int power = 1;
    
    for (int i = 0; i < 10; i++) {
        if (self.position & power) {
            [stringsArray addObject:self.positionStrings[[NSString stringWithFormat:@"%i", i]]];
        }
        
        power *= 2;
    }
    
    return stringsArray;
}

@end
