//
//  webDetailViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 11/10/15.
//  Copyright © 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



@interface webDetailViewController : UIViewController
{
    
    
    
    AppDelegate *appDelegate;
    
    
    
    
    IBOutlet UILabel *webLbl;
    IBOutlet UIWebView *webView;
    
}

@property (strong, nonatomic)  NSString *webData;

@end
