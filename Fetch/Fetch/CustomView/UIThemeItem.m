//
//  UIThemeItem.m
//  Fetch
//
//  Created by Victor on 7/1/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "UIThemeItem.h"

@implementation UIThemeItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSBundle mainBundle] loadNibNamed:@"UIThemeItem" owner:self options:nil];
        [self addSubview:self.view];
        
        CGRect rect = self.view.frame;
        rect.size.width = frame.size.width;
        rect.size.height = frame.size.height;
        self.view.frame = rect;
        
        rect = self.image.frame;
        rect.origin.x = 0;
        rect.origin.y = 0;
        rect.size.width = frame.size.width;
        rect.size.height = frame.size.height;
        self.image.frame = rect;
        
        rect = self.viewBack.frame;
        rect.origin.x = 0;
        rect.size.width = frame.size.width;
        rect.origin.y = frame.size.height - rect.size.height;
        self.viewBack.frame = rect;
        
        self.lblName.frame = rect;
        
        rect = self.btnUse.frame;
        rect.origin.y = frame.size.height - rect.size.height;
        rect.origin.x = frame.size.width - rect.size.width;
        self.btnUse.frame = rect;
        
    }
    return self;
}

@end
