//
//  PrivacyViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 11/10/15.
//  Copyright © 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ServerRequests.h"
#import "NMRangeSlider.h"




@interface PrivacyViewController : UIViewController<ServerRequestProcessDelegate>
{
    
    
    
    AppDelegate *appDelegate;
    
    IBOutlet UIButton *maleBtn;
    IBOutlet UIButton *femaleBtn;
    
    IBOutlet NMRangeSlider *RangeSlider;
    
    IBOutlet UILabel *sliderAgeValue;
    
    IBOutlet UIView  *AgeView;
    
    
    NSString *male;
    NSString *female;
    NSString *str;
    NSString *Str1;
    NSString *Str2;
    
   
    
}
@end
