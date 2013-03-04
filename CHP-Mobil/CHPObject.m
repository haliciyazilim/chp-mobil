//
//  CHPObject.m
//  CHP-Mobil
//
//  Created by Alperen Kavun on 01.03.2013.
//  Copyright (c) 2013 Halıcı. All rights reserved.
//

#import "CHPObject.h"
#import "CHPList.h"
#import "CHPPerson.h"

@implementation CHPObject

+ (CHPObject *)CHPObjectWithDictionary:(NSDictionary *)dictionary
{
    CHPObjectType type = TypeFromString([dictionary objectForKey:@"type"]);
    
    if (type == CHPObjectTypeList) {
        return [CHPList CHPListFromDictionary:dictionary];
    } else if (type == CHPObjectTypePerson) {
        return [CHPPerson CHPPersonFromDictionary:dictionary];
    } else {
        return nil;
    }
}

@end
