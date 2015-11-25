//
//  MMatchViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/21/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "ServerRequests.h"


@interface MMatchViewController : UIViewController<ServerRequestProcessDelegate>
{
    
    AppDelegate *appD;
    
    
    IBOutlet UIButton *DashBtn;
     NSMutableArray *serverData;
     NSMutableArray *megData;
   
}


@property (strong, nonatomic) IBOutlet UIView *noMatchView;
@property (strong, nonatomic) IBOutlet UITableView *table;
@end
