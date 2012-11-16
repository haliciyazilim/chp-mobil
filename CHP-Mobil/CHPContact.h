//
//  CHPContact.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 16.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHPContact : NSObject

// properties
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSArray* phones;
@property (strong, nonatomic) NSArray* eMails;

// class methods
+(id) contactFromDictionary:(NSDictionary *)aDictionary;

+(id) chpContactWithName:(NSString *)name
                phones:(NSArray *)phones
                eMails:(NSArray *)eMails;

// instance methods
-(id) initWithName:(NSString *)name
             phones:(NSArray *)phones
             eMails:(NSArray *)eMails;


-(id) initFromDictionary:(NSDictionary *)aDictionary;


@end
