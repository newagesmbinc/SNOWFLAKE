//
//  EditMyAcntViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/12/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerRequests.h"
#import "AppDelegate.h"

@interface EditMyAcntViewController : UIViewController<ServerRequestProcessDelegate>
{
 
    AppDelegate *appD;
    
    IBOutlet UIView *dateView;
    IBOutlet UIDatePicker *datePicker;
    
    NSArray *genderArray;
    
    
}




@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *dob;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *marital;
@property (weak, nonatomic) IBOutlet UITableView *genderTable;


@end
