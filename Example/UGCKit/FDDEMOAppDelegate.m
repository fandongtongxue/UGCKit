//
//  FDDEMOAppDelegate.m
//  UGCKit
//
//  Created by fandongtongxue on 04/24/2020.
//  Copyright (c) 2020 fandongtongxue. All rights reserved.
//

#import "FDDEMOAppDelegate.h"
#import "TCMainViewController.h"
#import <TXLiteAVSDK_Professional/TXLiteAVSDK.h>

@implementation FDDEMOAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [TXUGCBase setLicenceURL:@"http://license.vod2.myqcloud.com/license/v1/b9c4190bec109303af70d28f8623236c/TXUgcSDK.licence" key:@"4455812430ce35c17ea78ee79f7071e1"];
    TCMainViewController *vc = [[TCMainViewController alloc]init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
