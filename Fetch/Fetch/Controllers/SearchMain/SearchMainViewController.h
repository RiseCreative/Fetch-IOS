//
//  SearchMainViewController.h
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchMainViewController : UIViewController {
    
}

@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;

@property (weak, nonatomic) IBOutlet UIImageView *imgTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;

@property (weak, nonatomic) IBOutlet UIButton *btnGoogle;
@property (weak, nonatomic) IBOutlet UIButton *btnYahoo;
@property (weak, nonatomic) IBOutlet UIButton *btnBing;
@property (weak, nonatomic) IBOutlet UIButton *btnSetting;
@property (weak, nonatomic) IBOutlet UIImageView *imgSetting;

- (IBAction)onMenu:(id)sender;
- (IBAction)onGoogle:(id)sender;
- (IBAction)onYahoo:(id)sender;
- (IBAction)onBing:(id)sender;
- (IBAction)onSetting:(id)sender;


@end
