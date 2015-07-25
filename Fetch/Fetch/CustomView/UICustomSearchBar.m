//
//  UICustomSearchBar.m
//  Fetch
//
//  Created by Victor on 6/30/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "UICustomSearchBar.h"
#import "AppDelegate.h"

@implementation UICustomSearchBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:@"UICustomSearchBar" owner:self options:nil];
        [self addSubview:self.view];
        
        CGRect rect;
        
        rect = self.view.frame;
        rect.size.width = frame.size.width;
        rect.size.height = frame.size.height;
        self.view.frame = rect;
        
        rect.size.height = 50;
        self.viewBorder.frame = rect;
        
        rect = self.scrollView.frame;
        rect.origin.x = 10;
        rect.size.width = frame.size.width - rect.origin.x - 10;
        //rect.size.height = 50;
        self.scrollView.frame = rect;
        self.scrollView.layer.cornerRadius = 20;
        self.scrollView.layer.masksToBounds = YES;
        //self.scrollView.layer.borderWidth = 1;
        
        UIColor *color = [[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]];
        self.viewBorder.layer.borderWidth = 2;
        self.viewBorder.layer.cornerRadius = 20;
        self.viewBorder.layer.borderColor = color.CGColor;
        self.viewBorder.layer.masksToBounds = YES;
        
        self.view.layer.borderWidth = 2;
        self.view.layer.cornerRadius = 20;
        self.view.layer.borderColor = color.CGColor;
        self.view.layer.masksToBounds = YES;
        
        //[self.viewSearchType.layer setBorderColor:color.CGColor];
        //self.viewBorder.layer.masksToBounds = YES;
        
        NSArray *ary = [[NSArray alloc] initWithObjects:self.txtKeyword, self.txtLocation, self.txtDomain, self.txtTime, nil];
        
        int x = 2;
        int width = 80;
        for (int i = 0; i < ary.count; i++) {
            UITextField *view = [ary objectAtIndex:i];
            if (i == 3) {
                width = 120;
            }
            view.frame = CGRectMake(x, 3, width, 44);
            view.delegate = self;
            UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            [view setLeftViewMode:UITextFieldViewModeAlways];
            [view setLeftView:spacerView];
            x += width + 2;
            view.layer.cornerRadius = 5;
            view.layer.masksToBounds = YES;
        }
        
        [self.scrollView setContentSize:CGSizeMake( x + 30, 0)];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        
        self.txtTime.enableStrictFirstMatch = YES; // default is NO
        self.txtTime.autoCompleteDataSource = self;
        self.txtTime.autoCompleteDelegate = self;
        // you can select whether or not suggestion in empty input.
        self.txtTime.enablePreInputSearch = YES; // default is NO
        NSArray *aryTimes = @[@"anytime",
                              @"past 24 hours",
                              @"past week",
                              @"past month",
                              @"past year"];
        self.txtTime.suggestions = aryTimes;
        
        self.txtKeyword.enableStrictFirstMatch = YES; // default is NO
        self.txtKeyword.autoCompleteDataSource = self;
        self.txtKeyword.autoCompleteDelegate = self;
        // you can select whether or not suggestion in empty input.
        self.txtKeyword.enablePreInputSearch = YES; // default is NO
        /*NSArray *aryTimes = @[@"anytime",
                              @"past 24 hours",
                              @"past week",
                              @"past month",
                              @"past year"];
        self.txtTime.suggestions = aryTimes;*/
        
        _txtLocation.placeSearchDelegate                 = self;
        _txtLocation.strApiKey                           = @"AIzaSyCDi2dklT-95tEHqYoE7Tklwzn3eJP-MtM";
        _txtLocation.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
        _txtLocation.autoCompleteShouldHideOnSelection   = YES;
        _txtLocation.maximumNumberOfAutoCompleteRows     = 10;
        _txtLocation.delegate = self;
        
        _txtLocation.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
        _txtLocation.autoCompleteBoldFontName = @"HelveticaNeue";
        _txtLocation.autoCompleteTableCornerRadius=0.0;
        _txtLocation.autoCompleteRowHeight=35;
        _txtLocation.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
        _txtLocation.autoCompleteFontSize=14;
        _txtLocation.autoCompleteTableBorderWidth=1.0;
        _txtLocation.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
        _txtLocation.autoCompleteShouldHideOnSelection=YES;
        _txtLocation.autoCompleteShouldHideClosingKeyboard=YES;
        _txtLocation.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
        _txtLocation.autoCompleteTableFrame = CGRectMake(_txtLocation.frame.origin.x - 10, _txtLocation.frame.origin.y+40.0, 200, 200.0);
    }
    
    return self;
}

#pragma mark - Place search Textfield Delegates
-(void)placeSearchResponseForSelectedPlace:(NSMutableDictionary*)responseDict{
    [self.view endEditing:YES];
    NSLog(@"%@",responseDict);
    
    NSDictionary *aDictLocation=[[[responseDict objectForKey:@"result"] objectForKey:@"geometry"] objectForKey:@"location"];
    NSLog(@"SELECTED ADDRESS :%@",self.txtLocation.text);

    int x = 2;
    NSArray *ary = [[NSArray alloc] initWithObjects:self.txtKeyword, self.txtLocation, self.txtDomain, self.txtTime, nil];
    for (int i = 0; i < ary.count; i++) {
        UITextField *view = [ary objectAtIndex:i];
        CGRect frame = view.frame;
        frame.origin.x = x;
        if (self.txtLocation == view) {
            CGFloat txtWidth =  [view.text sizeWithFont:view.font].width;
            if (txtWidth > 30) {
                frame.size.width = txtWidth + 40;
            } else {
                frame.size.width = 80;
            }        }        view.frame = frame;
        
        x += frame.size.width + 2;
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
        NSLog(@"%@", view.text);
    }
    [self.scrollView setContentSize:CGSizeMake(x + 30, 0)];
    UIView *superview = [self superview];
    [superview sendSubviewToBack:self];
    
    CGRect rect = self.viewBorder.frame;
    rect.size.height = 50;
    //self.viewBorder.frame = rect;
    
    rect = self.view.frame;
    rect.size.height = 50;
    self.view.frame = rect;

    [self.viewBorder layoutIfNeeded];
    [self.view layoutIfNeeded];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"begin editing");
    UIColor *backColor = [[DELEGATE aryBackColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]];
    [self.imgBackground setBackgroundColor:backColor];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIColor *color = [[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]];
    self.view.layer.borderColor = color.CGColor;
    
    if (textField == self.txtLocation || textField == self.txtTime || textField == self.txtKeyword) {
        UIView *superview = [self superview];
        [superview bringSubviewToFront:self];
        
        CGRect rect = self.viewBorder.frame;
        rect.size.height = self.view.frame.size.height;
        //self.viewBorder.frame = rect;
        
        rect = self.view.frame;
        rect.size.height = 250;
        self.view.frame = rect;
    } else {
        UIView *superview = [self superview];
        [superview sendSubviewToBack:self];
        
        CGRect rect = self.viewBorder.frame;
        rect.size.height = 50;
        //self.viewBorder.frame = rect;
        
        rect = self.view.frame;
        rect.size.height = 50;
        self.view.frame = rect;
    }
    [self.viewBorder layoutIfNeeded];
    [self.view layoutIfNeeded];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    int x = 10;
    NSArray *ary = [[NSArray alloc] initWithObjects:self.txtKeyword, self.txtLocation, self.txtDomain, self.txtTime, nil];
    for (int i = 0; i < ary.count; i++) {
        UITextField *view = [ary objectAtIndex:i];
        CGRect frame = view.frame;
        frame.origin.x = x;
        if (i == 1) {

        } else {
            if (textField == view) {
                
                CGFloat txtWidth =  [view.text sizeWithFont:view.font].width;
                if (txtWidth > 30) {
                    frame.size.width = txtWidth + 55;
                } else {
                    frame.size.width = 80;
                }
            }

        }
        if (i == 3) { // time text
            frame.size.width = 120;
        }
        
        view.frame = frame;
        
        x += frame.size.width + 2;
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
    }
    [self.scrollView setContentSize:CGSizeMake(x + 30, 0)];
    
    if (textField == self.txtLocation || textField == self.txtTime || textField == self.txtKeyword) {
        UIView *superview = [self superview];
        [superview bringSubviewToFront:self];
        
        CGRect rect = self.viewBorder.frame;
        rect.size.height = self.view.frame.size.height;
        //self.viewBorder.frame = rect;
        
        rect = self.view.frame;
        rect.size.height = 250;
        self.view.frame = rect;
    } else {
        UIView *superview = [self superview];
        [superview sendSubviewToBack:self];
        
        CGRect rect = self.viewBorder.frame;
        rect.size.height = 50;
        //self.viewBorder.frame = rect;
        
        rect = self.view.frame;
        rect.size.height = 50;
        self.view.frame = rect;
    }
    [self.viewBorder layoutIfNeeded];
    [self.view layoutIfNeeded];
    
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    int x = 2;
    NSArray *ary = [[NSArray alloc] initWithObjects:self.txtKeyword, self.txtLocation, self.txtDomain, self.txtTime, nil];
    for (int i = 0; i < ary.count; i++) {
        UITextField *view = [ary objectAtIndex:i];
        CGRect frame = view.frame;
        frame.origin.x = x;
        
        if (view == textField) {
            frame.size.width = 80;
        }
        
        if (i == 3) {
            frame.size.width = 120;
        }
        view.frame = frame;
        
        x += frame.size.width + 2;
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
    }
    [self.scrollView setContentSize:CGSizeMake(x + 30, 0)];
    
    if (textField == self.txtLocation || textField == self.txtTime || textField == self.txtKeyword) {
        UIView *superview = [self superview];
        [superview bringSubviewToFront:self];
        
        CGRect rect = self.viewBorder.frame;
        rect.size.height = self.view.frame.size.height;
        //self.viewBorder.frame = rect;
        
        rect = self.view.frame;
        rect.size.height = 250;
        self.view.frame = rect;
    } else {
        UIView *superview = [self superview];
        [superview sendSubviewToBack:self];
        
        CGRect rect = self.viewBorder.frame;
        rect.size.height = 50;
        //self.viewBorder.frame = rect;
        
        rect = self.view.frame;
        rect.size.height = 50;
        self.view.frame = rect;
    }
    [self.viewBorder layoutIfNeeded];
    [self.view layoutIfNeeded];
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.txtKeyword resignFirstResponder];
    [self.txtDomain resignFirstResponder];
    [self.txtLocation resignFirstResponder];
    [self.txtTime resignFirstResponder];
    
    CGRect rect = self.view.frame;
    rect.size.height = 50;
    self.view.frame = rect;
    
    UIView *superview = [self superview];
    [superview sendSubviewToBack:self];
    
    [self.delegate searchClick];
    return YES;
}

- (void)TKAutoCompleteTextField:(TKAutoCompleteTextField *)textField
            didSelectSuggestion:(NSString *)suggestion
{
    NSLog(@">>> didSelectSuggestion: %@", suggestion);
    UIView *superview = [self superview];
    [superview sendSubviewToBack:self];
    
    CGRect rect = self.view.frame;
    rect.size.height = 50;
    self.view.frame = rect;
    
    
}

- (void)TKAutoCompleteTextField:(TKAutoCompleteTextField *)textField
didFillAutoCompleteWithSuggestion:(NSString *)suggestion
{
    NSLog(@">>> didFillAutoCompleteWithSuggestion: %@", suggestion);
    UIView *superview = [self superview];
    [superview sendSubviewToBack:self];
    
    CGRect rect = self.view.frame;
    rect.size.height = 50;
    self.view.frame = rect;
    
    int x = 10;
    NSArray *ary = [[NSArray alloc] initWithObjects:self.txtKeyword, self.txtLocation, self.txtDomain, self.txtTime, nil];
    for (int i = 0; i < ary.count; i++) {
        UITextField *view = [ary objectAtIndex:i];
        CGRect frame = view.frame;
        frame.origin.x = x;
        if (i == 1) {
            
        } else {
            if (textField == view) {
                
                CGFloat txtWidth =  [view.text sizeWithFont:view.font].width;
                if (txtWidth > 30) {
                    frame.size.width = txtWidth + 60;
                } else {
                    frame.size.width = 80;
                }
            }
            
        }
        if (i == 3) { // time text
            frame.size.width = 120;
        }
        
        view.frame = frame;
        
        x += frame.size.width + 2;
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
    }
    [self.scrollView setContentSize:CGSizeMake(x + 30, 0)];
}

#pragma mark = TKAutoCompleteTextFieldDataSource

- (CGFloat)TKAutoCompleteTextField:(TKAutoCompleteTextField *)textField
           heightForSuggestionView:(UITableView *)suggestionView
{
    return 100.f;
}

- (NSInteger)TKAutoCompleteTextField:(TKAutoCompleteTextField *)textField
  numberOfVisibleRowInSuggestionView:(UITableView *)suggestionView
{
    return 10;
}
@end
