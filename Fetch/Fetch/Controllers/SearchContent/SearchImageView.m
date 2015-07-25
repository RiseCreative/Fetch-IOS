//

//  SearchImageView.m

//  Fetch

//

//  Created by Victor on 6/29/15.

//  Copyright (c) 2015 Victor. All rights reserved.

//


#import "AppDelegate.h"
#import "SearchImageView.h"

@interface SearchImageView ()

@end

@implementation SearchImageView
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initposition];
    
}

-(void)initposition {
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    screenRect.origin.y = 0;
    screenRect.size.height += 20;
    self.view.frame = screenRect;
    
    CGRect rect = self.imgTitle.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.imgTitle.frame = rect;
    
    rect = self.imageContent.frame;
    rect.origin.x = 0;
    rect.size.width = screenRect.size.width;
    rect.size.height = (screenRect.size.height -rect.origin.y);
    self.imageContent.frame = rect;
    
    rect = self.btnShare.frame;
    rect.origin.x = screenRect.size.width - rect.size.width - 10;
    self.btnShare.frame = rect;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.imgBackground setBackgroundColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]]];
    
    NSLog(@"%@", self.imgUrl);
    [self.imageContent loadImageFromURL:[NSURL URLWithString:self.imgUrl]];
}

- (IBAction)onShare:(id)sender {
    self.shareView = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
    [self.view addSubview:self.shareView.view];
    //CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    self.shareView.image = self.imageContent.image;
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.shareView.viewMain.layer addAnimation:transition forKey:kCATransition];
}

- (IBAction)onBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];    
}

@end

