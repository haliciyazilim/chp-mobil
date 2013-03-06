//
//  CHPList.h
//  CHP-Mobil
//
//  Created by Alperen Kavun on 01.03.2013.
//  Copyright (c) 2013 Halıcı. All rights reserved.
//

#import "CHPObject.h"

@interface CHPList : CHPObject

@property (nonatomic) NSString* name;
@property (nonatomic) NSMutableArray* content;
@property (nonatomic) NSString* header;

+ (CHPList *)CHPListFromDictionary:(NSDictionary *)listDictionary;

- (id) initFromDictionary:(NSDictionary *)listDictionary;

@end
