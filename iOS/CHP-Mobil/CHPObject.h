//
//  CHPObject.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 01.03.2013.
//  Copyright (c) 2013 Halıcı. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CHPObjectTypeList = 0,
    CHPObjectTypePerson = 1,
    CHPObjectTypeNone = 2
} CHPObjectType;

CHPObjectType TypeFromString(NSString* type);

@interface CHPObject : NSObject

@property CHPObjectType type;

+ (CHPObject*)CHPObjectWithDictionary:(NSDictionary *)dictionary;

@end
