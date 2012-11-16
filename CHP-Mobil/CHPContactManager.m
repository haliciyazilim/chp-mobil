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
        self.contacts = [NSMutableArray arrayWithCapacity:200];
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
    for (CHPContact *contact in self.contacts) {
        if ([contact.contactId isEqualToString:contactId]) {
            if (infoLevel < contact.infoLevel) {
                contactBlock(contact);
                
                return nil;
            } else {
                return [[APIManager sharedInstance] getContactWithId:contactId
                                                        onCompletion:^(CHPContact *newContact) {
                                                            [contact mergeInfoFromContact:newContact];
                                                            contactBlock(contact);
                                                        } onError:^(NSError *error) {
                                                            errorBlock(error);
                                                        }];
            }
        }
    }
    
    return [[APIManager sharedInstance] getContactWithId:contactId
                                            onCompletion:^(CHPContact *contact) {
                                                [self.contacts addObject:contact];
                                                contactBlock(contact);
                                            } onError:^(NSError *error) {
                                                errorBlock(error);
                                            }];
}

- (MKNetworkOperation *)getContactsWithPosition:(CHPPosition)position
                                   onCompletion:(ArrayBlock)contactArrayBlock
                                        onError:(ErrorBlock)errorBlock {
    
    return nil;
}

@end
