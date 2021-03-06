//
//  APIManager.h
//  CHP-Mobil
//
//  Created by Eren Halici on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "MKNetworkEngine.h"

#import "CHPContact.h"
#import "CHPObject.h"

typedef void (^CompletionBlock) (NSDictionary *responseDictionary);
typedef void (^ErrorBlock) (NSError *error);

typedef void (^ArrayBlock) (NSArray *resultArray);
typedef void (^ContactBlock) (CHPContact *resultContact);
typedef void (^StringBlock) (NSString *resultString);
typedef void (^ImageBlock) (UIImage *resultImage);
typedef void (^CHPObjectBlock) (CHPObject *resultList);

@interface APIManager : MKNetworkEngine

+ (APIManager *)sharedInstance;

- (MKNetworkOperation *)getLatestNewsOnCompletion:(ArrayBlock)completionBlock
                                          onError:(ErrorBlock)errorBlock;

- (MKNetworkOperation *)getWebTVUrlOnCompletion:(CompletionBlock)completionBlock
                                        onError:(ErrorBlock)errorBlock;

- (MKNetworkOperation *)getAboutInfoForType:(NSString *)type
                               onCompletion:(StringBlock)completionBlock
                                    onError:(ErrorBlock)errorBlock;

- (MKNetworkOperation *)getContactWithId:(NSString *)contactId
                            onCompletion:(ContactBlock)completionBlock
                                 onError:(ErrorBlock)errorBlock;


- (MKNetworkOperation *)getImageWithURLString:(NSString *)urlString
                                 onCompletion:(ImageBlock)completionBlock
                                      onError:(ErrorBlock)errorBlock;

- (MKNetworkOperation *)getContactListOnCompletion:(CHPObjectBlock)completionBlock
                                           onError:(ErrorBlock)errorBlock;

@end
