//
//  SearchWebView.m
//  Fetch
//
//  Created by Victor on 6/29/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "SearchWebView.h"
#import "AppDelegate.h"

@interface SearchWebView () <UIWebViewDelegate>

@end

@implementation SearchWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView.delegate = self;
    [self initposition];
}

-(void)initposition {
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    CGRect rect = self.webView.frame;
    rect.size.width = screenRect.size.width;
    rect.size.height = screenRect.size.height - rect.origin.y;
    self.webView.frame = rect;
    
    rect = self.spinner.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    rect.origin.y = (screenRect.size.height - rect.size.height) / 2;
    self.spinner.frame = rect;
    
    rect = self.imgTitle.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.imgTitle.frame = rect;
    
    rect = self.btnShare.frame;
    rect.origin.x = screenRect.size.width - rect.size.width - 10;
    self.btnShare.frame = rect;
    
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.imgBackground setBackgroundColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]]];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.spinner startAnimating];
    [self.spinner setHidden:NO];
}
- (IBAction)onBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    //[self.spinner setHidden:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner setHidden:YES];
}
- (IBAction)onShare:(id)sender {
    self.shareView = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
    [self.view addSubview:self.shareView.view];
    //CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.shareView.url = self.url;
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.shareView.viewMain.layer addAnimation:transition forKey:kCATransition];
}
@end
