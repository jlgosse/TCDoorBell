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
	// get the filepath of the faked people endpoint
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *filePath = [bundle pathForResource:@"people" ofType:@"json"];
	
	// serialize the data as json
	NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
	NSError *error = nil;
	
	NSArray *peopleJSONArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
	NSMutableArray *peopleObjectArray = [NSMutableArray array];

	// loop through each dictionary and create person objects
	for (NSDictionary *peopleDictionary in peopleJSONArray) {
		TCPerson *person = [[TCPerson alloc] initWithDictonary:peopleDictionary];
		[peopleObjectArray addObject:person];
	}

	dispatch_async(dispatch_get_main_queue(), ^{
		if (callback) {
			callback([NSArray arrayWithArray:peopleObjectArray], error);
		}
	});
}

- (void)sendSMSToPerson:(TCPerson *)person withBodyText:(NSString *) callback:(TCServiceCallback)callback
{
	if (callback) {
		callback(nil, nil);
	}
}

@end
