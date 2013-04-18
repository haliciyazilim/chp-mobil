//
//  CHPContactManager.m
//  CHP-Mobil
//
//  Created by Eren Halici on 16.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "CHPContactManager.h"

@implementation CHPContactManager

static CHPContactManager *sharedInstance = nil;

#pragma mark - Singleton and init methods

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.contacts = [NSMutableDictionary dictionaryWithCapacity:200];
    }
    
    return self;
}

+ (CHPContactManager *)sharedInstance
{
    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

#pragma mark - Getting Contacts

- (MKNetworkOperation *)getContactWithId:(NSString *)contactId
                            andInfoLevel:(InfoLevel)infoLevel
                            onCompletion:(ContactBlock)contactBlock
                                 onError:(ErrorBlock)errorBlock {
    
    CHPContact *contact = [self.contacts objectForKey:contactId];
    
    if (contact) {
        if (infoLevel > contact.infoLevel) {
            return [[APIManager sharedInstance] getContactWithId:contactId onCompletion:^(CHPContact *resultContact) {
                contactBlock([CHPContact addContact:resultContact]);
            } onError:^(NSError *error) {
                errorBlock(error);
            }];
        } else {
            contactBlock(contact);
            return nil;
        }

    } else {    
        return [[APIManager sharedInstance] getContactWithId:contactId onCompletion:^(CHPContact *resultContact) {
            contactBlock([CHPContact addContact:resultContact]);
        } onError:^(NSError *error) {
            errorBlock(error);
        }];
    }
    
}

- (MKNetworkOperation *)getWholeContactsOnCompletion:(CHPObjectBlock)completionBlock
                                             onError:(ErrorBlock)errorBlock {
    return [[APIManager sharedInstance] getContactListOnCompletion:^(CHPObject *resultList) {
        completionBlock(resultList);
    } onError:^(NSError *error) {
        errorBlock(error);
    }];
}

- (NSArray *)searchContactsWithString:(NSString*)name {
    NSMutableArray *prefixes = [NSMutableArray arrayWithCapacity:4];
    
    for (NSString *prefix in [[name lowercaseString] componentsSeparatedByString:@" "]) {
        if (![prefix isEqualToString:@""]) {
            [prefixes addObject:prefix];
        }
    }
    
    if (prefixes.count == 0) {
        return @[];
    }
    
    NSMutableArray *contacts = [NSMutableArray arrayWithCapacity:20];
    
    [self.contacts enumerateKeysAndObjectsUsingBlock:^(id key, CHPContact *contact, BOOL *stop) {
        bool match = YES;
        for (NSString *prefix in prefixes) {
            bool innerMatch = NO;
            NSArray *namesArray = [contact.name componentsSeparatedByString:@" "];
            
            for (NSString *name in namesArray) {
                if ([[name lowercaseString] hasPrefix:prefix]) {
                    innerMatch = YES;
                }
            }
            
            for (NSString *position in contact.positions) {
                if ([[position lowercaseString] hasPrefix:prefix]) {
                    innerMatch = YES;
                }
            }
            
            if (!innerMatch) {
                match = NO;
            }
        }
        
        if (match) {
            [contacts addObject:contact];
        }
    }];
    [contacts sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj1 name] compare:[obj2 name]];
    }];
    
    return contacts;
}

@end
