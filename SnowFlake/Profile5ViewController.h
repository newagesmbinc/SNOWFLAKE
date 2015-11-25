//
//  Profile5ViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ServerRequests.h"

@interface Profile5ViewController : UIViewController<ServerRequestProcessDelegate>
{
 
    AppDelegate *appD;
  
    NSMutableArray *dataMount;
    NSMutableArray *MuntValue;
    
    
    
    NSString *value1;
    NSString *value2;
    NSString *value3;
    NSString *value4;
    NSString *value5;
    NSString *value6;
    
    
    
    IBOutlet UIImageView *radioPic1;
    IBOutlet UIImageView *radioPic2;
    IBOutlet UIImageView *radioPic3;
    IBOutlet UIImageView *radioPic4;
    IBOutlet UIImageView *radioPic5;
    IBOutlet UIImageView *radioPic6;
    IBOutlet UIImageView *fbProfilePic;
    
    IBOutlet UILabel *serverDataLbl1;
    IBOutlet UILabel *serverDataLbl2;
    IBOutlet UILabel *serverDataLbl3;
    IBOutlet UILabel *nameLbl;
    IBOutlet UILabel *serverDataLbl4;
    IBOutlet UILabel *serverDataLbl5;
    IBOutlet UILabel *serverDataLbl6;
    
    
    
    
    
    
    
    
    
}
@end
