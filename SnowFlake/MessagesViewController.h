//
//  MessagesViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "ServerRequests.h"



@interface MessagesViewController : UIViewController<ServerRequestProcessDelegate>

{
    IBOutlet UIButton *DashBtn;
    
    NSMutableArray *serverData;    
    NSInteger rowselect;
}


@property (strong, nonatomic) IBOutlet UITableView *InboxTable;
@property (strong, nonatomic) IBOutlet UIView *noMatchView;

@end
