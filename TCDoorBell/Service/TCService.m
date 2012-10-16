//
//  TCService.m
//  TCDoorBell
//
//  Created by Joshua Gosse on 2012-10-15.
//  Copyright (c) 2012 Shopify. All rights reserved.
//

#import "TCService.h"
#import "TCMessagingUtils.h"

#import "NSData+Base64.h"

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

#pragma mark - Twilio API

- (NSString *)encodedStringWithKey:(NSString *)key secret:(NSString *)secret
{
	NSData *encodable = [[NSString stringWithFormat:@"%@:%@", key, secret] dataUsingEncoding:NSUTF8StringEncoding];
	return [encodable base64EncodedString];
}

- (NSData*)synchronousDataFromURL:(NSString*)url method:(NSString *)method body:(NSString *)body error:(NSError**)error statusCode:(unsigned int*)statusCode
{
	NSString *encoded = [self encodedStringWithKey:kTCTwilioAccountSID secret:kTCTwilioAuthToken];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:method];
	[request setValue:[NSString stringWithFormat:@"Basic %@", encoded] forHTTPHeaderField:@"Authorization"];
	
	if (body && body.length > 0) {
		[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	}
	
	NSHTTPURLResponse *response = nil;
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:error];
	*statusCode = [response statusCode];
	return data;
}

- (NSData*)synchronousDataFromURL:(NSString*)url error:(NSError**)error statusCode:(unsigned int*)statusCode
{
	return [self synchronousDataFromURL:url method:@"GET" body:nil error:error statusCode:statusCode];
}

- (void)sendTextMessageToPerson:(TCPerson *)person withBody:(NSString *)body callback:(TCServiceCallback)callback;
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
		NSError *error = nil;
		unsigned int statusCode = 0;
		
		NSString *rawPost = [NSString stringWithFormat:@"From=+%@&To=+%@&Body=%@", kTCTwilioLocalNumber, [TCMessagingUtils formatPhoneNumber:person.phoneNumber], body];
		
		// send the text message
		NSData *dataReturned = [self synchronousDataFromURL:[NSString stringWithFormat:kTCTwilioSMSURL, kTCTwilioAccountSID, kTCTwilioAuthToken, kTCTwilioAccountSID] method:@"POST" body:rawPost error:&error statusCode:&statusCode];
		
		NSLog(@"%@", [[NSString alloc] initWithData:dataReturned encoding:NSUTF8StringEncoding]);
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if (callback) {
				callback(nil, error);
			}
		});
	});
}

@end
