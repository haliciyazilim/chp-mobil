//
//  APIManager.h
//  CHP-Mobil
//
//  Created by Eren Halici on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "MKNetworkEngine.h"

typedef void (^CompletionBlock) (NSString *response);
typedef void (^ErrorBlock) (NSError *error);

@interface APIManager : MKNetworkEngine

+ (APIManager *)sharedInstance;

- (MKNetworkOperation *)getLatestNewsOnCompletion:(CompletionBlock)completionBlock
                                          onError:(ErrorBlock)errorBlock;

- (MKNetworkOperation *)getAboutInfoForType:(NSString *)type
                               onCompletion:(CompletionBlock)completionBlock
                                    onError:(ErrorBlock)errorBlock;

@end
