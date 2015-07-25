//
//  ShareViewController.m
//  Fetch
//
//  Created by Victor on 6/25/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "ShareViewController.h"
#import <Social/Social.h>

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initposition];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClicked:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)showError:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:@""
                                message:message
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"Ok", nil] show];
}

-(void)viewClicked : (UITapGestureRecognizer *)gesture {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    [self.view removeFromSuperview];
}

-(void)initposition {
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    screenRect.size.height += 20;
    
    self.view.frame = screenRect;
    
    CGRect rect = self.viewMain.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    rect.origin.y = screenRect.size.height - 109;
    self.viewMain.frame = rect;
    
    rect = self.imgBackground.frame;
    rect.origin.x = 0;
    rect.size.width = screenRect.size.width;
    rect.origin.y = screenRect.size.height - 109;
    self.imgBackground.frame = rect;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onFacebook:(id)sender {
    SLComposeViewController *facebookController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookController setInitialText:@""];
    if (self.image != nil) {
        [facebookController addImage:self.image];
    } else {
        [facebookController addImage:[UIImage imageNamed:@"icon60.png"]];
    }
    //[facebookController addImage:[UIImage imageNamed:@"icon60.png"]];
    [facebookController addURL:[NSURL URLWithString:self.url]];
    
    [self presentViewController:facebookController animated:YES completion:nil];
}

- (IBAction)onTwitter:(id)sender {
    SLComposeViewController *facebookController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [facebookController setInitialText:@""];
    if (self.image != nil) {
        [facebookController addImage:self.image];
    } else {
        [facebookController addImage:[UIImage imageNamed:@"icon60.png"]];
    }
    [facebookController addURL:[NSURL URLWithString:self.url]];
    
    [self presentViewController:facebookController animated:YES completion:nil];
}

- (IBAction)onInstagram:(id)sender {
    if (self.image == nil) {
        [self showError:@"Please select image to share to Instagram!"];
        return;
    }
    
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/originalImage.ig"];
    [UIImagePNGRepresentation(self.image) writeToFile:savePath atomically:YES];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
    
    {
        _dic = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
        _dic.UTI = @"com.instagram.exclusivegram";
        _dic.delegate = self;
        _dic.annotation = [NSDictionary dictionaryWithObject:@"Your Caption here" forKey:@"From PhotoStampton"];
        [_dic presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    }
}

- (IBAction)onTumble:(id)sender {
    [self showError:@"Comming SOON"];
}

- (IBAction)onSnapchat:(id)sender {
    [self showError:@"Comming SOON"];
}

- (IBAction)onPinterest:(id)sender {
    [self showError:@"Comming SOON"];
}
@end
