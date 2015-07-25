//
//  VideoPlayViewController.m
//  Stickies Wall
//
//  Created by RB on 6/11/14.
//  Copyright (c) 2014 RB. All rights reserved.
//

#import "VideoPlayViewController.h"

@interface VideoPlayViewController ()

@end

@implementation VideoPlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil path:(NSString *)vPath
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        videoPath = vPath;
    }
    return self;
}

- (IBAction)backBtnTUI:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.movieController stop];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    screenRect.origin.y = 0;
    screenRect.size.height += 20;
    CGRect rect = self.view.frame;
    rect.size.width = screenRect.size.width;
    rect.size.height = screenRect.size.height;
    self.view.frame = rect;
    
    rect = self.playView.frame;
    rect.size.width = screenRect.size.width;
    rect.size.height = screenRect.size.height -rect.origin.y;
    self.playView.frame = rect;
    
    rect = self.spinner.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width)  / 2;
    rect.origin.y = (screenRect.size.height -rect.size.height) / 2;
    self.spinner.frame = rect;
    [self.spinner startAnimating];
    // Do any additional setup after loading the view from its nib.
    self.movieController = [[MPMoviePlayerController alloc] init];
    self.movieController.view.frame = self.playView.frame;
    CGRect frame = self.view.frame;
    self.movieController.view.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    self.movieController.view.clipsToBounds = YES;
    self.movieController.controlStyle = MPMovieControlStyleNone;
    [self.movieController setScalingMode:MPMovieScalingModeAspectFill];
    [self.playView addSubview:self.movieController.view];

    if(videoPath && ![videoPath isEqual:[NSNull null]] && ![videoPath isEqual:@""]) {
        NSURL *url;
        if ([videoPath rangeOfString:@"http"].location == NSNotFound) {
            url = [NSURL fileURLWithPath:videoPath];;
        } else {
            url = [NSURL URLWithString:videoPath];
        }
        
        [self.movieController setContentURL:url];
    }
    
    if (self.movieIndicator) {
        [self.movieIndicator stopAnimating];
        [self.movieIndicator removeFromSuperview];
        self.movieIndicator = nil;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.movieController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayLoadDidFinish:)
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:self.movieController];
    
    [self.movieController prepareToPlay];
    
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
   // [self.movieController play];
}

- (void)moviePlayLoadDidFinish:(NSNotification *)notification
{
    [self.spinner stopAnimating];
    [self.spinner setHidden:YES];
	if ([self.movieController loadState] == MPMovieLoadStatePlayable) {
		if (!_movieIndicator) {
			_movieIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];// UIActivityIndicatorViewStyleGray];
			[self.playView addSubview:_movieIndicator];
			[_movieIndicator setCenter:CGPointMake(self.playView.frame.size.width / 2, self.playView.frame.size.height / 2)];
			[_movieIndicator startAnimating];
		}
    } else {
		if (_movieIndicator) {
			[_movieIndicator stopAnimating];
			[_movieIndicator removeFromSuperview];
			_movieIndicator = nil;
		}
		
		[self.movieController play];
		[self.movieController.view setAlpha:1.0];
		self.movieController.controlStyle = MPMovieControlStyleDefault;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
