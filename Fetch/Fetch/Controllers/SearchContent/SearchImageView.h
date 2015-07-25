//
//  SearchImageView.h
//  Fetch
//
//  Created by Victor on 6/29/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSNetworkClient.h"
#import "AsyncImageView.h"
#import "ShareViewController.h"

@interface SearchImageView : UIViewController
{
    
}

@property (strong, nonatomic) ShareViewController *shareView;

@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imgTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;

- (IBAction)onShare:(id)sender;

- (IBAction)onBack:(id)sender;
@property (weak, nonatomic) IBOutlet AsyncImageView *imageContent;

@property (strong, nonatomic) NSString* imgUrl;
@end
