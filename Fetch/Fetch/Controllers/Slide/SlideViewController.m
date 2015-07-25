//
//  SlideViewController.m
//  Leak
//
//  Created by Xin Jin on 16/6/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "SlideViewController.h"
#import "MenuViewController.h"
#import "NavigationController.h"
#import "AppDelegate.h"

// --- Defines ---;
// SlideViewController Class;
@interface SlideViewController () <UIAlertViewDelegate>

// Properties;
@property (nonatomic, strong) MenuViewController *menuController;
@property (nonatomic, strong) NavigationController *searchEgineController;
@property (nonatomic, strong) NavigationController *mainController;
@property (nonatomic, strong) NavigationController *searchViewController;
@property (nonatomic, strong) NavigationController *aboutController;
@property (nonatomic, strong) NavigationController *themeController;
//@property (nonatomic, strong) NavigationController *logoutController;
#define ALERT_CLEAR_HISTORY 1;

@end

@implementation SlideViewController

// Functions;
#pragma mark - AppDelegate
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)showError:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:@""
                                message:message
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"Ok", nil] show];
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    // Controllers;
    self.menuController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    self.mainController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainview"];
    self.searchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"searchview"];
    self.searchEgineController = [self.storyboard instantiateViewControllerWithIdentifier:@"engineview"];
    self.aboutController = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutview"];
    self.themeController = [self.storyboard instantiateViewControllerWithIdentifier:@"themeview"];

    // Menu Controller;
    self.underLeftViewController = self.menuController;
    //self.underRightViewController = self.menuController;
    // Top Controller;
    self.topViewController = self.mainController;
    
    // Set;
    self.anchorRightRevealAmount = 270;
    
    //self.anchorLeftRevealAmount = 270;
    self.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    
    [DELEGATE setSlidView:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - MenuTableControllerDelegate
- (void)didSelectController:(UIViewController *)viewController
{
    // Top Controller;
    self.topViewController = viewController;
    
    // Reset;
    [self resetTopViewAnimated:YES];
}

-(void)didSearchEngine
{
    [self performSelector:@selector(didSelectController:) withObject:self.searchEgineController];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type = kCATransitionFade;
    //transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [self.searchEgineController.view.window.layer addAnimation:transition forKey:kCATransition];
    
    
}

-(void)didKeepHistory
{

}

-(void)didClearHistory
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you really wish to clear histroy?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alert.tag = ALERT_CLEAR_HISTORY;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    int tag =alertView.tag;
    if (tag == 1) { // alert clear history;
        NSMutableArray *aryKeywords = [[NSMutableArray alloc] init];
        [DELEGATE setAryKeywords:aryKeywords];
        [[NSUserDefaults standardUserDefaults] setObject:aryKeywords forKey:@"keyword"];
    }
}
-(void)didChangeSkin
{
    //[self showError:@"Comming SOON"];
    [self performSelector:@selector(didSelectController:) withObject:self.themeController];
}

-(void)didAbout
{
    [self performSelector:@selector(didSelectController:) withObject:self.aboutController];
}

-(void)goSearchView {
    [self performSelector:@selector(didSelectController:) withObject:self.searchViewController];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionPush;
    //transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [self.searchViewController.view.window.layer addAnimation:transition forKey:kCATransition];
    
}

-(void)goMain {
    [self performSelector:@selector(didSelectController:) withObject:self.mainController];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionFade;
    //transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [self.mainController.view.window.layer addAnimation:transition forKey:kCATransition];
}
-(void)showMenu {
    [self performSelector:@selector(didSelectController:) withObject:self.searchViewController];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionFade;
    //transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [self.searchViewController.view.window.layer addAnimation:transition forKey:kCATransition];
    
    //[self anchorTopViewToRightAnimated:YES];
}
@end
