//
//  AppDelegate.h
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideViewController.h"

#define DELEGATE (AppDelegate *)[[UIApplication sharedApplication]delegate]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SlideViewController *slidView;
@property (strong, nonatomic) NSString *searchEngine;
@property (strong, nonatomic) UIViewController *currentViewController;
@property (strong, nonatomic) NSDictionary *engineOption;
@property (strong, nonatomic) NSDictionary *dicSearchKey;
@property (strong, nonatomic) NSString *strThemeNo;

@property (strong, nonatomic) NSArray *aryThemeColor;
@property (strong, nonatomic) NSArray *aryBackColor;

@property (strong, nonatomic) NSMutableArray *aryKeywords;
@property (strong, nonatomic) NSString *strKeepHistory;

@end

