//
//  LeftSideViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerRequests.h"


@interface LeftSideViewController : UIViewController<ServerRequestProcessDelegate>
{
    
    
  IBOutlet UILabel *megCountLabel;
  IBOutlet UIView *megCountView;
    
}
@end
