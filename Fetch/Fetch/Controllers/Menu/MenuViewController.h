//
//  MenuViewController.h
//  Leak
//
//  Created by Xin Jin on 16/6/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import <UIKit/UIKit.h>

// --- Defines ---;
// MenuViewController Class;
#import "AsyncImageView.h"

@interface MenuViewController : UIViewController
{
    
}

@property (weak, nonatomic) IBOutlet UIView *viewMenu;

@property (weak, nonatomic) IBOutlet AsyncImageView *imgForAvator;
@property (weak, nonatomic) IBOutlet UILabel *lblForUsername;

@end
