//
//  UISearchVideoItemView.h
//  Fetch
//
//  Created by Victor on 6/30/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@protocol SearchItem_Delegate <NSObject>
-(void)shareClick : (NSString *) url Image : (UIImage*)image;
@end

@interface UISearchVideoItemView : UIView
{
    
}
@property (assign, nonatomic) id<SearchItem_Delegate> delegate;
@property (strong, nonatomic) NSString *url;
//@property (strong, nonatomic) UIImage *uimage;

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet AsyncImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *txtContent;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

- (IBAction)onShare:(id)sender;

@end
