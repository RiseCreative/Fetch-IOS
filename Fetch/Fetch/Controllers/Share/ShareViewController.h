//
//  ShareViewController.h
//  Fetch
//
//  Created by Victor on 6/25/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareView_Delegate <NSObject>
-(void)back;
@end

@interface ShareViewController : UIViewController
{
    
}

@property (nonatomic, retain) UIDocumentInteractionController *dic;

@property (weak, nonatomic) IBOutlet UIView *viewMain;

@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) UIImage *image;
- (IBAction)onFacebook:(id)sender;
- (IBAction)onTwitter:(id)sender;
- (IBAction)onInstagram:(id)sender;
- (IBAction)onTumble:(id)sender;
- (IBAction)onSnapchat:(id)sender;
- (IBAction)onPinterest:(id)sender;


@end
