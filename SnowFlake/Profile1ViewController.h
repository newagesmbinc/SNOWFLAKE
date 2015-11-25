//
//  Profile1ViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 9/30/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface Profile1ViewController : UIViewController
{
    
     AppDelegate *appD;
    
    IBOutlet UIImageView *fbProfilePic;
    IBOutlet UILabel *nameLbl;
    IBOutlet UILabel *SelectLbl;
    IBOutlet UIView *termsView;
    IBOutlet UIWebView *termswebView;
    
    }
@end
