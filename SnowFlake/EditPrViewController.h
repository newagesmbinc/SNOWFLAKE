//
//  EditPrViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/8/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ServerRequests.h"





@interface EditPrViewController : UIViewController<ServerRequestProcessDelegate>
{
      AppDelegate *appD;
   
    
    IBOutlet UIScrollView *MainSroll;
    
    IBOutlet UILabel *SelectLbl;
    IBOutlet UILabel *NameLbl;
    IBOutlet UILabel *HeadLbl;
    IBOutlet UILabel *skiserverDataLbl1;
    IBOutlet UILabel *skiserverDataLbl2;
    IBOutlet UILabel *skiserverDataLbl3;
    IBOutlet UILabel *sserverDataLbl1;
    IBOutlet UILabel *sserverDataLbl2;
    IBOutlet UILabel *sserverDataLbl3;
    IBOutlet UILabel *serverDataLbl1;
    IBOutlet UILabel *serverDataLbl2;
    IBOutlet UILabel *serverDataLbl3;
    IBOutlet UILabel *serverDataLbl4;
    IBOutlet UILabel *serverDataLbl5;
    IBOutlet UILabel *serverDataLbl6;
    IBOutlet UILabel *fserverDataLbl1;
    IBOutlet UILabel *fserverDataLbl2;
    IBOutlet UILabel *fserverDataLbl3;
    IBOutlet UILabel *fserverDataLbl4;
    IBOutlet UILabel *fserverDataLbl5;
    IBOutlet UILabel *fserverDataLbl6;
    
    IBOutlet UIImageView *UserImage;
    IBOutlet UIImageView *skiradioPic1;
    IBOutlet UIImageView *skiradioPic2;
    IBOutlet UIImageView *skiradioPic3;
    IBOutlet UIImageView *sradioPic1;
    IBOutlet UIImageView *sradioPic2;
    IBOutlet UIImageView *sradioPic3;
    IBOutlet UIImageView *fradioPic1;
    IBOutlet UIImageView *fradioPic2;
    IBOutlet UIImageView *fradioPic3;
    IBOutlet UIImageView *fradioPic4;
    IBOutlet UIImageView *fradioPic5;
    IBOutlet UIImageView *fradioPic6;
    IBOutlet UIImageView *radioPic1;
    IBOutlet UIImageView *radioPic2;
    IBOutlet UIImageView *radioPic3;
    IBOutlet UIImageView *radioPic4;
    IBOutlet UIImageView *radioPic5;
    IBOutlet UIImageView *radioPic6;
    
    NSString *skivalue;
    NSString *svalue;
    NSString *serverCall;
    NSString *fvalue1;
    NSString *fvalue2;
    NSString *fvalue3;
    NSString *fvalue4;
    NSString *fvalue5;
    NSString *fvalue6;
    NSString *value1;
    NSString *value2;
    NSString *value3;
    NSString *value4;
    NSString *value5;
    NSString *value6;
   
    NSMutableDictionary *serverCalldata;
    NSMutableArray *MuntValue;
    NSMutableArray *MuntValue1;
    NSMutableArray   *focusArry;
    NSMutableArray   *areaArry;
    
    
    
    
}


- (IBAction)editPhoto:(id)sender;





@end
