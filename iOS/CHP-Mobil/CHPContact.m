//
//  CHPContact.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 16.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPContact.h"
#import "CHPContactManager.h"

@implementation CHPContact

+(CHPContact *)getContactWithId:(NSString *)contactId {
    return [[[CHPContactManager sharedInstance] contacts] objectForKey:contactId];
}

+(CHPContact *)addContact:(CHPContact *)contact {
    CHPContact *existedContact = [CHPContact getContactWithId:contact.contactId];
    
    if (!existedContact) {
        [[[CHPContactManager sharedInstance] contacts] setObject:contact forKey:contact.contactId];
        return contact;
    } else {
        return [existedContact mergeInfoFromContact:contact];
    }
}

+ (id) contactFromDictionary:(NSDictionary *)aDictionary {
    return [[CHPContact alloc] initFromDictionary:aDictionary];
}

- (id) initFromDictionary:(NSDictionary *)aDictionary {
    if (self = [super init]){
        _positions = [NSMutableArray arrayWithCapacity:5];
        if (aDictionary[@"Unvan"]) {
            [_positions addObject:aDictionary[@"Unvan"]];
        }

        
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
        
        _infoLevel = ContactInfoLevelBasic;
        
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
    
    for (NSString *position in otherContact.positions) {
        if (![self doesPositionAlreadyExist:position]) {
            [self.positions addObject:position];
        }
    }
    
    self.contactId = otherContact.contactId;
    
    return self;
}
-(BOOL) doesPositionAlreadyExist:(NSString *)newPosition {
    for (NSString* position in self.positions) {
        if ([position isEqualToString:newPosition]) {
            return YES;
        }
    }
    return NO;
}
-(NSString *) getAllPositionsString {
    return [self.positions componentsJoinedByString:@", "];
}
@end
