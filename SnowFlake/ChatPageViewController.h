//
//  ChatPageViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/22/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"
#import "HPGrowingTextView.h"
#import "UIImageView+WebCache.h"
#import "ServerRequests.h"
#import "ARKLoader.h"
#import "AppDelegate.h"


@interface ChatPageViewController : UIViewController
<SocketIODelegate,HPGrowingTextViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,ServerRequestProcessDelegate>
{
    
     AppDelegate *appD;
     SocketIO *socketIO;
    
    IBOutlet UILabel *CHATIDNAME;
    IBOutlet UILabel *NoConversn;
    
    IBOutlet UIImageView *CHATIDIMAGE;
    
    HPGrowingTextView *textView;
    NSString *messageStr,*hide,*chat;
    NSArray *chatArray;
    NSString  *userId;
    UIView *containerView;
    
    
    
    
}



@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *tableArray;
@property (strong, nonatomic) NSString  *ChatingId;
@property (strong, nonatomic) NSMutableDictionary  *ChatingDETAILS;
@end
