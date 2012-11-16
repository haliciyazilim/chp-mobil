//
//  CHPNewsItem.h
//  CHP-Mobil
//
//  Created by Eren Halici on 15.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHPNewsItem : NSObject

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSURL *imageAddress;

+(id) newsItemFromDictionary:(NSDictionary *)aDictionary;

-(id) initFromDictionary:(NSDictionary *)aDictionary;

@end
