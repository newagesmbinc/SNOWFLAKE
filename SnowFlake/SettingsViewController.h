//
//  SettingsViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "ServerRequests.h"
#import "SCLAlertView.h"
#import "AppDelegate.h"

@interface SettingsViewController : UIViewController<ServerRequestProcessDelegate>
{
    IBOutlet UIButton *DashBtn;
    AppDelegate *appD;
}

@end
