//
//  VideoPlayViewController.h
//  Stickies Wall
//
//  Created by RB on 6/11/14.
//  Copyright (c) 2014 RB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoPlayViewController : UIViewController {
    NSString *videoPath;
}

@property (strong, nonatomic) MPMoviePlayerController   *movieController;
@property (nonatomic,strong) UIActivityIndicatorView    *movieIndicator;
@property (weak, nonatomic) IBOutlet UIView *playView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil path:(NSString *)vPath;
- (IBAction)backBtnTUI:(id)sender;

@end
