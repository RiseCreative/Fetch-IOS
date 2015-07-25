//
//  SearchMainViewController.m
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "SearchMainViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "AppDelegate.h"
#import "UICustomSearchBar.h"

@interface SearchMainViewController () <UITextFieldDelegate>

@end

@implementation SearchMainViewController {
    UICustomSearchBar *searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navigationController.navigationBar setHidden:YES];
    
    [self initposition];
    
    self.txtSearch.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initposition {
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    CGRect rect = self.txtSearch.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.txtSearch.frame = rect;
    
    int width = screenRect.size.width - 80;
    int height = width / 517.0f * 104;
    int y = screenRect.size.height / 3 ;
    if (screenRect.size.height > 500) {
        y += 20;
    }
    NSDictionary *engine = [DELEGATE engineOption];    
    if ([[engine objectForKey:@"google"] isEqualToString:@"0"]) {
        [self.btnGoogle setHidden:YES];
    } else {
        [self.btnGoogle setHidden:NO];
        rect = self.btnGoogle.frame;
        rect.size.width = width;
        rect.size.height = height;
        rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
        rect.origin.y = y;
        self.btnGoogle.frame = rect;
        y += height / 2 *3;
    }
    
    if ([[engine objectForKey:@"yahoo"] isEqualToString:@"0"]) {
        [self.btnYahoo setHidden:YES];
    } else {
        [self.btnYahoo setHidden:NO];
        rect = self.btnYahoo.frame;
        rect.size.width = width;
        rect.size.height = height;
        rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
        rect.origin.y = y;
        self.btnYahoo.frame = rect;
        y += height / 2 *3;

    }
    
    if ([[engine objectForKey:@"bing"] isEqualToString:@"0"]) {
        [self.btnBing setHidden:YES];
    } else {
        [self.btnBing setHidden:NO];
        rect = self.btnBing.frame;
        rect.size.width = width;
        rect.size.height = height;
        rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
        rect.origin.y = y;
        self.btnBing.frame = rect;
        y += height / 2 *3;
    }
    
    rect = self.btnSetting.frame;
    rect.origin.y = y;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.btnSetting.frame = rect;
    
    CGRect rectImgSetting = self.imgSetting.frame;
    rectImgSetting.origin.y = rect.origin.y;
    rectImgSetting.origin.x = rect.origin.x - rectImgSetting.size.width;
    self.imgSetting.frame = rectImgSetting;
    
    rect = self.imgTitle.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.imgTitle.frame = rect;
    
    rect = self.txtSearch.frame;
    rect.size.width = screenRect.size.width - 50;
    rect.origin.x = 25;
    rect.size.height = 250;
    self.txtSearch.frame = rect;
    self.txtSearch.layer.borderWidth = 2;
    self.txtSearch.layer.cornerRadius = 20;
    self.txtSearch.layer.borderColor = [UIColor colorWithRed:31/255.0f green:151/255.0f blue:248/255.0f alpha:1.0f].CGColor;
    
    if (searchBar == nil) {
        searchBar = [[UICustomSearchBar alloc] initWithFrame:rect];
        [self.view addSubview:searchBar];
        
        [self.view bringSubviewToFront:self.btnGoogle];
        [self.view bringSubviewToFront:self.btnBing];
        [self.view bringSubviewToFront:self.btnYahoo];
    }
    
    searchBar.view.backgroundColor = [UIColor clearColor];
    searchBar.view.layer.borderColor = [UIColor clearColor].CGColor;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.imgBackground setBackgroundColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]]];
    UIColor *color = [[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]];
    
    searchBar.viewBorder.layer.borderColor = color.CGColor;
    searchBar.view.layer.borderColor = color.CGColor;
    NSArray *ary = [DELEGATE aryKeywords];
    searchBar.txtKeyword.suggestions = [DELEGATE aryKeywords];
    [self initposition];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onMenu:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

-(void)setKeyWord {
    NSString *keyword = searchBar.txtKeyword.text;
    NSString *location = searchBar.txtLocation.text;
    NSString *domain = searchBar.txtDomain.text;
    NSString *time = searchBar.txtTime.text;
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:keyword, @"keyword", location, @"location", domain, @"domain", time, @"time", nil];
    [DELEGATE setDicSearchKey:dic];
}
- (IBAction)onGoogle:(id)sender {
    [self setKeyWord];
    [DELEGATE setSearchEngine:@"google"];
    [[DELEGATE slidView] goSearchView];
}

- (IBAction)onYahoo:(id)sender {
    [self setKeyWord];
    [DELEGATE setSearchEngine:@"yahoo"];
    [[DELEGATE slidView] goSearchView];
}

- (IBAction)onBing:(id)sender {
    [self setKeyWord];
    [DELEGATE setSearchEngine:@"bing"];
    [[DELEGATE slidView] goSearchView];
}

- (IBAction)onSetting:(id)sender {
    [[DELEGATE slidView] didSearchEngine];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.txtSearch resignFirstResponder];
    return YES;
}
@end
