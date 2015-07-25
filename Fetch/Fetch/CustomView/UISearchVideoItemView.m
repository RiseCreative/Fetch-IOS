//
//  UISearchVideoItemView.m
//  Fetch
//
//  Created by Victor on 6/30/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "UISearchVideoItemView.h"

@implementation UISearchVideoItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:@"UISearchVideoItemView" owner:self options:nil];
        [self addSubview:self.view];
        int offset = frame.size.width - 320;
        CGRect rect = self.lblTitle.frame;
        rect.size.width += offset;
        self.lblTitle.frame = rect;
        
        rect = self.txtContent.frame;
        rect.size.width += offset;
        self.txtContent.frame = rect;
        
        rect = self.btnShare.frame;
        rect.origin.x += offset;
        self.btnShare.frame = rect;
        
        self.image.layer.masksToBounds = YES;
        
        [self.btnShare setBackgroundColor:[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.0f]];
        self.btnShare.layer.cornerRadius = 5;
        self.btnShare.layer.masksToBounds = YES;
        
        rect = self.view.frame;
        rect.size.width = frame.size.width;
        self.view.frame = rect;
        
        self.view.layer.borderWidth = 1;
        self.view.layer.borderColor = [UIColor colorWithRed:216/255.0f green:216/255.0f blue:216/255.0f alpha:1.0f].CGColor;
        

    }
    return self;
}
- (IBAction)onShare:(id)sender {
    [self.delegate shareClick:self.url Image:self.image.image];
}
@end
