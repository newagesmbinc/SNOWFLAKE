//
//  LocalResortViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 11/5/15.
//  Copyright © 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ServerRequests.h"

@interface LocalResortViewController : UIViewController<ServerRequestProcessDelegate>
{
    AppDelegate *appD;
    
    IBOutlet UIButton *DashBtn;
    
    IBOutlet UIView *noResult;
    
    NSMutableArray *serverData;
    NSInteger rowselect;

}
@property (strong, nonatomic) IBOutlet UITableView *InboxTable;
@end
