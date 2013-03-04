//
//  CHPPerson.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 01.03.2013.
//  Copyright (c) 2013 Halıcı. All rights reserved.
//

#import "CHPObject.h"
@class CHPContact;

@interface CHPPerson : CHPObject

@property CHPContact* contact;

+ (CHPPerson *)CHPPersonFromDictionary:(NSDictionary *)personDictionary;

- (id) initFromDictionary:(NSDictionary *)personDictionary;

@end
