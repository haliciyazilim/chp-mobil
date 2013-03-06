//
//  CHPContactManager.h
//  CHP-Mobil
//
//  Created by Eren Halici on 16.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CHPContact.h"
#import "APIManager.h"

@interface CHPContactManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *contacts;

+ (CHPContactManager *)sharedInstance;

- (MKNetworkOperation *)getContactWithId:(NSString *)contactId
                            andInfoLevel:(InfoLevel)infoLevel
                            onCompletion:(ContactBlock)contactBlock
                                 onError:(ErrorBlock)errorBlock;

- (MKNetworkOperation *)getWholeContactsOnCompletion:(CHPObjectBlock)completionBlock
                                           onError:(ErrorBlock)errorBlock;
- (NSArray *)searchContactsWithString:(NSString*)name;

@end
