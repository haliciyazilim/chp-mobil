//
//  APIManager.m
//  CHP-Mobil
//
//  Created by Eren Halici on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "APIManager.h"

#import "CHPNewsItem.h"
#import "CHPContact.h"

@implementation APIManager

static APIManager *sharedInstance = nil;

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
    self = [super initWithHostName:@"bilisim.chp.org.tr"
                customHeaderFields:@{@"x-client-identifier" : @"iOS",
            @"Content-Type" : @"text/xml"}];
    
    if (self) {
        // Initialization code here.
        [self useCache];
    }
    
    return self;
}

+ (APIManager *)sharedInstance
{
    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

#pragma mark - Caching

- (NSString*) cacheDirectoryName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:@"chpMobileAPICache"];
    return cacheDirectoryName;
}

#pragma mark - Helpers

- (NSString *)pathForOperation:(NSString *)operation {
    return [NSString stringWithFormat:@"MobilService.asmx?op=%@", operation];
}

- (MKNetworkOperation *)createNetworkOperationForOperation:(NSString *)operationName
                                             andParameters:(NSDictionary *)parameters
                                              onCompletion:(CompletionBlock)completionBlock
                                                   onError:(ErrorBlock)errorBlock {
    __block NSString *parametersString = @"";
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        parametersString = [parametersString stringByAppendingFormat:@"<%@>%@</%@>", key, obj, key];
        stop = NO;
    }];
    
    
    NSString *xmlString = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><%@ xmlns=\"http://tempuri.org/\">%@</%@></soap:Body></soap:Envelope>", operationName, parametersString, operationName];
    
    
    
    MKNetworkOperation *op = [self operationWithPath:[self pathForOperation:operationName]
                                              params:@{@"xmlData" : xmlString}
                                          httpMethod:@"POST"];
    
    [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
        return [postDataDict objectForKey:@"xmlData"];
    }
                                 forType:@"text/xml"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        DLog(@"Response: %@", [completedOperation responseString]);
        NSDictionary *responseDictionary = [self getDictionaryFromResponse:[completedOperation responseString]
                                                              forOperation:operationName];
        
        if([[responseDictionary valueForKey:@"HataKodu"] integerValue] == 1){
            NSError *apiError = [NSError errorWithDomain:@"APIError"
                                                    code:-101
                                                userInfo:@{NSLocalizedDescriptionKey : [responseDictionary valueForKey:operationName]}];
            errorBlock(apiError);
        }
        else{
            completionBlock(responseDictionary);
        }
//        DLog(@"%@", responseDictionary);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (error.domain == NSURLErrorDomain && error.code == -1009) {
            NSError *connectionError = [NSError errorWithDomain:@"ConnectionError"
                                                           code:-102
                                                       userInfo:@{NSLocalizedDescriptionKey : @"İnternet bağlantısı sağlanamadı, lütfen bağlantı ayarlarınızı kontrol ederek tekrar deneyiniz."}];
            errorBlock(connectionError);
        } else {
//            NSLog(@"%@", error);
            errorBlock(error);
        }
    }];
    
    [self enqueueOperation:op];
    return op;

}

- (NSDictionary *) getDictionaryFromResponse:(NSString *)response
                                forOperation:(NSString *)operation {
    NSRange range1 = [response rangeOfString:[NSString stringWithFormat:@"<%@Result>", operation]];
    NSRange range2 = [response rangeOfString:[NSString stringWithFormat:@"</%@Result>", operation]];
    NSRange range = {NSMaxRange(range1), range2.location-range1.location-range2.length+1};
    NSData *responseJSON = [[response substringWithRange:range] dataUsingEncoding:NSUTF8StringEncoding];
    
    id responseObject = [NSJSONSerialization JSONObjectWithData:responseJSON options:0 error:nil];
    
    if (!responseObject) {
        return @{ @"hataKodu" : @"1",
            @"hataAciklamasi" : [NSString stringWithFormat:@"Result is not a proper JSON object. It is: %@", [response substringWithRange:range]]};
    }
    
    if ([responseObject isKindOfClass:[NSArray class]]) {
        return @{ @"hataKodu" : @"0",
                    @"result" : responseObject };
    } else {
        if ([responseObject objectForKey:@"hataKodu"]) {
            return @{ @"hataKodu" : @"1",
                    @"hataAciklamasi" : [responseObject objectForKey:@"hataAciklamasi"],
                    @"result" : responseObject};
        } else {
            return @{ @"hataKodu" : @"0",
                    @"result" : responseObject};
        }
    }
}

#pragma mark - News

- (MKNetworkOperation *)getLatestNewsOnCompletion:(ArrayBlock)newsArrayBlock
                                          onError:(ErrorBlock)errorBlock {
    return [self createNetworkOperationForOperation:@"HaberleriGetir"
                                      andParameters:nil
                                       onCompletion:^(NSDictionary *responseDictionary) {
                                           NSMutableArray *newsArray = [NSMutableArray arrayWithCapacity:5];
                                           
                                           for (NSDictionary *newsItemDictionary in responseDictionary[@"result"]) {
                                               [newsArray addObject:[CHPNewsItem newsItemFromDictionary:newsItemDictionary]];
                                           }
                                           
                                           for (NSDictionary *newsItemDictionary in responseDictionary[@"result"]) {
                                               [newsArray addObject:[CHPNewsItem newsItemFromDictionary:newsItemDictionary]];
                                           }
                                           for (NSDictionary *newsItemDictionary in responseDictionary[@"result"]) {
                                               [newsArray addObject:[CHPNewsItem newsItemFromDictionary:newsItemDictionary]];
                                           }
                                           
                                           for (NSDictionary *newsItemDictionary in responseDictionary[@"result"]) {
                                               [newsArray addObject:[CHPNewsItem newsItemFromDictionary:newsItemDictionary]];
                                           }
                                           for (NSDictionary *newsItemDictionary in responseDictionary[@"result"]) {
                                               [newsArray addObject:[CHPNewsItem newsItemFromDictionary:newsItemDictionary]];
                                           }
                                           
                                           for (NSDictionary *newsItemDictionary in responseDictionary[@"result"]) {
                                               [newsArray addObject:[CHPNewsItem newsItemFromDictionary:newsItemDictionary]];
                                           }
                                           
                                           
                                           newsArrayBlock(newsArray);
                                       }
                                            onError:^(NSError *error) {
                                                errorBlock(error);
                                            }];
}

- (MKNetworkOperation *)getAboutInfoForType:(NSString *)type
                               onCompletion:(StringBlock)completionBlock
                                    onError:(ErrorBlock)errorBlock {
    return [self createNetworkOperationForOperation:@"BizKimizBilgisiGetir"
                                      andParameters:@{@"baslik" : type}
                                       onCompletion:^(NSDictionary *responseDictionary) {
                                           completionBlock(responseDictionary[@"result"]);
                                       }
                                            onError:^(NSError *error) {
                                                errorBlock(error);
                                            }];
}

- (MKNetworkOperation *)getContactListForPosition:(CHPPosition)position
                                     onCompletion:(ArrayBlock)contactArrayBlock
                                          onError:(ErrorBlock)errorBlock {
    int index = 1;
    int power = 1;
    while (!(position & power)) {
        power *= 2;
        index++;
    }
    
    return [self createNetworkOperationForOperation:@"YoneticiListesiGetir"
                                      andParameters:@{@"unvanId" : [NSString stringWithFormat:@"%d", index]}
                                       onCompletion:^(NSDictionary *responseDictionary) {
                                           NSMutableArray *contactArray = [NSMutableArray arrayWithCapacity:10];
                                           
                                           for (NSDictionary *contactDictionary in responseDictionary[@"result"]) {
                                               CHPContact *contact = [CHPContact contactFromDictionary:contactDictionary];
                                               contact.position = power;
                                               contact.infoLevel = ContactInfoLevelBasic;
                                               [contactArray addObject:contact];
                                           }
                                           
                                           contactArrayBlock(contactArray);
                                       }
                                            onError:^(NSError *error) {
                                                errorBlock(error);
                                            }];
}

- (MKNetworkOperation *)getContactWithId:(NSString *)contactId
                            onCompletion:(ContactBlock)contactBlock
                                 onError:(ErrorBlock)errorBlock {
    return [self createNetworkOperationForOperation:@"YoneticiDetayGetir"
                                      andParameters:@{@"yoneticiId" : contactId}
                                       onCompletion:^(NSDictionary *responseDictionary) {
                                           CHPContact *contact = [CHPContact contactFromDictionary:responseDictionary[@"result"]];
                                           contact.contactId = contactId;
                                           contact.infoLevel = ContactInfoLevelFull;
                                           contactBlock(contact);
                                       }
                                            onError:^(NSError *error) {
                                                errorBlock(error);
                                            }];
};


#pragma mark - Getting images

- (MKNetworkOperation *)getImageWithURLString:(NSString *)urlString
                                 onCompletion:(ImageBlock)completionBlock
                                      onError:(ErrorBlock)errorBlock {
    MKNetworkOperation *op = [self operationWithURLString:urlString];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        completionBlock([completedOperation responseImage]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

@end
