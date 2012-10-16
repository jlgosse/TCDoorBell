//
//  TCAppDelegate.m
//  TCDoorBell
//
//  Created by Joshua Gosse on 2012-10-13.
//  Copyright (c) 2012 Shopify. All rights reserved.
//

#import "TCAppDelegate.h"
#import "TCPeopleViewController.h"

@implementation TCAppDelegate

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceTokenData
{
	// build deviceToken string
	const char *data = [deviceTokenData bytes];
	NSMutableString *deviceTokenString = [NSMutableString string];
	
	for (int i = 0; i < [deviceTokenData length]; i++) {
		[deviceTokenString appendFormat:@"%02.2hhX", data[i]];
	}
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// register the application for apple push notification service
	[application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	TCPeopleViewController *peopleViewController = [[TCPeopleViewController alloc] init];
	
	self.window.rootViewController = peopleViewController;
    self.window.backgroundColor = [UIColor darkGrayColor];
    [self.window makeKeyAndVisible];
	
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
	// pipe the remote notification into notification center
	[[NSNotificationCenter defaultCenter] postNotificationName:kTCApplicationDidReceiveUnlockNotification object:nil userInfo:userInfo];
}

@end
