//
//  MatchsViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZLSwipeableView.h"
#import "CardView.h"
#import "AppDelegate.h"
#import "ServerRequests.h"



@interface MatchsViewController : UIViewController
<ZLSwipeableViewDataSource,ZLSwipeableViewDelegate,ServerRequestProcessDelegate>

{
    AppDelegate *appD;
    
    
    IBOutlet UIButton *DashBtn;
    IBOutlet UIView *HiddenView;
    IBOutlet UIView *drawView,*subview1,*subview2,*subview3;
    
    
    
    NSMutableArray     *aray;
    NSMutableDictionary *likeDict;
    NSString    *page;
    NSString    *InTErID;
    NSString    *serverCalling;

}



@property (nonatomic, weak) IBOutlet ZLSwipeableView *swipeableView;
@property (nonatomic, strong) NSMutableArray  *Mysuggestions;
@property NSUInteger count;


@end
