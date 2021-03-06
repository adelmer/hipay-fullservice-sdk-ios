//
//  HPFAppDelegate.m
//  HiPayFullservice
//
//  Created by Jonathan TIRET on 09/18/2015.
//  Copyright (c) 2015 Jonathan TIRET. All rights reserved.
//

#import "HPFAppDelegate.h"
#import <HiPayFullservice/HiPayFullservice.h>
#import <HockeySDK/HockeySDK.h>

@implementation HPFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *parameters = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"parameters" ofType:@"plist"]];
    
    [[HPFClientConfig sharedClientConfig] setEnvironment:HPFEnvironmentStage
                                                username:parameters[@"hipay"][@"username"]
                                                password:parameters[@"hipay"][@"password"]
                                            appURLscheme:@"hipayexample"];

    [[HPFClientConfig sharedClientConfig] setPaymentCardStorageEnabled:YES withTouchID:YES];
    [[HPFClientConfig sharedClientConfig] setPaymentCardScanEnabled:YES];
    //[[HPFClientConfig sharedClientConfig] setApplePayEnabled:YES privateKeyPassword:@"test"];

    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:parameters[@"hockeyapp"][@"app_identifier"]];
    [[BITHockeyManager sharedHockeyManager] startManager];
    [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];
        
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [[HPFGatewayClient sharedClient] handleOpenURL:url];
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
    [application beginBackgroundTaskWithName:@"mpos_background" expirationHandler:^{
        
    }];
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
