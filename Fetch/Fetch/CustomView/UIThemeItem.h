//
//  UIThemeItem.h
//  Fetch
//
//  Created by Victor on 7/1/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIThemeItem : UIView
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIView *viewBack;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnUse;
@property (strong, nonatomic) IBOutlet UIView *view;

@end
