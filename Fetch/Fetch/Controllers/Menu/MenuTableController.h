//
//  MenuTableController.h
//  Leak
//
//  Created by Xin Jin on 16/6/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// MenuTableControllerDelegate Protocol;
@protocol MenuTableControllerDelegate <NSObject>
- (void)didSearchEngine;
- (void)didKeepHistory;
- (void)didClearHistory;
- (void)didChangeSkin;
- (void)didAbout;
@end

// MenuTableController Class;
@interface MenuTableController : UITableViewController

// Properties;
@property (nonatomic, assign) id<MenuTableControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UISwitch *slideCheck;

- (IBAction)switchChanged:(id)sender;

@end
