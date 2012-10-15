//
//  TCPerson.h
//  TCDoorBell
//
//  Created by Joshua Gosse on 2012-10-14.
//  Copyright (c) 2012 Shopify. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;

- (id)initWithDictonary:(NSDictionary *)dictionary;
- (void)updateWithDictionary:(NSDictionary *)dictionary;

@end
