//
//  SearchEngineViewController.m
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "SearchEngineViewController.h"
#import "AppDelegate.h"

@interface SearchEngineViewController ()

@end

@implementation SearchEngineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController.navigationBar setHidden:YES];
    [self initposition];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initposition {
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = self.viewOption.frame;
    rect.size.width = screenRect.size.width;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    rect.origin.y = (screenRect.size.height - rect.size.height) / 3;
    self.viewOption.frame = rect;
    
    rect = self.switchGoogle.frame;
    rect.origin.x = screenRect.size.width - rect.size.width - 30;
    self.switchGoogle.frame = rect;
    
    rect = self.switchYahoo.frame;
    rect.origin.x = screenRect.size.width - rect.size.width - 30;
    self.switchYahoo.frame = rect;
    
    rect = self.switchBing.frame;
    rect.origin.x = screenRect.size.width - rect.size.width - 30;
    self.switchBing.frame = rect;

    rect = self.lblTitle.frame;
    rect.origin.x = (screenRect.size.width -rect.size.width) / 2;
    self.lblTitle.frame = rect;
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
    
    [self.view setBackgroundColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]]];
    NSDictionary *engine = [DELEGATE engineOption];
    
    if ([[engine objectForKey:@"google"] isEqualToString:@"0"]) {
        [self.switchGoogle setOn:NO];
    } else {
        [self.switchGoogle setOn:YES];
    }
    
    if ([[engine objectForKey:@"yahoo"] isEqualToString:@"0"]) {
        [self.switchYahoo setOn:NO];
    } else {
        [self.switchYahoo setOn:YES];
    }
    
    if ([[engine objectForKey:@"bing"] isEqualToString:@"0"]) {
        [self.switchBing setOn:NO];
    } else {
        [self.switchBing setOn:YES];
    }
}
- (IBAction)onBack:(id)sender {
    NSString *google, *yahoo, *bing;
    if ([self.switchBing isOn]) {
        bing = @"1";
    } else {
        bing = @"0";
    }
    
    if ([self.switchGoogle isOn]) {
        google = @"1";
    } else {
        google = @"0";
    }
    
    if ([self.switchYahoo isOn]) {
        yahoo = @"1";
    } else {
        yahoo = @"0";
    }
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:google,@"google", yahoo, @"yahoo", bing, @"bing", nil];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    [[NSUserDefaults standardUserDefaults] setObject:data  forKey:@"engine"];
    
    [DELEGATE setEngineOption:dic];
    
    [[DELEGATE slidView] goMain];
}
@end
