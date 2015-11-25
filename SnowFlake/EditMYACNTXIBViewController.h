//
//  EditMYACNTXIBViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/15/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerRequests.h"
#import "ARKLoader.h"
#import "AppDelegate.h"


@interface EditMYACNTXIBViewController : UIViewController<ServerRequestProcessDelegate>
{
    
    AppDelegate *appD;
    ARKLoader *ark;
    
    IBOutlet UIView *dateView;
    IBOutlet UIDatePicker *datePicker;
    
    NSArray *genderArray;
    
    
}




- (IBAction)getLocationMap:(id)sender;






@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *dob;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *marital;
@property (weak, nonatomic) IBOutlet UITableView *genderTable;


@end
