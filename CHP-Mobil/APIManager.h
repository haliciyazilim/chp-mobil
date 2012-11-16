//
//  APIManager.h
//  CHP-Mobil
//
//  Created by Eren Halici on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "MKNetworkEngine.h"

@class CHPContact;

typedef void (^CompletionBlock) (NSDictionary *responseDictionary);
typedef void (^ErrorBlock) (NSError *error);

typedef void (^ArrayBlock) (NSArray *newsArray);

typedef void (^ContactBlock) (CHPContact *contact);

@interface APIManager : MKNetworkEngine

+ (APIManager *)sharedInstance;

- (MKNetworkOperation *)getLatestNewsOnCompletion:(ArrayBlock)newsArrayBlock
                                          onError:(ErrorBlock)errorBlock;

- (MKNetworkOperation *)getAboutInfoForType:(NSString *)type
                               onCompletion:(CompletionBlock)completionBlock
                                    onError:(ErrorBlock)errorBlock;

- (MKNetworkOperation *)getContactListForPosition:(NSString *)position
                                     onCompletion:(ArrayBlock)contactArrayBlock
                                          onError:(ErrorBlock)errorBlock;

- (MKNetworkOperation *)getContactWithId:(NSString *)contactId
                            onCompletion:(ContactBlock)contactBlock
                                 onError:(ErrorBlock)errorBlock;

@end
