//
//  ConfirmViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Registration.h"
#import "AppDelegate.h"


@interface ConfirmViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,UINavigationControllerDelegate,RegistrationProcess>
{
    IBOutlet UIImageView *fbProfilePic;
    
     IBOutlet UILabel *nameLbl;
    IBOutlet UILabel *emailLbl;
    IBOutlet UILabel *locationLbl;
    IBOutlet UILabel *dobLbl;
    IBOutlet UILabel *GenderLbl;
    IBOutlet UITextField *GenderTxt;
    
    IBOutlet UITextField *nameTxt;
    IBOutlet UITextField *emailTxt;
    IBOutlet UITextField *locationTxt;
    IBOutlet UITextField *dobTxt;
    IBOutlet UIView *EditView;
    AppDelegate *appD;
    IBOutlet UIView *HiddenView;
    
    IBOutlet UIView *dateView;
    IBOutlet UIDatePicker *datePicker;
    
    NSString * date_String6;
    
    NSString *savestring;
    
     UIImagePickerController *imagePicker;
    CGRect frame;
    CGRect frame1;
    CGRect screenRect;
    
    NSData *imageData;
}
@end
