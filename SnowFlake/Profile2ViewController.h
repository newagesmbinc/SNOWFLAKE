//
//  Profile2ViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface Profile2ViewController : UIViewController
{
    IBOutlet UIImageView *fbProfilePic;
    AppDelegate *appD;
    IBOutlet UILabel *nameLbl;
    NSMutableArray *dataMount;
    NSMutableDictionary *MuntValue;
    NSString *value;
    
    
IBOutlet UIImageView *radioPic1;
IBOutlet UIImageView *radioPic2;
IBOutlet UIImageView *radioPic3;
    
    IBOutlet UILabel *serverDataLbl1;
    IBOutlet UILabel *serverDataLbl2;
    IBOutlet UILabel *serverDataLbl3;
    


}
@end
