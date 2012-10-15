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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	TCPeopleViewController *peopleViewController = [[TCPeopleViewController alloc] init];
	
	self.window.rootViewController = peopleViewController;
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
	
    return YES;
}

@end
