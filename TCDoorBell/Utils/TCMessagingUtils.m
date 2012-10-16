//
//  TCMessagingUtils.m
//  TCDoorBell
//
//  Created by Joshua Gosse on 2012-10-15.
//  Copyright (c) 2012 Shopify. All rights reserved.
//

#import "TCMessagingUtils.h"

@implementation TCMessagingUtils

+ (NSString *)formatPhoneNumber:(NSString *)rawPhone
{
	NSString *numbersOnlyString = [[rawPhone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
	if (numbersOnlyString.length == 10) {
		return [NSString stringWithFormat:@"+1%@", numbersOnlyString];
	}
	else if (numbersOnlyString.length == 0) {
		return nil;
	}
	else {
		return [NSString stringWithFormat:@"+%@", numbersOnlyString];
	}
}

@end
