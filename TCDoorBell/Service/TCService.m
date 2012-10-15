//
//  TCService.m
//  TCDoorBell
//
//  Created by Joshua Gosse on 2012-10-15.
//  Copyright (c) 2012 Shopify. All rights reserved.
//

#import "TCService.h"

@implementation TCService

#pragma mark - Singleton

+ (TCService *)sharedInstance
{
    static dispatch_once_t pred;
    static TCService *instance = nil;
    dispatch_once(&pred, ^{ instance = [[self alloc] init]; });
	return instance;
}

#pragma mark - Service

- (void)listAllPeopleWithCallback:(TCServiceCallback)callback
{
	if (callback) {
		callback(nil, nil);
	}
}

- (void)sendSMSToPerson:(TCPerson *)person withBodyText:(NSString *) callback:(TCServiceCallback)callback
{
	if (callback) {
		callback(nil, nil);
	}
}

@end
