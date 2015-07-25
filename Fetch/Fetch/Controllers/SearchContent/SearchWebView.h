//
//  SearchWebView.h
//  Fetch
//
//  Created by Victor on 6/29/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareViewController.h"

@interface SearchWebView : UIViewController
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *imgTitle;
@property (strong, nonatomic) ShareViewController *shareView;
- (IBAction)onBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *url;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;

@property (weak, nonatomic) IBOutlet UIButton *btnShare;
- (IBAction)onShare:(id)sender;

@end
