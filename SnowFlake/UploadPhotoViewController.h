//
//  UploadPhotoViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/19/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Registration.h"
#import "AppDelegate.h"
#import "ServerRequests.h"

@interface UploadPhotoViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,UINavigationControllerDelegate,RegistrationProcess,ServerRequestProcessDelegate>
{
    AppDelegate *appDelegate;
    
    IBOutlet UIButton *addImage1;
    IBOutlet UIButton *addImage2;
    IBOutlet UIButton *addImage3;
    IBOutlet UIButton *addImage4;
    IBOutlet UIButton *editImage1;
    IBOutlet UIButton *editImage2;
    IBOutlet UIButton *editImage3;
    IBOutlet UIButton *editImage4;

    IBOutlet UIImageView *photo;
    IBOutlet UIImageView *photo1;
    IBOutlet UIImageView *photo2;
    IBOutlet UIImageView *photo3;
    IBOutlet UIImageView *photo4;
    
    UIActionSheet  *photoselect1;
    UIActionSheet  *photoselect;
    
    UIImagePickerController *imagePicker;
    
    NSData *imageData;
    NSData *imageData1;
    NSData *imageData2;
    NSData *imageData3;
    NSData *imageData4;
    
    NSString *IdetfyPhoto;

}
- (IBAction)back:(id)sender;
- (IBAction)savePhoto:(id)sender;
- (IBAction)EditMainPhoto:(id)sender;
- (IBAction)addPhoto1:(id)sender;
- (IBAction)addPhoto2:(id)sender;
- (IBAction)addPhoto3:(id)sender;
- (IBAction)addPhoto4:(id)sender;
- (IBAction)editPhoto1:(id)sender;
- (IBAction)editPhoto2:(id)sender;
- (IBAction)editPhoto3:(id)sender;
- (IBAction)editPhoto4:(id)sender;

@property(strong,nonatomic) NSMutableArray *imageArry;

@end
