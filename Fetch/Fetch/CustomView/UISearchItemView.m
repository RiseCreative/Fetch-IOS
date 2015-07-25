//
//  UISearchItemView.m
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "UISearchItemView.h"

@implementation UISearchItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:@"UISearchItemView" owner:self options:nil];
        [self addSubview:self.view];
        int offset = frame.size.width - 320;
        CGRect rect = self.btnShare.frame;
        rect.origin.x += offset;
        self.btnShare.frame = rect;
        
        rect = self.lblHeader.frame;
        rect.size.width += offset;
        self.lblHeader.frame = rect;
        
        rect = self.lblLink.frame;
        rect.size.width = frame.size.width - 30;
        self.lblLink.frame = rect;
        
        rect = self.txtDesc.frame;
        rect.size.width += offset;
        self.txtDesc.frame = rect;
        
        self.view.layer.borderWidth = 1;
        self.view.layer.borderColor = [UIColor colorWithRed:216/255.0f green:216/255.0f blue:216/255.0f alpha:1.0f].CGColor;
        
        /*CGRect borderRect = CGRectMake(3, 3, frame.size.width - 5, frame.size.height- 5);
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:borderRect];
        self.view.layer.masksToBounds = NO;
        self.view.layer.shadowColor = [UIColor blackColor].CGColor;
        self.view.layer.shadowOffset = CGSizeMake(0.1f, 0.1f);
        self.view.layer.shadowOpacity = 0.5f;
        self.view.layer.shadowPath = shadowPath.CGPath;*/
        
        rect = self.view.frame;
        rect.size.width = frame.size.width;
        self.view.frame = rect;
        
        [self.btnShare setBackgroundColor:[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.0f]];
        self.btnShare.layer.cornerRadius = 5;
        self.btnShare.layer.masksToBounds = YES;
    }
    return self;
}
- (IBAction)onShare:(id)sender {
    [self.delegate shareClick:self.url Image:self.image];
}
@end
