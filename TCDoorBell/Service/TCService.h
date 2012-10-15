//
//  TCService.h
//  TCDoorBell
//
//  Created by Joshua Gosse on 2012-10-15.
//  Copyright (c) 2012 Shopify. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCPerson.h"

typedef void (^TCServiceCallback) (id content, NSError *error);

@interface TCService : NSObject

+ (TCService *)sharedInstance;

- (void)listAllPeopleWithCallback:(TCServiceCallback)callback;
- (void)sendSMSToPerson:(TCPerson *)person withBodyText:(NSString *) callback:(TCServiceCallback)callback;

@end
