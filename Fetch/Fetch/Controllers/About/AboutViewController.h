//
//  AboutViewController.h
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController
{
    
}

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UITextView *txtAbout;

- (IBAction)onBack:(id)sender;

@end
