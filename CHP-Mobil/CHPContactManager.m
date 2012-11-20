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
            return [[APIManager sharedInstance] getContactWithId:contactId
                                                    onCompletion:^(CHPContact *newContact) {
                                                        [contact mergeInfoFromContact:newContact];
                                                        contactBlock(contact);
                                                    } onError:^(NSError *error) {
                                                        errorBlock(error);
                                                    }];
        } else {
            contactBlock(contact);
            return nil;
        }

    } else {    
        return [[APIManager sharedInstance] getContactWithId:contactId
                                                onCompletion:^(CHPContact *newContact) {
                                                    [self.contacts setObject:newContact forKey:newContact.contactId];
                                                    contactBlock(newContact);
                                                } onError:^(NSError *error) {
                                                    errorBlock(error);
                                                }];
    }
}

- (MKNetworkOperation *)getContactsWithPosition:(CHPPosition)position
                                   onCompletion:(ArrayBlock)contactArrayBlock
                                        onError:(ErrorBlock)errorBlock {
    return [[APIManager sharedInstance] getContactListForPosition:position
                                                     onCompletion:^(NSArray *resultArray) {
                                                         for (CHPContact *newContact in resultArray) {
                                                             CHPContact *oldContact = [self.contacts objectForKey:newContact.contactId];
                                                             if (oldContact) {
                                                                 [oldContact mergeInfoFromContact:newContact];
//                                                                 DLog(@"Contact: %@, Position: %d", oldContact.name, oldContact.position);
                                                             } else {
                                                                 [self.contacts setObject:newContact forKey:newContact.contactId];
//                                                                 DLog(@"Contact: %@, Position: %d", newContact.name, newContact.position);
                                                             }
                                                         }
                                                         
                                                         contactArrayBlock(resultArray);
                                                     } onError:^(NSError *error) {
                                                         errorBlock(error);
                                                     }];
}

@end
