//
//  AsyncImageView.h
//  YellowJacket
//
//  Created by Wayne Cochran on 7/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


//
//

#import <UIKit/UIKit.h>

@protocol ImageView_Delegate <NSObject>
-(void)imageLoaded : (UIImage *)image url : (NSString*)url;
@end

@interface AsyncImageView : UIImageView {
    NSURLConnection *connection;
    NSMutableData *data;
    NSString *urlString; // key for image cache dictionary
}

@property (assign, nonatomic) id<ImageView_Delegate> delegate;

-(void)loadImageFromURL:(NSURL*)url;
-(void)drawImage:(UIImage*)image;

@end
