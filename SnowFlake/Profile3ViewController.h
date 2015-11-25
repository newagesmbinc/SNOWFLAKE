//
//  Profile3ViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface Profile3ViewController : UIViewController
{

    AppDelegate *appD;
    
    NSMutableArray *dataMount;
    NSMutableDictionary *MuntValue;
    NSString *value;
    
    IBOutlet UIImageView *fbProfilePic;
    IBOutlet UIImageView *radioPic1;
    IBOutlet UIImageView *radioPic2;
    IBOutlet UIImageView *radioPic3;
    
    IBOutlet UILabel *nameLbl;
    IBOutlet UILabel *serverDataLbl1;
    IBOutlet UILabel *serverDataLbl2;
    IBOutlet UILabel *serverDataLbl3;
    
}
@end
