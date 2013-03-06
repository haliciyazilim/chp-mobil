//
//  CHPContact.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 16.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ContactInfoLevelNone = 0,
    ContactInfoLevelBasic = 1,
    ContactInfoLevelFull = 2
} InfoLevel;

@interface CHPContact : NSObject

// properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *phones;
@property (strong, nonatomic) NSArray *cellPhones;
@property (strong, nonatomic) NSArray *eMails;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *contactId;
@property (nonatomic) InfoLevel infoLevel;
@property (strong, nonatomic) NSMutableArray *positions;

// class methods
+(id) contactFromDictionary:(NSDictionary *)aDictionary;

+(CHPContact *)getContactWithId:(NSString *)contactId;

+(CHPContact *)addContact:(CHPContact *)contact;

// instance methods
-(id) initFromDictionary:(NSDictionary *)aDictionary;

-(CHPContact *) mergeInfoFromContact:(CHPContact *)otherContact;

-(NSString *) getAllPositionsString;

@end
