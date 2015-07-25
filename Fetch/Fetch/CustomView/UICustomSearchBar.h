//
//  UICustomSearchBar.h
//  Fetch
//
//  Created by Victor on 6/30/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKAutoCompleteTextField.h"
#import "MVPlaceSearchTextField.h"

@protocol SearchBar_Delegate <NSObject>
-(void)searchClick;
@end

@interface UICustomSearchBar : UIView <UITextFieldDelegate, TKAutoCompleteTextFieldDataSource, TKAutoCompleteTextFieldDelegate>
{
    
}

@property (assign, nonatomic) id<SearchBar_Delegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *viewBorder;

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet TKAutoCompleteTextField *txtKeyword;
@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *txtLocation;
@property (weak, nonatomic) IBOutlet UITextField *txtDomain;
@property (weak, nonatomic) IBOutlet TKAutoCompleteTextField *txtTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;

@end

