//
//  SearchViewController.h
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareViewController.h"
#import "RSNetworkClient.h"

@interface SearchViewController : UIViewController
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;

@property (strong, nonatomic) ShareViewController *shareView;
@property (strong, nonatomic) RSNetworkClient *googleClient;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIView *viewSearchType;
@property (weak, nonatomic) IBOutlet UIButton *btnWeb;
@property (weak, nonatomic) IBOutlet UIButton *btnImage;
@property (weak, nonatomic) IBOutlet UIButton *btnVideo;
@property (weak, nonatomic) IBOutlet UIButton *btnNews;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadMore;
@property (weak, nonatomic) IBOutlet UIView *viewLoadMore;
@property (weak, nonatomic) IBOutlet UIButton *btnEngine1;
@property (weak, nonatomic) IBOutlet UIButton *btnEngine2;



@property (weak, nonatomic) IBOutlet UIImageView *imgSel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollContent;

@property (weak, nonatomic) IBOutlet UIImageView *imgTitle;
- (IBAction)onMenu:(id)sender;

- (IBAction)onWeb:(id)sender;
- (IBAction)onImage:(id)sender;
- (IBAction)onVideo:(id)sender;
- (IBAction)onNews:(id)sender;
- (IBAction)onLoadMore:(id)sender;

- (IBAction)onEngine1:(id)sender;
- (IBAction)onEngine2:(id)sender;


@end
