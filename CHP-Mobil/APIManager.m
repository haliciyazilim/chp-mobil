//
//  APIManager.m
//  CHP-Mobil
//
//  Created by Eren Halici on 14.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "APIManager.h"

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

- (NSString *)createSoapRequestForNews {
    return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><HaberleriGetir xmlns=\"http://tempuri.org/\" /></soap:Body></soap:Envelope>"];
}

- (MKNetworkOperation *)createNetworkOperationForOperation:(NSString *)operationName {
    MKNetworkOperation *op = [self operationWithPath:[self pathForOperation:operationName]
                                              params:@{@"xmlData" : [self createSoapRequestForNews]}
                                          httpMethod:@"POST"];
    
    [op setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
        return [postDataDict objectForKey:@"xmlData"];
    }
                                 forType:@"text/xml"];
    
    return op;
}

- (NSDictionary *) getDictionaryFromResponse:(NSString *)response
                                forOperation:(NSString *)operation {
    NSRange range1 = [response rangeOfString:@"<HaberleriGetirResult>"];
    NSRange range2 = [response rangeOfString:@"</HaberleriGetirResult>"];
    NSRange range = {NSMaxRange(range1), range2.location-range1.location-range2.length+1};
    NSData *responseJSON = [[response substringWithRange:range] dataUsingEncoding:NSUTF8StringEncoding];
    
    id responseObject = [NSJSONSerialization JSONObjectWithData:responseJSON options:0 error:nil];
    if ([responseObject isKindOfClass:[NSArray class]]) {
        return @{ @"hataKodu" : @"0",
                    @"result" : responseObject };
    } else {
        return @{ @"hataKodu" : [responseObject objectForKey:@"hataKodu"],
            @"hataAciklamasi" : [responseObject objectForKey:@"hataAciklamasi"],
                    @"result" : responseObject};
    }
}

#pragma mark - News

- (MKNetworkOperation *)getLatestNewsOnCompletion:(CompletionBlock)completionBlock
                                          onError:(ErrorBlock)errorBlock {
    NSString *operationName = @"HaberleriGetir";
    MKNetworkOperation *op = [self createNetworkOperationForOperation:operationName];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *responseDictionary = [self getDictionaryFromResponse:[completedOperation responseString]
                                                              forOperation:operationName];
        
        if([[responseDictionary valueForKey:@"HataKodu"] integerValue] == 1){
            NSError *apiError = [NSError errorWithDomain:@"APIError"
                                                    code:-101
                                                userInfo:@{NSLocalizedDescriptionKey : [responseDictionary valueForKey:@"HataAciklamasi"]}];
            errorBlock(apiError);
        }
        else{
            completionBlock(@"");
        }
        DLog(@"%@", responseDictionary);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (error.domain == NSURLErrorDomain && error.code == -1009) {
            NSError *connectionError = [NSError errorWithDomain:@"ConnectionError"
                                                           code:-102
                                                       userInfo:@{NSLocalizedDescriptionKey : @"İnternet bağlantısı sağlanamadı, lütfen bağlantı ayarlarınızı kontrol ederek tekrar deneyiniz."}];
            errorBlock(connectionError);
        } else {
            NSLog(@"%@", error);
            errorBlock(error);
        }
    }];
    
    [self enqueueOperation:op];
    return op;
}


@end
