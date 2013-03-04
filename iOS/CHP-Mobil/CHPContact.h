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


typedef enum {
    CHPPositionGenelBaskan = 1<<0,
    CHPPositionMYKUyesi = 1<<1,
    CHPPositionPMUyesi = 1<<2,
    CHPPositionYDKUyesi = 1<<3,
    CHPPositionMilletvekili = 1<<4,
    CHPPositionIlBaskani = 1<<5,
    CHPPositionIlceBaskani = 1<<6,
    CHPPositionBuyuksehirBelediyeBaskani = 1<<7,
    CHPPositionIlBelediyeBaskani = 1<<8,
    CHPPositionIlceBelediyeBaskani = 1<<9,
} CHPPosition;

@interface CHPContact : NSObject

// properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *phones;
@property (strong, nonatomic) NSArray *cellPhones;
@property (strong, nonatomic) NSArray *eMails;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *contactId;
@property (nonatomic) InfoLevel infoLevel;
@property (nonatomic) int position;
@property (strong, nonatomic) NSMutableDictionary *positionStrings;

// class methods
+(id) contactFromDictionary:(NSDictionary *)aDictionary;

+(CHPContact *)getContactWithId:(NSString *)contactId;

+(CHPContact *)addContact:(CHPContact *)contact;

// instance methods
-(id) initFromDictionary:(NSDictionary *)aDictionary;

-(CHPContact *) mergeInfoFromContact:(CHPContact *)otherContact;

-(CHPContact *) addPosition:(CHPPosition)newPosition;

-(NSArray *)getPositionStringsArray;

@end