//
//  UISearchItemView.h
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchItem_Delegate <NSObject>
-(void)shareClick : (NSString *) url Image : (UIImage*)image;
@end


@interface UISearchItemView : UIView
{
    
}


@property (assign, nonatomic) id<SearchItem_Delegate> delegate;

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblLink;
@property (weak, nonatomic) IBOutlet UITextView *txtDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;

- (IBAction)onShare:(id)sender;

@end
