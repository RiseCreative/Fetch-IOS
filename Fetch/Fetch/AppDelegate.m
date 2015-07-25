//
//  AppDelegate.m
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>
#import "SearchViewController.h"

@implementation UIApplication (Private)


@end

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"engine"];
    NSString *theme = [[NSUserDefaults standardUserDefaults] stringForKey:@"theme"];
    if (data != nil) {
        NSDictionary *dic =[NSKeyedUnarchiver unarchiveObjectWithData:data];
        [DELEGATE setEngineOption:dic];
    } else {
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"1", @"google", @"1", @"yahoo", @"1", @"bing", nil];
        [DELEGATE setEngineOption:dic];
    }
    
    if (theme != nil) {
        self.strThemeNo = theme;
    } else {
        self.strThemeNo = @"2";
    }
    
    self.aryKeywords = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"keyword"]];
    self.strKeepHistory = [[NSUserDefaults standardUserDefaults] stringForKey:@"chkhistory"];
    if (self.strKeepHistory == nil) {
        self.strKeepHistory = @"true";
    }
    UIColor *blueTheme = [UIColor colorWithRed:33/255.0f green:150/255.0f blue:243/255.0f alpha:1.0f];
    UIColor *mintTheme = [UIColor colorWithRed:140/255.0f green:195/255.0f blue:75/255.0f alpha:1.0f];
    UIColor *purpleTheme = [UIColor colorWithRed:156/255.0f green:40/255.0f blue:177/255.0f alpha:1.0f];
    UIColor *orangeTheme = [UIColor colorWithRed:255/255.0f green:152/255.0f blue:1/255.0f alpha:1.0f];
    
    self.aryThemeColor = [NSArray arrayWithObjects:purpleTheme, mintTheme, blueTheme,orangeTheme, nil];
    
    blueTheme = [UIColor colorWithRed:33/255.0f green:150/255.0f blue:243/255.0f alpha:0.3f];
    mintTheme = [UIColor colorWithRed:140/255.0f green:195/255.0f blue:75/255.0f alpha:0.3f];
    purpleTheme = [UIColor colorWithRed:156/255.0f green:40/255.0f blue:177/255.0f alpha:0.3f];
    orangeTheme = [UIColor colorWithRed:255/255.0f green:152/255.0f blue:1/255.0f alpha:0.3f];
    self.aryBackColor = [NSArray arrayWithObjects:purpleTheme, mintTheme, blueTheme,orangeTheme, nil];
    
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
