//
//  SearchThemeViewController.h
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchThemeViewController : UIViewController

{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollContent;

@property (weak, nonatomic) IBOutlet UIView *viewSelected;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollTheme;
@property (weak, nonatomic) IBOutlet UIImageView *imgTitle;

- (IBAction)onBack:(id)sender;

@end
