//
//  TCPerson.m
//  TCDoorBell
//
//  Created by Joshua Gosse on 2012-10-14.
//  Copyright (c) 2012 Shopify. All rights reserved.
//

#import "TCPerson.h"

@implementation TCPerson

#pragma mark - Initialization

- (id)initWithDictonary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self) {
		[self updateWithDictionary:dictionary];
	}
	return self;
}

#pragma mark - Update

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	_name = [dictionary objectForKey:kTCKeyName];
	_phoneNumber = [dictionary objectForKey:kTCKeyPhoneNumber];
	_photoURL = [dictionary objectForKey:kTCKeyPhotoURL];
}

@end
