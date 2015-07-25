//
//  MenuViewController.m
//  Leak
//
//  Created by Xin Jin on 16/6/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "MenuViewController.h"
#import "MenuTableController.h"

#import "SlideViewController.h"
#import "NavigationController.h"

#import "UIViewController+ECSlidingViewController.h"
#import "AppDelegate.h"
// --- Defines ---;
// MenuViewController Class;
@interface MenuViewController ()

@end

@implementation MenuViewController

// Functions;
#pragma mark - MenuViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)loadView
{
    [super loadView];

    // Avatar;
    _imgForAvator.layer.borderWidth = 1.0f;
    _imgForAvator.layer.borderColor = [UIColor colorWithRed:155.0f / 255.0f green:155.0f / 255.0f blue:155.0f / 255.0f alpha:1.0f].CGColor;
    _imgForAvator.layer.cornerRadius = _imgForAvator.bounds.size.width / 2;
    _imgForAvator.layer.masksToBounds = YES;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Notifications;
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUserLogin) name:@"didUserLogin" object:nil];
    
    // Load;
    //[self performSelector:@selector(didUserLogin)];
    
    /*CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = self.viewMenu.frame;
    rect.origin.x = screenRect.size.width - rect.size.width;
    self.viewMenu.frame = rect;*/
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*NSDictionary *user = [DELEGATE curUser];
    NSString *imgUrl = [user objectForKey:@"tu_photo"];
    imgUrl = [NSString stringWithFormat:@"%@photos/%@", [DELEGATE imgUrl], imgUrl];
    if (![[user objectForKey:@"tu_facebookID"] isEqualToString:@""]) {
        imgUrl = [user objectForKey:@"tu_photo"];
    }
    [self.imgForAvator loadImageFromURL:[NSURL URLWithString:imgUrl]];
    [self.lblForUsername setText:[user objectForKey:@"tu_username"]];
    
    self.view.layer.masksToBounds = YES;*/
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    // Notifications;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MenuTableController"]) {
        MenuTableController *viewController = segue.destinationViewController;
        viewController.delegate = (SlideViewController *)self.slidingViewController;
    }
}


@end
