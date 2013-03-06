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

CHPObjectType TypeFromString(NSString* type){
    if ([type isEqualToString:@"list"]) {
        return CHPObjectTypeList;
    } else if ([type isEqualToString:@"person"]) {
        return CHPObjectTypePerson;
    } else {
        return CHPObjectTypeNone;
    }
}

@implementation CHPObject

+ (CHPObject *)CHPObjectWithDictionary:(NSDictionary *)dictionary
{
    CHPObjectType type = TypeFromString([dictionary objectForKey:@"Type"]);
    
    if (type == CHPObjectTypeList) {
        CHPList *list = [CHPList CHPListFromDictionary:dictionary];
        return list;
    } else if (type == CHPObjectTypePerson) {
        CHPPerson *person = [CHPPerson CHPPersonFromDictionary:dictionary];
        return person;
    } else {
        return nil;
    }
}

@end
