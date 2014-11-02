//
//  AppDelegate.m
//  UniversityBookstore
//
//  Created by Keyur Patel on 10/31/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "AppDelegate.h"
#import "RootNavigationController.h"
#import "Stripe.h"

@interface AppDelegate ()

@end

NSString * const StripePublishableKey = @"pk_test_KnOwEabI3f9rSRj0fdqEP3AI";
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //Stripe Stuff
    [Stripe setDefaultPublishableKey:StripePublishableKey];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *url = [NSURL URLWithString:@"http://10.160.4.209:3000/is_logged_in"];
    NSData *responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *bodydata = [NSString stringWithFormat:@"email=%@&password=%@&session_id=%@", [defaults objectForKey:@"email"], [defaults objectForKey:@"password"], [defaults objectForKey:@"session_id"]];
    
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSHTTPURLResponse *response;
    NSError *error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *str = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if([str isEqualToString:@"Success"])
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        UINavigationController *controller = (UINavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"RootNavigationController"];
        
        RootNavigationController *navController = (RootNavigationController *)controller;
        self.window.rootViewController = navController;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
