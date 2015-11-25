//
//  MyprofileViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "ServerRequests.h"


@interface MyprofileViewController : UIViewController<ServerRequestProcessDelegate>
{
    AppDelegate *appD;
    
    CGRect screenRect;
    CGFloat screenWidth;
    CGFloat ImageHt;
    
    
    
    IBOutlet UIButton *DashBtn;
    IBOutlet UIButton *backBtn;
    IBOutlet UIButton *closeBtn;
    IBOutlet UIButton *editbutton;
   
    
    IBOutlet UILabel *HomeMountain;
    IBOutlet UILabel *SkingLevel;
    IBOutlet UILabel *SnowingLevel;
    IBOutlet UILabel *FocusLabel;
    IBOutlet UILabel *AreaToImprove;
    IBOutlet UILabel *NameLbl1;
    IBOutlet UILabel *PlaceLbl1;
    IBOutlet UILabel *NameLbl;
    IBOutlet UILabel *PlaceLbl;
    
    IBOutlet UIPageControl *PageController;
    IBOutlet UIPageControl *PageController1;
    IBOutlet UIScrollView *imageScrollView1;
    IBOutlet UIScrollView *MainSroll;
    IBOutlet UIScrollView *imageScrollView;
    
    
    IBOutlet UIImageView *editLevel;
    IBOutlet UIImageView *backImage,*navImage;
    IBOutlet UIImageView *UserImage;
    
    IBOutlet UIView *fullview;
   
    
   
    NSMutableDictionary * disPlayData;
    NSMutableDictionary *SRDATA;
    NSArray *imagesArr;

    NSString *serverCalled;
    
    
}

@property(strong,nonatomic) NSMutableDictionary *FROMMM;
@property(strong,nonatomic)NSString *loginid;
@property(strong,nonatomic)NSString *FROMMTSELF;


@end
