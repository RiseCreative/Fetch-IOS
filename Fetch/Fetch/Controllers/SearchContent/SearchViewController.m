//
//  SearchViewController.m
//  Fetch
//
//  Created by Victor on 6/24/15.
//  Copyright (c) 2015 Victor. All rights reserved.
//

#import "SearchViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "AppDelegate.h"
#import "UISearchItemView.h"
#import "ShareViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "SearchWebView.h"
#import "AsyncImageView.h"
#import "SearchImageView.h"
#import "UISearchVideoItemView.h"
#import "VideoPlayViewController.h"
#import "UICustomSearchBar.h"
#import "OAConsumer.h"
#import "OAMutableURLRequest.h"

#define Consumer_key @"dj0yJmk9QWRKN1FLQ0tHTDBoJmQ9WVdrOVVWbEVURUpZTmpRbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD1iYg--"
#define Consumer_secret @"639ab8726b5f0acd4a74bb88ffb22249e7fd6c01"
#define BING_SEARCH_API_KEY @"vb91nSpU96SIV06NL1eKW9yEFo9pIyPyCsKRh0Boy7s"

@interface SearchViewController () <UITextFieldDelegate, SearchItem_Delegate, ImageView_Delegate, SearchBar_Delegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@end

@implementation SearchViewController {
    MBProgressHUD *_hud;
    NSString *googleKey, *googleEngineID;
    NSMutableArray *aryGoogleResult;
    
    int pageNo;
    int pageSize;
    NSString *searchType;
    NSString *searchEngine;
    NSMutableDictionary *imgDic;

    UICustomSearchBar *searchBar;
    NSString *strGetData;
    
    NSTimer *getData;
    NSMutableData *webData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setHidden:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self initposition];
    
    self.txtSearch.delegate = self;
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    [_hud hide:NO];
    [_hud setLabelText:@""];
    
    googleKey = @"AIzaSyCnTIatExksLeSGOHqcKcYhpxtB9ZYRl_o";
    googleEngineID = @"013459838057528381375:smjr4uxmrjq";
    
    imgDic = [[NSMutableDictionary alloc] init];
    
    searchType = @"web";
}

- (void)showError:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:@""
                                message:message
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"Ok", nil] show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initposition {
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    screenRect.size.height += 20;
    CGRect rect = self.viewSearchType.frame;
    rect.origin.x = 0;
    rect.size.width = screenRect.size.width;
    self.viewSearchType.frame = rect;
    
    NSArray *btnArray = @[self.btnWeb, self.btnImage, self.btnVideo, self.btnNews];
    
    int width = screenRect.size.width / 4;
    int height = rect.size.height;
    for (int i = 0; i < btnArray.count; i++) {
        UIButton *btn = [btnArray objectAtIndex:i];
        btn.frame = CGRectMake(width * i, 0, width, height);
    }
    
    rect = self.scrollContent.frame;
    rect.origin.x = 0;
    rect.size.width = screenRect.size.width;
    rect.size.height = (screenRect.size.height - rect.origin.y);
    self.scrollContent.frame = rect;
    
    self.btnLoadMore.layer.cornerRadius = 5;
    self.btnLoadMore.layer.masksToBounds = YES;
    
    rect = self.txtSearch.frame;
    rect.size.width += (screenRect.size.width - 320);
    self.txtSearch.frame = rect;
    
    CGRect rectBtn = self.btnWeb.frame;
    rect = self.imgSel.frame;
    rect.origin.x = rectBtn.origin.x;
    rect.size.width = rectBtn.size.width;
    self.imgSel.frame = rect;
    
    rect = self.imgTitle.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.imgTitle.frame = rect;
    
    rect = self.txtSearch.frame;
    rect.size.width = screenRect.size.width - 50;
    rect.origin.x = 25;
    rect.size.height = 250;
    self.txtSearch.frame = rect;
    self.txtSearch.layer.borderWidth = 2;
    self.txtSearch.layer.cornerRadius = 20;
    self.txtSearch.layer.borderColor = [UIColor colorWithRed:31/255.0f green:151/255.0f blue:248/255.0f alpha:1.0f].CGColor;

    if (searchBar == nil) {
        searchBar = [[UICustomSearchBar alloc] initWithFrame:rect];
        searchBar.delegate = self;
        [self.view addSubview:searchBar];
        [self.view bringSubviewToFront:self.viewSearchType];
        [self.view bringSubviewToFront:self.scrollContent];
        [self.txtSearch setHidden:YES];
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self refresh];
    [self.imgBackground setBackgroundColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]]];
    [self.imgSel setBackgroundColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]]];
    
    [self.btnWeb setTitleColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]] forState:UIControlStateNormal];
    [self.btnImage setTitleColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]] forState:UIControlStateNormal];
    [self.btnVideo setTitleColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]] forState:UIControlStateNormal];
    [self.btnNews setTitleColor:[[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]] forState:UIControlStateNormal];
    
    UIColor *color = [[DELEGATE aryThemeColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]];
    UIColor *backColor = [[DELEGATE aryBackColor] objectAtIndex:[[DELEGATE strThemeNo] intValue]];
    searchBar.viewBorder.layer.borderColor = color.CGColor;
    searchBar.view.layer.borderColor = color.CGColor;
    [searchBar.imgBackground setBackgroundColor:backColor];
    searchBar.txtKeyword.suggestions = [DELEGATE aryKeywords];
    
    [searchBar.imgBackground setBackgroundColor:[UIColor clearColor]];
    searchBar.view.backgroundColor = [UIColor clearColor];
    searchBar.view.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self refreshLoadMoreView];
    
    searchEngine = [DELEGATE searchEngine];
    
    searchBar.txtKeyword.suggestions = [DELEGATE aryKeywords];
    
    [searchBar.imgBackground setBackgroundColor:[UIColor clearColor]];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSDictionary *keyword = [DELEGATE dicSearchKey];
    if (keyword != nil) {
        searchBar.txtKeyword.text = [keyword objectForKey:@"keyword"];
        searchBar.txtLocation.text = [keyword objectForKey:@"location"];
        searchBar.txtDomain.text = [keyword objectForKey:@"domain"];
        searchBar.txtTime.text = [keyword objectForKey:@"time"];
        
        [self searchClick];
        [DELEGATE setDicSearchKey:nil];
    }

}
-(void)refreshLoadMoreView {
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    NSDictionary *engine = [DELEGATE engineOption];
    CGRect rect = self.viewLoadMore.frame;
    rect.origin.x = 0;
    rect.size.width = screenRect.size.width;
    self.viewLoadMore.frame = rect;

    rect = self.btnLoadMore.frame;
    rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
    self.btnLoadMore.frame = rect;
    
    NSArray *engineName = @[@"google", @"yahoo", @"bing"];
    NSMutableArray *selectedEngine = [NSMutableArray array];
    for (int i = 0; i < engineName.count; i++) {
        NSString *name = [engineName objectAtIndex:i];
        if ([[engine objectForKey:name] isEqualToString:@"1"]) {
            [selectedEngine addObject:name];
        }
    }

    int margin = 15;
    int btnWidth = (screenRect.size.width - margin * 3) / 2;
    int btnHeight = btnWidth / 517.0f * 104.f;
    if (selectedEngine.count == 3) {
        if ([[DELEGATE searchEngine] isEqualToString:@"google"]) {
            [self.btnEngine1 setImage:[UIImage imageNamed:@"btnyahoo.png"] forState:UIControlStateNormal];
            [self.btnEngine1 setTitle:@"yahoo" forState:UIControlStateNormal];
            [self.btnEngine2 setImage:[UIImage imageNamed:@"btnbing.png"] forState:UIControlStateNormal];
            [self.btnEngine2 setTitle:@"bing" forState:UIControlStateNormal];
            
        }
        if ([[DELEGATE searchEngine] isEqualToString:@"yahoo"]) {
            [self.btnEngine1 setImage:[UIImage imageNamed:@"btngoogle.png"] forState:UIControlStateNormal];
            [self.btnEngine1 setTitle:@"google" forState:UIControlStateNormal];
            [self.btnEngine2 setImage:[UIImage imageNamed:@"btnbing"] forState:UIControlStateNormal];
            [self.btnEngine2 setTitle:@"bing" forState:UIControlStateNormal];
            
        }
        if ([[DELEGATE searchEngine] isEqualToString:@"bing"]) {
            [self.btnEngine1 setImage:[UIImage imageNamed:@"btnyahoo.png"] forState:UIControlStateNormal];
            [self.btnEngine1 setTitle:@"yahoo" forState:UIControlStateNormal];
            [self.btnEngine2 setImage:[UIImage imageNamed:@"btngoogle.png"] forState:UIControlStateNormal];
            [self.btnEngine2 setTitle:@"google" forState:UIControlStateNormal];
            
        }
        CGRect rect = self.btnEngine1.frame;
        rect.origin.x = margin;
        rect.size.height = btnHeight;
        rect.size.width = btnWidth;
        self.btnEngine1.frame = rect;
        
        rect.origin.x += margin + btnWidth;
        self.btnEngine2.frame = rect;
        
        [self.btnEngine1 setHidden:NO];
        [self.btnEngine2 setHidden:NO];
    } else if (selectedEngine.count == 2) {
        CGRect rect = self.btnEngine1.frame;
        rect.size.width = btnWidth;
        rect.size.height = btnHeight;
        rect.origin.x = (screenRect.size.width - rect.size.width) / 2;
        self.btnEngine1.frame = rect;
        for (int i = 0; i < selectedEngine.count; i++) {
            NSString *name = [selectedEngine objectAtIndex:i];
            if ([name isEqualToString:[DELEGATE searchEngine]]) {
                continue;
            }
            NSString *btnName = [NSString stringWithFormat:@"btn%@.png", name];
            [self.btnEngine1 setImage:[UIImage imageNamed:btnName] forState:UIControlStateNormal];
            [self.btnEngine1 setTitle:name forState:UIControlStateNormal];
        }
        [self.btnEngine1 setHidden:NO];
        [self.btnEngine2 setHidden:YES];
    } else {
        [self.btnEngine1 setHidden:YES];
        [self.btnEngine2 setHidden:YES];
    }
}
- (IBAction)onMenu:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (IBAction)onWeb:(id)sender {
    CGRect rectBtn = self.btnWeb.frame;
    CGRect rect = self.imgSel.frame;
    rect.origin.x = rectBtn.origin.x;
    rect.size.width = rectBtn.size.width;
    [UIView animateWithDuration:0.3f animations:^{
        self.imgSel.frame = rect;
    }];
    
    NSArray *btnArray = @[self.btnWeb, self.btnImage, self.btnVideo, self.btnNews];
    for (int i = 0; i < btnArray.count; i++) {
        UIButton *btn = [btnArray objectAtIndex:i];
        [btn setAlpha:0.4];
    }
    [self.btnWeb setAlpha:1.0f];
    
    searchType = @"web";
    [self searchClick];
}

- (IBAction)onImage:(id)sender {
    CGRect rectBtn = self.btnImage.frame;
    CGRect rect = self.imgSel.frame;
    rect.origin.x = rectBtn.origin.x;
    rect.size.width = rectBtn.size.width;
    [UIView animateWithDuration:0.3f animations:^{
        self.imgSel.frame = rect;
    }];
    NSArray *btnArray = @[self.btnWeb, self.btnImage, self.btnVideo, self.btnNews];
    for (int i = 0; i < btnArray.count; i++) {
        UIButton *btn = [btnArray objectAtIndex:i];
        [btn setAlpha:0.4];
    }
    [self.btnImage setAlpha:1.0f];
    searchType = @"image";
    [self searchClick];
}

- (IBAction)onVideo:(id)sender {
    CGRect rectBtn = self.btnVideo.frame;
    CGRect rect = self.imgSel.frame;
    rect.origin.x = rectBtn.origin.x;
    rect.size.width = rectBtn.size.width;
    [UIView animateWithDuration:0.3f animations:^{
        self.imgSel.frame = rect;
    }];
    NSArray *btnArray = @[self.btnWeb, self.btnImage, self.btnVideo, self.btnNews];
    for (int i = 0; i < btnArray.count; i++) {
        UIButton *btn = [btnArray objectAtIndex:i];
        [btn setAlpha:0.4];
    }
    [self.btnVideo setAlpha:1.0f];
    searchType = @"video";
    [self searchClick];
}

- (IBAction)onNews:(id)sender {
    CGRect rectBtn = self.btnNews.frame;
    CGRect rect = self.imgSel.frame;
    rect.origin.x = rectBtn.origin.x;
    rect.size.width = rectBtn.size.width;
    [UIView animateWithDuration:0.3f animations:^{
        self.imgSel.frame = rect;
    }];
    NSArray *btnArray = @[self.btnWeb, self.btnImage, self.btnVideo, self.btnNews];
    for (int i = 0; i < btnArray.count; i++) {
        UIButton *btn = [btnArray objectAtIndex:i];
        [btn setAlpha:0.4];
    }
    [self.btnNews setAlpha:1.0f];
    searchType = @"news";
    [self searchClick];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.txtSearch resignFirstResponder];
    return YES;
}

-(void)doSearch {
    
    NSString *searchEngine = [DELEGATE searchEngine];
    if ([searchEngine isEqualToString:@"google"]) {
        [self googleSearch];
    } else if ([searchEngine isEqualToString:@"yahoo"]) {
        [self yahooSearch];
    } else {
        [self bingSearch];
    }
    
}

-(void)googleSearch {
    NSString *keyword = searchBar.txtKeyword.text;
    NSString *domain = searchBar.txtDomain.text;
    NSString *location = searchBar.txtLocation.text;
    NSString *time = searchBar.txtTime.text;
    if ([keyword isEqualToString:@""] && [domain isEqualToString:@""]) {
        //[self showError:@"Please input the keyword!"];
        return;
    }
    [_hud show:YES];
    /*if (![location isEqualToString:@""]) {
        keyword = [NSString stringWithFormat:@"%@&gl=%@", keyword, location];
    }*/
    keyword = [NSString stringWithFormat:@"%@ %@", keyword, location];
    if (![time isEqualToString:@"any time"]) {
        if ([time isEqualToString:@"past 24 hours"]) {
            keyword = [NSString stringWithFormat:@"%@&tbs=qdr:d", keyword];
        } else if ([time isEqualToString:@"past week"]) {
            keyword = [NSString stringWithFormat:@"%@&tbs=qdr:w", keyword];
        } else if([time isEqualToString:@"past month"]) {
            keyword = [NSString stringWithFormat:@"%@&tbs=qdr:m", keyword];
        } else {
            keyword = [NSString stringWithFormat:@"%@&tbs=qdr:y", keyword];
        }
        
    }
    if (![domain isEqualToString:@""]) {
        keyword = [NSString stringWithFormat:@"%@ site:%@", keyword, domain];
    }
    self.googleClient = [[RSNetworkClient alloc] init];
    [self.googleClient setDelegate:self];
    [self.googleClient setSelector:@selector(googleClientResponse:)];
    NSString *url = @"https://www.googleapis.com/customsearch/v1";
    NSString *deviceToken=[[NSUserDefaults standardUserDefaults] valueForKey:@"DeviceToken"];
    //email, password, devicetoken, type
    NSString *postStr = [NSString stringWithFormat:@"q=%@&key=%@&cx=%@", keyword, googleKey, googleEngineID];
    if ([searchType isEqualToString:@"image"]) {
        postStr = [NSString stringWithFormat:@"%@&searchType=%@", postStr, @"image"];
    }
    pageSize = 10; //web, image search size is 10;
    if ([searchType isEqualToString:@"video"]) {
        postStr = [NSString stringWithFormat:@"v=1.0&q=%@", keyword];
        url = @"https://ajax.googleapis.com/ajax/services/search/video";
        pageSize = 4;
    }
    if ([searchType isEqualToString:@"news"]) {
        postStr = [NSString stringWithFormat:@"v=1.0&q=%@", keyword];
        url = @"https://ajax.googleapis.com/ajax/services/search/news";
        pageSize = 4;
    }
    postStr = [NSString stringWithFormat:@"%@&start=%d", postStr, pageNo * pageSize + 1];
    NSLog(@"%@", postStr);
    [self.googleClient sendRequest:[NSString stringWithFormat:@"%@?%@", url, postStr]];
}

- (void)googleClientResponse:(NSDictionary *)response {
    [_hud hide:NO];
    if(!response){
        //[self showError:@"Request failed"];
    } else {
        if([response objectForKey:@"response"]) {
            NSDictionary *dict = [response objectForKey:@"response"];
            NSMutableArray *ary = [dict objectForKey:@"items"];
            
            if ([searchType isEqualToString:@"video"] || ([searchType isEqualToString:@"news"])) {
                ary = [[dict objectForKey:@"responseData"] objectForKey:@"results"];
               
            }
            if (ary.count < pageSize) {
                pageNo --;
            }
            
            if (ary.count == 0) {
                [self showError:@"No Result"];
                
            }
            if (aryGoogleResult.count > 0) {
                NSDictionary *lastObj = [aryGoogleResult objectAtIndex:((pageNo - 1) * pageSize)];
                if ([lastObj isEqualToDictionary:[ary objectAtIndex:0]]) {
                    [self showError:@"No more result"];
                    pageNo--;
                    return;
                }
            }
           
            for (int i = 0; i < ary.count; i++) {
                [aryGoogleResult addObject:[ary objectAtIndex:i]];
            }
            [self refresh];
        }
    }
}

-(void)yahooSearch {
    //[self showError:@"Comming SOON"];
    //return;
    
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:Consumer_key
                                                    secret:Consumer_secret];
    pageSize = 10;
    NSString *yahooType;
    if ([searchType isEqualToString:@"web"]) {
        yahooType = @"web";
    } else if ([searchType isEqualToString:@"image"]) {
        yahooType = @"images";
    } else {
        yahooType = searchType;
    }
    
    NSString *keyword = searchBar.txtKeyword.text;
    NSString *domain = searchBar.txtDomain.text;
    NSString *location = searchBar.txtLocation.text;
    NSString *time = searchBar.txtTime.text;
    if ([keyword isEqualToString:@""] && [domain isEqualToString:@""]) {
        //[self showError:@"Please input the keyword!"];
        return;
    }
    [_hud show:YES];
    /*if (![location isEqualToString:@""]) {
     keyword = [NSString stringWithFormat:@"%@&gl=%@", keyword, location];
     }*/
    keyword = [NSString stringWithFormat:@"%@ %@", keyword, location];
    if (![time isEqualToString:@"any time"]) {
        keyword = [NSString stringWithFormat:@"%@ %@", keyword, time];
    }
    if (![domain isEqualToString:@""]) {
        keyword = [NSString stringWithFormat:@"%@&sites=%@", keyword, domain];
    }
    keyword = [keyword stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *strUrl = [NSString stringWithFormat:@"http://yboss.yahooapis.com/ysearch/%@?q=%@&format=json&start=%d&count=%d",yahooType, keyword, pageNo * pageSize, pageSize];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:url
                                                                   consumer:consumer
                                                                      token:nil   // we don't have a Token yet
                                                                      realm:@"yahooapis.com"
                                                          signatureProvider:nil]; // use the default method, HMAC-SHA1
    [request prepare];
    [request setHTTPMethod:@"GET"];
    
    webData = [[NSMutableData alloc] init];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
    
    /*NSString *strUrl = @"http://yboss.yahooapis.com/ysearch/images?q=obama&format=json&count=1";
    NSString *keyString = [NSString stringWithFormat:@"%@:%@", Consumer_secret , Consumer_key];
    NSData *plainTextData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainTextData base64Encoding];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:strUrl]];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64String];
    [req setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    [_hud hide:NO];
    if (data == nil) {
        //[self showError:@"No Result"];
        //[getData invalidate];
        strGetData = @"failed";
        return;
    }
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Response: %@", result);*/
    
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [_hud hide:NO];
    NSLog(@"finished");
    
    NSString *response = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"Response: %@", response);
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:webData options:NSJSONReadingMutableContainers error:&error];
    if (json == nil) {
        //[self showError:@"No Result"];
        strGetData = @"failed";
        //[getData invalidate];
        return;
    }

    
    //image search
    NSArray *data = [[[json objectForKey:@"bossresponse"] objectForKey:searchType] objectForKey:@"results"];
    if (![searchType isEqualToString:@"image"]) {
        if (data.count == 0) {
            [self showError:@"No Result"];
        }
    }
    if ([searchType isEqualToString:@"image"]) {
        data = [[[json objectForKey:@"bossresponse"] objectForKey:@"images"] objectForKey:@"results"];
        if (data.count == 0) {
            [self showError:@"No Result"];
            return;
        }
        if (aryGoogleResult.count > 0) {
            NSDictionary *lastObj = [aryGoogleResult objectAtIndex:((pageNo - 1)* pageSize)];
            if ([[lastObj objectForKey:@"link"] isEqualToString:[[data objectAtIndex:0]  objectForKey:@"url"]]) {
                [self showError:@"No more result"];
                pageNo --;
                return;
            }
        }
        
        for (int i = 0; i < data.count; i++) {
            NSDictionary *dic = [data objectAtIndex:i];
            NSString *url = [dic objectForKey:@"url"];
            NSDictionary *item = [[NSDictionary alloc] initWithObjectsAndKeys:url, @"link", nil];
            [aryGoogleResult addObject:item];
        }
    } else if ([searchType isEqualToString:@"web"]) {
        //NSArray *data = [[[json objectForKey:@"bossresponse"] objectForKey:@"web"] objectForKey:@"results"];
        if (aryGoogleResult.count > 0) {
            NSDictionary *lastObj = [aryGoogleResult objectAtIndex:((pageNo - 1)* pageSize)];
            if ([[lastObj objectForKey:@"link"] isEqualToString:[[data objectAtIndex:0]  objectForKey:@"url"]]) {
                [self showError:@"No more result"];
                pageNo --;
                return;
            }
        }
        
        for (int i = 0; i < data.count; i++) {
            NSDictionary *dic = [data objectAtIndex:i];
            NSString *title = [dic objectForKey:@"title"];
            NSString *url = [dic objectForKey:@"url"];
            NSString *desc = [dic objectForKey:@"abstract"];
            
            NSDictionary *item = [[NSDictionary alloc] initWithObjectsAndKeys:title, @"title", desc, @"snippet", url, @"link", nil];
            [aryGoogleResult addObject:item];
        }

    } else if ([searchType isEqualToString:@"video"]) {
        //NSArray *data = [[[json objectForKey:@"bossresponse"] objectForKey:@"web"] objectForKey:@"results"];
        if (aryGoogleResult.count > 0) {
            NSDictionary *lastObj = [aryGoogleResult objectAtIndex:((pageNo - 1)* pageSize)];
            if ([[lastObj objectForKey:@"url"] isEqualToString:[[data objectAtIndex:0]  objectForKey:@"url"]]) {
                [self showError:@"No more result"];
                pageNo --;
                return;
            }
        }
        for (int i = 0; i < data.count; i++) {
            NSDictionary *dic = [data objectAtIndex:i];
            NSString *published = [dic objectForKey:@"date"];
            NSString *tbUrl = [dic objectForKey:@"thumbnailurl"];
            NSString *title = [dic objectForKey:@"title"];
            NSString *url = [dic objectForKey:@"url"];
            NSString *content = [dic objectForKey:@"abstract"];
            NSDictionary *item = [[NSDictionary alloc] initWithObjectsAndKeys:published, @"published", tbUrl, @"tbUrl", title, @"title", content, @"content", url, @"url", nil];
            [aryGoogleResult addObject:item];
        }
    } else if ([searchType isEqualToString:@"news"]) {
        //NSArray *data;
        if (aryGoogleResult.count > 0) {
            NSDictionary *lastObj = [aryGoogleResult objectAtIndex:((pageNo - 1)* pageSize)];
            if ([[lastObj objectForKey:@"unescapedUrl"] isEqualToString:[[data objectAtIndex:0]  objectForKey:@"url"]]) {
                [self showError:@"No more result"];
                pageNo --;
                return;
            }
        }
        
        for (int i = 0; i < data.count; i++) {
            NSDictionary *dic = [data objectAtIndex:i];
            NSString *content = [dic objectForKey:@"abstract"];
            NSString *tbUrl = [[dic objectForKey:@"Thumbnail"] objectForKey:@"MediaUrl"];
            NSString *title = [dic objectForKey:@"title"];
            NSString *url = [dic objectForKey:@"url"];
            NSDictionary *item = [[NSDictionary alloc] initWithObjectsAndKeys:content, @"content", @"", @"tbUrl", title, @"title", url, @"unescapedUrl", nil];
            [aryGoogleResult addObject:item];
        }

    }
    
    [self refresh];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_hud hide:NO];
    [webData appendData:data];
}

-(void)bingSearch {
    
    strGetData = @"false";
    getData =  [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(BingRefresh) userInfo:nil repeats:YES];
    
    NSString *keyword = searchBar.txtKeyword.text;
    NSString *domain = searchBar.txtDomain.text;
    NSString *location = searchBar.txtLocation.text;
    NSString *time = searchBar.txtTime.text;
    if ([keyword isEqualToString:@""] && [domain isEqualToString:@""]) {
        //[self showError:@"Please input the keyword!"];
        [_hud hide:NO];
        [getData invalidate];
        return;
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self bingDoSearch];
    });
    
    //[NSThread detachNewThreadSelector:@selector(bingDoSearch) toTarget:self withObject:nil];
}

-(void)BingRefresh {
    [_hud show:YES];
    if ([strGetData isEqualToString:@"true"]) {
        [_hud hide:NO];
        [getData invalidate];
        [self refresh];
    }
    if ([strGetData isEqualToString:@"failed"]) {
        [_hud hide:NO];
        
        [getData invalidate];
        [self showError:@"No Result"];
    }
}
-(void)bingDoSearch {
    
    //NSString *searchUrl = [NSString stringWithFormat:@"https://api.datamarket.azure.com/Data.ashx/Bing/Search/v1/Image?Query=%@&Market='en-US'&$top=50&$format=json", @"ronaldo"];
    NSString *keyword = searchBar.txtKeyword.text;
    NSString *domain = searchBar.txtDomain.text;
    NSString *location = searchBar.txtLocation.text;
    NSString *time = searchBar.txtTime.text;
    if ([keyword isEqualToString:@""] && [domain isEqualToString:@""]) {
        [self showError:@"Please input the keyword!"];
        [_hud hide:NO];
        [getData invalidate];
        return;
    }
    pageSize = 10;
    if (![location isEqualToString:@""]) {
        keyword = [NSString stringWithFormat:@"%@&location:%@", keyword, location];
    }
    
    if ((![time isEqualToString:@"any time"]) && (![time isEqualToString:@""])){
        keyword = [NSString stringWithFormat:@"%@ %@", keyword, time];
    }
    if (![domain isEqualToString:@""]) {
        keyword = [NSString stringWithFormat:@"%@ site:%@", keyword, domain];
    }
    
    keyword = [keyword stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *searchUrl = [NSString stringWithFormat:@"https://api.datamarket.azure.com/Data.ashx/Bing/Search/v1/Web?Market=\'en-GB\'&$format=json&Query=\'%@\'&$top=10&$skip=%d", keyword, pageSize * pageNo];
    if ([searchType isEqualToString:@"image"]) {
        searchUrl = [NSString stringWithFormat:@"https://api.datamarket.azure.com/Data.ashx/Bing/Search/v1/Image?Market=\'en-GB\'&$format=json&Query=\'%@\'&$top=10&$skip=%d", keyword, pageSize * pageNo];
    } else if ([searchType isEqualToString:@"video"]) {
        searchUrl = [NSString stringWithFormat:@"https://api.datamarket.azure.com/Data.ashx/Bing/Search/v1/Video?Market=\'en-GB\'&$format=json&Query=\'%@\'&$top=10&$skip=%d", keyword, pageSize * pageNo];
    } else if ([searchType isEqualToString:@"news"]) {
        searchUrl = [NSString stringWithFormat:@"https://api.datamarket.azure.com/Data.ashx/Bing/Search/v1/News?Market=\'en-GB\'&$format=json&Query=\'%@\'&$top=10&$skip=%d", keyword, pageSize * pageNo];
    }
    
    //searchUrl = @"https://api.datamarket.azure.com/Data.ashx/Bing/Search/v1/Web?Market=\'en-GB\'&$format=json&Query=\'ronaldo  \'&$top=10&skip=0";
    //searchUrl = @"https://api.datamarket.azure.com/Data.ashx/Bing/Search/v1/Web?Market='en-GB'&$format=json&Query='ronaldo  '&$top=10&skip=0";
    NSString *keyString = [NSString stringWithFormat:@"%@:%@", BING_SEARCH_API_KEY, BING_SEARCH_API_KEY];
    NSData *plainTextData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainTextData base64Encoding];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:searchUrl]];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", base64String];
    [req setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *retdata = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    [_hud hide:NO];
    if (retdata == nil) {
        //[self showError:@"No Result"];
        //[getData invalidate];
        strGetData = @"failed";
        return;
    }
    NSString *result = [[NSString alloc] initWithData:retdata encoding:NSUTF8StringEncoding];
    NSLog(@"Response: %@", result);
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:retdata options:NSJSONReadingMutableContainers error:&error];
    if (json == nil) {
        //[self showError:@"No Result"];
        strGetData = @"failed";
        //[getData invalidate];
        return;
    }
    NSArray *d = [[json objectForKey:@"d"] objectForKey:@"results"];
    if (d.count == 0) {
        strGetData = @"failed";
        //[self showError:@"No Result"];
        //[getData invalidate];
        return;
    }
    
    NSArray *data = [[json objectForKey:@"d"] objectForKey:@"results"];
    if ([searchType isEqualToString:@"web"]) {
        if (aryGoogleResult.count > 0) {
            NSDictionary *lastObj = [aryGoogleResult objectAtIndex:((pageNo - 1)* pageSize)];
            if ([[lastObj objectForKey:@"link"] isEqualToString:[[data objectAtIndex:0]  objectForKey:@"Url"]]) {
                [self showError:@"No more result"];
                pageNo --;
                return;
            }
        }

        for (int i = 0; i < data.count; i++) {
            NSDictionary *dic = [data objectAtIndex:i];
            NSString *title = [dic objectForKey:@"Title"];
            NSString *url = [dic objectForKey:@"Url"];
            NSString *desc = [dic objectForKey:@"Description"];
            
            NSDictionary *item = [[NSDictionary alloc] initWithObjectsAndKeys:title, @"title", desc, @"snippet", url, @"link", nil];
            [aryGoogleResult addObject:item];
        }
        strGetData = @"true";
        //[self refresh];
    } else if ([searchType isEqualToString:@"image"]) {
        
        if (aryGoogleResult.count > 0) {
            NSDictionary *lastObj = [aryGoogleResult objectAtIndex:((pageNo - 1)* pageSize)];
            if ([[lastObj objectForKey:@"link"] isEqualToString:[[data objectAtIndex:0]  objectForKey:@"MediaUrl"]]) {
                [self showError:@"No more result"];
                pageNo --;
                return;
            }
        }
        
        for (int i = 0; i < data.count; i++) {
            NSDictionary *dic = [data objectAtIndex:i];
            NSString *url = [dic objectForKey:@"MediaUrl"];
            NSDictionary *item = [[NSDictionary alloc] initWithObjectsAndKeys:url, @"link", nil];
            [aryGoogleResult addObject:item];
        }
        strGetData = @"true";
        //[self refresh];
    } else if ([searchType isEqualToString:@"video"]) {
        if (aryGoogleResult.count > 0) {
            NSDictionary *lastObj = [aryGoogleResult objectAtIndex:((pageNo - 1)* pageSize)];
            if ([[lastObj objectForKey:@"url"] isEqualToString:[[data objectAtIndex:0]  objectForKey:@"MediaUrl"]]) {
                [self showError:@"No more result"];
                pageNo --;
                return;
            }
        }
        for (int i = 0; i < data.count; i++) {
            NSDictionary *dic = [data objectAtIndex:i];
            NSString *published = @"";
            NSString *tbUrl = [[dic objectForKey:@"Thumbnail"] objectForKey:@"MediaUrl"];
            NSString *title = [dic objectForKey:@"Title"];
            NSString *url = [dic objectForKey:@"MediaUrl"];
            NSDictionary *item = [[NSDictionary alloc] initWithObjectsAndKeys:published, @"published", tbUrl, @"tbUrl", @"", @"title", title, @"content", url, @"url", nil];
            [aryGoogleResult addObject:item];
        }
        strGetData = @"true";
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //    [self refresh];
        //});
        //[self refresh];
    } else {
        if (aryGoogleResult.count > 0) {
            NSDictionary *lastObj = [aryGoogleResult objectAtIndex:((pageNo - 1)* pageSize)];
            if ([[lastObj objectForKey:@"unescapedUrl"] isEqualToString:[[data objectAtIndex:0]  objectForKey:@"Url"]]) {
                [self showError:@"No more result"];
                pageNo --;
                return;
            }
        }
        
        for (int i = 0; i < data.count; i++) {
            NSDictionary *dic = [data objectAtIndex:i];
            NSString *content = [dic objectForKey:@"Description"];
            NSString *tbUrl = [[dic objectForKey:@"Thumbnail"] objectForKey:@"MediaUrl"];
            NSString *title = [dic objectForKey:@"Title"];
            NSString *url = [dic objectForKey:@"Url"];
            NSDictionary *item = [[NSDictionary alloc] initWithObjectsAndKeys:content, @"content", @"", @"tbUrl", title, @"title", url, @"unescapedUrl", nil];
            [aryGoogleResult addObject:item];
        }
        strGetData = @"true";
        //[self refresh];
    }
}
- (IBAction)onLoadMore:(id)sender {
    //[self showError:@"Comming SOON!"];
    pageNo ++;
    [self doSearch];
}

- (IBAction)onEngine1:(id)sender {
    NSString *engine = self.btnEngine1.titleLabel.text;
    [DELEGATE setSearchEngine:engine];
    [self refreshLoadMoreView];
    [self searchClick];
}

- (IBAction)onEngine2:(id)sender {
    NSString *engine = self.btnEngine2.titleLabel.text;
    [DELEGATE setSearchEngine:engine];
    [self refreshLoadMoreView];
    [self searchClick];
}

-(void)refresh {
    
    [_hud hide:NO];
    
    NSArray *subView = [self.scrollContent subviews];
    for (int i = pageNo; i < subView.count; i++) {
        UIView *view = [subView objectAtIndex:i];
        if (view.tag == 101) { //loadmore view;
            continue;
        }
        [view removeFromSuperview];
    }
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    
    int x = -1;
    int y = 0;
    int width = screenRect.size.width + 2;
    int height = 150;
    
    if ([searchType isEqualToString:@"news"]) {
        for (int i = 0; i < aryGoogleResult.count; i++) {
            UISearchVideoItemView *item = [[UISearchVideoItemView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            item.delegate = self;
            NSDictionary *dic = [aryGoogleResult objectAtIndex:i];
            NSString *title = [self stringByStrippingHTML:[dic objectForKey:@"title"]] ;
            NSString *content = [self stringByStrippingHTML:[dic objectForKey:@"content"]];
            
            /*NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[title dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            [attrStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:20.0]
                          range:NSMakeRange(0,[attrStr length])];
            
            item.lblTitle.attributedText = attrStr;*/
            item.lblTitle.text = title;
            item.lblTime.text = [dic objectForKey:@"unescapedUrl"];
            item.url = [dic objectForKey:@"unescapedUrl"];
            /*attrStr = [[NSMutableAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            [attrStr addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:14.0f]
                            range:NSMakeRange(0,[attrStr length])];
            
            item.txtContent.attributedText = attrStr;*/
            item.txtContent.text = content;
            item.lblTitle.tag = i;
            [item.lblTitle setUserInteractionEnabled:YES];
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linkClicked:)];
            [item.lblTitle addGestureRecognizer:gesture];
            
            [item.image setUserInteractionEnabled:YES];
            item.image.tag = i;
            UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linkClicked:)];
            [item.image addGestureRecognizer:gesture1];
            
            NSString *imgUrl = [[dic objectForKey:@"image"] objectForKey:@"tbUrl"];
            [item.image loadImageFromURL:[NSURL URLWithString:imgUrl]];
            [self.scrollContent addSubview:item];
            
            y += height - 1;
        }
        
    } else if ([searchType isEqualToString:@"video"]) {
        for (int i = 0; i < aryGoogleResult.count; i++) {
            UISearchVideoItemView *item = [[UISearchVideoItemView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            item.delegate = self;
            NSDictionary *dic = [aryGoogleResult objectAtIndex:i];
            item.lblTime.text = [dic objectForKey:@"published"];
            NSString *imgUrl = [dic objectForKey:@"tbUrl"];
            [item.image loadImageFromURL:[NSURL URLWithString:imgUrl]];
            
            NSString *title = [self stringByStrippingHTML : [dic objectForKey:@"title"]];
            NSString *content = [self stringByStrippingHTML : [dic objectForKey:@"content"]];
            
            /*NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[title dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            [attrStr addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:20.0]
                            range:NSMakeRange(0,[attrStr length])];
            
            item.lblTitle.attributedText = attrStr;*/
            item.lblTitle.text = title;
            
            /*attrStr = [[NSMutableAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            [attrStr addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:14.0f]
                            range:NSMakeRange(0,[attrStr length])];
            
            item.txtContent.attributedText = attrStr;*/
            item.txtContent.text = content;
            item.url = [dic objectForKey:@"url"];
            item.lblTitle.tag = i;
            [item.lblTitle setUserInteractionEnabled:YES];
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoClicked:)];
            [item.lblTitle addGestureRecognizer:gesture];
            
            item.txtContent.tag = i;
            [item.txtContent setUserInteractionEnabled:YES];
            UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoClicked:)];
            [item.txtContent addGestureRecognizer:gesture1];
            
            item.image.tag = i;
            [item.image setUserInteractionEnabled:YES];
            UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoClicked:)];
            [item.image addGestureRecognizer:gesture2];
            
            [self.scrollContent addSubview:item];
            
            y += height - 1;
        }

    } else if ([searchType isEqualToString:@"image"]) {
        width = self.scrollContent.frame.size.width / 2 - 6;
        x = 2;
        for (int i = 0; i < aryGoogleResult.count; i++) {
            NSDictionary *dic = [aryGoogleResult objectAtIndex:i];
            AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            UIImage *image = [imgDic objectForKey:[dic objectForKey:@"link"]];
            if (image != nil) {
                imageView.image = image;
            } else {
                [imageView loadImageFromURL:[NSURL URLWithString:[dic objectForKey:@"link"]]];
            }
            imageView.tag = i;
            imageView.layer.masksToBounds = YES;
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
            [imageView setUserInteractionEnabled:YES];
            [imageView addGestureRecognizer:gesture];
            
            imageView.delegate = self;
            [self.scrollContent addSubview:imageView];
            x += width + 2;
            if (i % 2 == 1) {
                x = 2;
                y += width + 2;
            }
        }
    } else {
        for (int i = 0; i < aryGoogleResult.count; i++) {
            UISearchItemView *item = [[UISearchItemView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            item.delegate = self;
            NSDictionary *dic = [aryGoogleResult objectAtIndex:i];
            
            NSString *title = [dic objectForKey:@"title"];
            NSString *content = [dic objectForKey:@"snippet"];
            
            /*NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[title dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            [attrStr addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:20.0]
                            range:NSMakeRange(0,[attrStr length])];
            
            item.lblHeader.attributedText = attrStr;*/
            item.lblHeader.text = [self stringByStrippingHTML:title];
            /*attrStr = [[NSMutableAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            [attrStr addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:14.0f]
                            range:NSMakeRange(0,[attrStr length])];*/
            
            item.txtDesc.text = [self stringByStrippingHTML:content];
            
            item.lblLink.text = [self stringByStrippingHTML:[dic objectForKey:@"link"]];
            item.url = [dic objectForKey:@"link"];
            item.lblHeader.tag = i;
            [item.lblHeader setUserInteractionEnabled:YES];
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linkClicked:)];
            [item.lblHeader addGestureRecognizer:gesture];
            
            [self.scrollContent addSubview:item];
            
            y += height - 1;
        }
    }
    
    CGRect rect = self.viewLoadMore.frame;
    rect.origin.y = y;
    self.viewLoadMore.frame = rect;
    [self.viewLoadMore setHidden:NO];
    
    y += rect.size.height;
    [self.scrollContent setContentSize:CGSizeMake(0, y)];
    if ([searchType isEqualToString:@"image"]) {
        [self.scrollContent setContentOffset:CGPointMake(0, (pageNo) * pageSize / 2 * height)];
    } else {
        [self.scrollContent setContentOffset:CGPointMake(0, (pageNo) * pageSize * height)];
    }
    
    //[self.scrollContent setContentOffset:CGPointMake(0, 0)];
}

-(void)searchClick {
    [self.scrollContent setContentOffset:CGPointMake(0, 10)];
    pageNo = 0;
    aryGoogleResult = [NSMutableArray array];
    [self doSearch];
    if ([searchBar.txtKeyword.text isEqualToString:@""]) {
        return;
    }
    if ([[DELEGATE strKeepHistory] isEqualToString:@"true"]) { // keep history;
        NSMutableArray *aryKeywords = [DELEGATE aryKeywords];
        int newKeyword = 1;
        for (int i = 0; i < aryKeywords.count; i++) {
            NSString *item = [aryKeywords objectAtIndex:i];
            if ([item isEqualToString:searchBar.txtKeyword.text]) {
                newKeyword = 0;
                break;
            }
        }
        if (newKeyword == 1) {
            [aryKeywords addObject:searchBar.txtKeyword.text];
            for (int i = 0; i < aryKeywords.count; i++) {
                for (int j = i+1; j < aryKeywords.count; j++) {
                    NSString *a = [aryKeywords objectAtIndex:i];
                    NSString *b = [aryKeywords objectAtIndex:j];
                    if ([a compare:b] == NSOrderedDescending) {
                        [aryKeywords replaceObjectAtIndex:i withObject:b];
                        [aryKeywords replaceObjectAtIndex:j withObject:a];
                    }
                }
            }
            [DELEGATE setAryKeywords:aryKeywords];
            [[NSUserDefaults standardUserDefaults] setObject:aryKeywords forKey:@"keyword"];
            searchBar.txtKeyword.suggestions = aryKeywords;
        }
        
    }
    
}
-(void)imageLoaded:(UIImage *)image url:(NSString *)url {
    [imgDic setObject:image forKey:url];
}

-(void)videoClicked : (UITapGestureRecognizer *)gesture {
    int tag = gesture.view.tag;
    NSDictionary *dic = [aryGoogleResult objectAtIndex:tag];
    NSString *url = [dic objectForKey:@"url"];
    SearchWebView *webView = [[SearchWebView alloc] initWithNibName:@"SearchWebView" bundle:nil];
    webView.url = url;
    [self presentModalViewController:webView animated:YES];

}

-(void)imageClicked : (UITapGestureRecognizer *)gesture {
    int tag = gesture.view.tag;
    NSDictionary *dic = [aryGoogleResult objectAtIndex:tag];
    UIImage *image = [imgDic objectForKey:[dic objectForKey:@"link"]];
    SearchImageView *imageView = [[SearchImageView alloc] initWithNibName:@"SearchImageView" bundle:nil];
    imageView.imgUrl = [dic objectForKey:@"link"];
    [self presentModalViewController:imageView animated:YES];
}
-(void)linkClicked: (UITapGestureRecognizer *)gesture {

    int tag = gesture.view.tag;
    NSDictionary *dic = [aryGoogleResult objectAtIndex:tag];
    SearchWebView *webView = [[SearchWebView alloc] initWithNibName:@"SearchWebView" bundle:nil];
    if ( 1) {
        if ([searchType isEqualToString:@"news"]) {
            webView.url = [dic objectForKey:@"unescapedUrl"];
        } else {
            webView.url = [dic objectForKey:@"link"];
        }
    }
    [self presentModalViewController:webView animated:YES];
}
-(void)shareClick:(NSString *)url Image:(UIImage *)image {
    
    self.shareView = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
    [self.view addSubview:self.shareView.view];
    //CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    self.shareView.url = url;
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.shareView.viewMain.layer addAnimation:transition forKey:kCATransition];
}

-(NSString *) stringByStrippingHTML : (NSString*)source {
    NSRange r;
    NSString *s = [source copy] ;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"&amp" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"&nbsp" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"&#39;" withString:@""];
    return s;
}

@end
