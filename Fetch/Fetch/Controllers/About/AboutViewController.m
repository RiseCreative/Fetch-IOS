//
//  AboutViewController.m
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "AboutViewController.h"
#import "AppDelegate.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setHidden:YES];
    
    [self initposition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initposition {
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect rect = self.txtAbout.frame;
    rect.origin.x = 10;
    rect.size.width = screenRect.size.width - 20;
    rect.size.height = screenRect.size.height - rect.origin.y - 20;
    self.txtAbout.frame = rect;
    
    /*self.txtAbout.layer.borderColor = [UIColor colorWithRed:216/255.0f green:216/255.0f blue:216/255.0f alpha:1.0f].CGColor;
    
    CGRect borderRect = CGRectMake(3, 3, rect.size.width - 5, rect.size.height- 5);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:borderRect];
    self.txtAbout.layer.masksToBounds = NO;
    self.txtAbout.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtAbout.layer.shadowOffset = CGSizeMake(0.1f, 0.1f);
    self.txtAbout.layer.shadowOpacity = 0.5f;
    self.txtAbout.layer.shadowPath = shadowPath.CGPath;*/
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
}
- (IBAction)onBack:(id)sender {
    [[DELEGATE slidView] showMenu];
}
@end
