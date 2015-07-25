//
//  SearchEngineViewController.h
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchEngineViewController : UIViewController{
    
}

@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)onBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewOption;

@property (weak, nonatomic) IBOutlet UISwitch *switchGoogle;
@property (weak, nonatomic) IBOutlet UISwitch *switchYahoo;
@property (weak, nonatomic) IBOutlet UISwitch *switchBing;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
