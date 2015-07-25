//
//  MenuTableController.m
//  Leak
//
//  Created by Xin Jin on 16/6/14.
//  Copyright (c) 2014 Xin Jin. All rights reserved.
//
// --- Headers ---;
#import "MenuTableController.h"
#import "AppDelegate.h"

// --- Defines ---;
// MenuTableController Class;
@interface MenuTableController ()

@end

@implementation MenuTableController {
    int checked;
}

// Functions;
#pragma mark - MenuTableController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    checked = 1;
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:89/255.0f green:133/255.0f blue:168/255.0f alpha:0.6f]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[DELEGATE strKeepHistory] isEqualToString:@"true"]) {
        [self.slideCheck setOn:YES];
    } else {
        [self.slideCheck setOn:NO];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
            if ([self.delegate respondsToSelector:@selector(didSearchEngine)]) {
                [self.delegate performSelector:@selector(didSearchEngine) withObject:nil];
            }
            break;
            
        case 1:
            if ([self.delegate respondsToSelector:@selector(didKeepHistory)]) {
                [self.delegate performSelector:@selector(didKeepHistory) withObject:nil];
                if (checked == 1) {
                    //self.imgCheck.image = [UIImage imageNamed:@"checkoff.png"];
                    checked = 0;
                } else {
                    //self.imgCheck.image = [UIImage imageNamed:@"checkon.png"];
                    checked = 1;
                }
            }
            break;
            
        case 2:
            if ([self.delegate respondsToSelector:@selector(didClearHistory)]) {
                [self.delegate performSelector:@selector(didClearHistory) withObject:nil];
            }
            break;
            
        case 3:
            if ([self.delegate respondsToSelector:@selector(didChangeSkin)]) {
                [self.delegate performSelector:@selector(didChangeSkin) withObject:nil];
            }
            break;
        case 4:
            if ([self.delegate respondsToSelector:@selector(didAbout)]) {
                [self.delegate performSelector:@selector(didAbout) withObject:nil];
            }
            break;
        case 5:
            if ([self.delegate respondsToSelector:@selector(didNotification)]) {
                [self.delegate performSelector:@selector(didNotification) withObject:nil];
            }
            break;
        case 6:
            if ([self.delegate respondsToSelector:@selector(didLogout)]) {
                [self.delegate performSelector:@selector(didLogout) withObject:nil];
            }
            break;
        default:
            break;
    }
}

- (IBAction)switchChanged:(id)sender {
    if ([self.slideCheck isOn]) {
        [DELEGATE setStrKeepHistory:@"true"];
    } else {
        [DELEGATE setStrKeepHistory:@"false"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[DELEGATE strKeepHistory] forKey:@"chkhistory"];
}
@end
