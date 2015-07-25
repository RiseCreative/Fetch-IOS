//
//  SearchThemeViewController.m
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "SearchThemeViewController.h"
#import "AppDelegate.h"
#import "UIThemeItem.h"

@interface SearchThemeViewController ()

@end

@implementation SearchThemeViewController {
    int themeHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setHidden:YES];
    
    themeHeight = 180;
    
    [self initposition];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.imgBackground setBackgroundColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]]];
    
    [self refresh];
}

-(void)refresh {
    NSArray *subView = [self.scrollTheme subviews];
    for (int i = 0; i < subView.count; i++) {
        UIView *view = [subView objectAtIndex:i];
        [view removeFromSuperview];
    }
    
    CGRect screenRect = self.scrollTheme.frame;
    int x = 10;
    int y = 0;
    int width = screenRect.size.width - 10;
    int height = themeHeight;
    NSArray *label = @[@"PURPLE",
                       @"MINT GREEN",
                       @"BLUE",
                       @"ORANGE"];
    
    int curMenuNo = [[DELEGATE strThemeNo] intValue];
    for (int i = 0; i < 4; i++) {
        NSLog(@"%d", y);
        UIThemeItem *item = [[UIThemeItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        NSString *imgName = [NSString stringWithFormat:@"theme%d.png", i+1];
        item.image.image = [UIImage imageNamed:imgName];
        item.tag = i;
        item.lblName.text = [label objectAtIndex:i];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(themeClicked:)];
        
        if (i == curMenuNo) {
            [item.btnUse setTitle:@"THEME IN USE" forState:UIControlStateNormal];
            [item.btnUse setBackgroundColor:[UIColor clearColor]];
            [item.btnUse setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] forState:UIControlStateNormal];
        } else {
            [item.btnUse setTitle:@"USE THIS THEME" forState:UIControlStateNormal];
            [item.btnUse setBackgroundColor:[UIColor whiteColor]];
            [item.btnUse setTitleColor:[UIColor colorWithRed:32/255.0f green:151/255.0f blue:243/255.0f alpha:1.0f] forState:UIControlStateNormal];
        }
        [item addGestureRecognizer:gesture];
        [self.scrollTheme addSubview:item];
        y += themeHeight + 5;
        
    }
    
    [self.scrollTheme setContentSize:CGSizeMake(0,y)];
    
}

-(void)themeClicked : (UITapGestureRecognizer *)gesture {
    int y = self.scrollContent.frame.origin.y;
    
    /*UIView *view = gesture.view;
    CGRect rect = self.viewSelected.frame;
    rect.origin.x = 10;
    rect.origin.y = view.frame.origin.y;
    self.viewSelected.frame = rect;*/
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.type = kCATransitionFade;
    //transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:kCATransition];
    
    NSString *theme = [NSString stringWithFormat:@"%ld", (long)gesture.view.tag];
    [[NSUserDefaults standardUserDefaults] setObject:theme forKey:@"theme"];
    [DELEGATE setStrThemeNo:[NSString stringWithFormat:theme]];
    
    [self.imgBackground setBackgroundColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]]];
    [self refresh];
}
-(void)initposition {
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    CGRect rect = self.scrollContent.frame;
    rect.origin.x = 0;
    rect.size.width = screenRect.size.width;
    rect.size.height = screenRect.size.height - rect.origin.y;
    self.scrollContent.frame = rect;
    self.scrollContent.layer.borderWidth = 2;
    
    rect = self.scrollTheme.frame;
    rect.origin.x = 0;
    rect.size.width = screenRect.size.width;
    rect.size.height = screenRect.size.height - rect.origin.y;
    self.scrollTheme.frame = rect;
    
    rect = self.viewSelected.frame;
    rect.origin.x = 10;
    rect.origin.y = 0;
    rect.size.width = screenRect.size.width - rect.origin.x * 2;
    rect.size.height = themeHeight;
    self.viewSelected.frame = rect;
    
    rect = self.btnSelect.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    rect.origin.y = (themeHeight - rect.size.height) / 2;
    self.btnSelect.frame = rect;
    
    rect = self.imgTitle.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.imgTitle.frame = rect;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onBack:(id)sender {
    [[DELEGATE slidView] showMenu];
}
@end
