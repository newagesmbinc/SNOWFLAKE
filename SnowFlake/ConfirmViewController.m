//
//  ConfirmViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "ConfirmViewController.h"
#import "UIImageView+WebCache.h"
#import "SCLAlertView.h"
#import "JSON.h"
#import "Profile1ViewController.h"
#import "ARKLoader.h"
#import "ExploreViewController.h"



@interface ConfirmViewController ()
{
    ARKLoader *ark;
}
@end


@implementation ConfirmViewController

#pragma Loader

-(void)startLoader

{
 
    
    if (!ark) {
        
        ark =[[ARKLoader alloc]init];
        [ark showLoader];
        
    }
    
    
    
}

-(void)stopLoader

{
    [ark removeLoader];
    
    ark = nil;
    
}
#pragma System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    
    fbProfilePic.clipsToBounds = YES;
    fbProfilePic.layer.cornerRadius=fbProfilePic.frame.size.width/2;
      screenRect = [[UIScreen mainScreen] bounds];
 
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
     appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"%@",[standardUserDefaults objectForKey:@"pic"]);
    
   fbProfilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[standardUserDefaults objectForKey:@"pic"]]]];
    imageData= UIImagePNGRepresentation(fbProfilePic.image);
    
    UIColor *color = [UIColor blackColor];
    nameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    emailTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    
    locationTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Location" attributes:@{NSForegroundColorAttributeName: color}];
    dobTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Age" attributes:@{NSForegroundColorAttributeName: color}];
     GenderTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Gender" attributes:@{NSForegroundColorAttributeName: color}];
    
     dateView.hidden = YES;
  
   frame1 = EditView.frame;
 
     screenRect = [[UIScreen mainScreen] bounds];
    
   
    

   
    NSDate *currentDate = [NSDate date];
       
   
    
    [datePicker setMaximumDate:currentDate];
 
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSLog(@"%@",[standardUserDefaults objectForKey:@"birthday"]);
    
    NSDate *date = [dateFormatter dateFromString:[standardUserDefaults objectForKey:@"birthday"]];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    
    
    
    
    
    
   date_String6 = [dateFormatter stringFromDate:date];
    nameTxt.text=[standardUserDefaults objectForKey:@"name"];
    emailTxt.text= [standardUserDefaults objectForKey:@"email"];
    dobTxt.text=date_String6;
    
    if (date_String6.length>0) {
    
   
    dobTxt.text=[NSString stringWithFormat:@"%ld",(long)[self ageFromBirthday:date]];
    
    }
    
     GenderTxt.text=[standardUserDefaults objectForKey:@"gender"];
    
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
     EditView.frame=frame1;
     NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
     locationTxt.text=[standardUserDefaults objectForKey:@"location"];
    
    
    
    
    
    
    [self endAnimation];
    HiddenView.hidden=YES;
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  Textfield

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

   
    
    
    
       [textField resignFirstResponder];
    if (textField==nameTxt ) {
        
      
        
        [emailTxt becomeFirstResponder];
    }
    if (textField==emailTxt ) {
        
        [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            
            
            
            CGFloat screenHeight = screenRect.size.height;
            if (screenHeight<500) {
                EditView.frame=CGRectMake(0,220, EditView.frame.size.width, EditView.frame.size.height);         }
            
            else if (screenHeight<570&&screenHeight>500)
            {
                
                EditView.frame=CGRectMake(0,290, EditView.frame.size.width, EditView.frame.size.height);
            }
            
            
            
            else if (screenHeight>670)
                
            {
                
                EditView.frame=CGRectMake(0,400, EditView.frame.size.width, EditView.frame.size.height);
                
            }else{
                EditView.frame=CGRectMake(0,350, EditView.frame.size.width, EditView.frame.size.height);         }
            
            
            
        } completion:^(BOOL finished)
         {
             HiddenView.hidden=YES;
         }];

        
    }
    if (textField==locationTxt ) {
        
        

    }
    
    if (textField==dobTxt ) {
        
        
        [GenderTxt becomeFirstResponder];
    }
    
    
    
    return NO;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    HiddenView.hidden=NO;
    
    if ([textField isEqual:dobTxt]) {
        
        dateView.hidden=NO;
        NSDate *selectedDate = [datePicker date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
         NSString *currentTime = [dateFormatter stringFromDate:selectedDate];

        
        
        
        
       
        
        
        dobTxt.text= currentTime;
        
        date_String6=currentTime;
                savestring=dobTxt.text;
        
        dobTxt.text=[NSString stringWithFormat:@"%ld",(long)[self ageFromBirthday:selectedDate]];
        
        
        
        
        
        [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            EditView.frame=CGRectMake(0,((self.view.frame.size.height/2)-(EditView.frame.size.height/2)-70), EditView.frame.size.width, EditView.frame.size.height);
            
            
        } completion:^(BOOL finished)
         {
             
         }];
        
 return NO;
        
    }

    else if ([textField isEqual:nameTxt]) {
        savestring=nameTxt.text;
        
        
    }
    
    else if ([textField isEqual:GenderTxt]) {
        
        savestring=GenderTxt.text;
    }
    
    else if ([textField isEqual:emailTxt]) {
        
        savestring=emailTxt.text;
    }
    
  
        [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            
            if (screenRect.size.height<500) {
                CGRectMake(0,((self.view.frame.size.height/2)-(EditView.frame.size.height/2)-80), EditView.frame.size.width, EditView.frame.size.height);         }
            
            
            EditView.frame=CGRectMake(0,((self.view.frame.size.height/2)-(EditView.frame.size.height/2)-70), EditView.frame.size.width, EditView.frame.size.height);
            
            
        } completion:^(BOOL finished)
         {
             
         }];
    
    
    
    
    
    
    
    
    
    return YES;
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    
    
    NSLog(@"%@",savestring);
    [textField resignFirstResponder];
    if ([textField isEqual:nameTxt]) {

        
        
    }
    
    else if ([textField isEqual:emailTxt]) {
        
        if (emailTxt.text.length>0) {
            
            
            if ([self validateEmail:[emailTxt text]]){

            }
            
            else{
                
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                
                [alert showInfo:self title:@"Invalid Email"
                        subTitle:@"Enter a valid Email"
                closeButtonTitle:@"OK" duration:0.0f];
                emailTxt.text=@"";
            }
            
        }
    }
    
    else if ([textField isEqual:emailTxt]) {
        
        [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            
            
            
            CGFloat screenHeight = screenRect.size.height;
            if (screenHeight<500) {
                EditView.frame=CGRectMake(0,220, EditView.frame.size.width, EditView.frame.size.height);         }
            
            else if (screenHeight<570&&screenHeight>500)
            {
                
                EditView.frame=CGRectMake(0,290, EditView.frame.size.width, EditView.frame.size.height);
            }
            
            
            
            else if (screenHeight>670)
                
            {
                
                EditView.frame=CGRectMake(0,400, EditView.frame.size.width, EditView.frame.size.height);
                
            }else{
                EditView.frame=CGRectMake(0,350, EditView.frame.size.width, EditView.frame.size.height);         }
            
            
            
        } completion:^(BOOL finished)
         {
             HiddenView.hidden=YES;
         }];
        
    }
    else if ([textField isEqual:dobTxt]) {
    
    }
    
    else if ([textField isEqual:GenderTxt]) {

        
        
        [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            
            
            
            CGFloat screenHeight = screenRect.size.height;
            if (screenHeight<500) {
                  EditView.frame=CGRectMake(0,220, EditView.frame.size.width, EditView.frame.size.height);         }
            
            else if (screenHeight<570&&screenHeight>500)
         {
         
              EditView.frame=CGRectMake(0,290, EditView.frame.size.width, EditView.frame.size.height);
         }
         
         
         
         else if (screenHeight>670)
                
            {
                
                EditView.frame=CGRectMake(0,400, EditView.frame.size.width, EditView.frame.size.height);
                
            }else{
                EditView.frame=CGRectMake(0,350, EditView.frame.size.width, EditView.frame.size.height);         }
            
            
            
        } completion:^(BOOL finished)
         {
             HiddenView.hidden=YES;
         }];
        
        
    }
    
    return YES;
}


- (NSInteger)ageFromBirthday:(NSDate *)birthdate {
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:birthdate
                                       toDate:today
                                       options:0];
    return ageComponents.year;
}









- (BOOL)validateEmail:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}


-(IBAction)dateDone:(id)sender{
    
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        
        
        
        CGFloat screenHeight = screenRect.size.height;
        if (screenHeight<500) {
            EditView.frame=CGRectMake(0,220, EditView.frame.size.width, EditView.frame.size.height);         }
        
        else if (screenHeight<570&&screenHeight>500)
        {
            
            EditView.frame=CGRectMake(0,290, EditView.frame.size.width, EditView.frame.size.height);
        }
        
        
        
        else if (screenHeight>670)
            
        {
            
            EditView.frame=CGRectMake(0,400, EditView.frame.size.width, EditView.frame.size.height);
            
        }else{
            EditView.frame=CGRectMake(0,350, EditView.frame.size.width, EditView.frame.size.height);         }
        
        
        
    } completion:^(BOOL finished)
     {
         HiddenView.hidden=YES;
     }];
    
    
    
    [dateView setHidden:YES];
}



-(IBAction)DateChanged:(id)sender{
    
    NSDate *selectedDate = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentTime = [dateFormatter stringFromDate:selectedDate];
    
    
    NSLog(@"date---%@",currentTime);

    
   
    
    
    dobTxt.text = [dateFormatter stringFromDate:selectedDate];
    
    
}



#pragma Button Action & Navigation


- (IBAction)Location_Action:(id)sender {

    ExploreViewController *reveal =(ExploreViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ExploreViewController"];
    reveal.frmMyacunt=@"Yes";
    [self.navigationController pushViewController:reveal animated:YES];

}

- (IBAction)Confirm_Action:(id)sender {
    

    
    Registration *reg = [[Registration alloc] init];
    reg.reg_proces = self;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    NSLog(@"%@",[standardUserDefaults objectForKey:@"fbId"]);
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    
    

    
    if(![[nameTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]){
        if(![[emailTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]){
            if(![[locationTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]){
                [self getLocationFromAddressString:locationTxt.text];
                
                
                
                
                
                
                if(![[GenderTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]){
                     if(![[dobTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]){
                         NSString *regProfilepic;
                         reg.profilepic=@"";
                         
                         if(appD.profilepicarray.count>0){
                             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:appD.profilepicarray options:0 error:nil];
                             
                             // Checking the format
                             NSLog(@"%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
                             regProfilepic=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                             reg.profilepic=regProfilepic;
                         }
                         
                         [self startLoader];
                         reg.firstName = nameTxt.text;
                         reg.email = emailTxt.text;
                         reg.location=locationTxt.text;
                         reg.gender = GenderTxt.text;
                         reg.lat=[standardUserDefaults objectForKey:@"lat"];
                          reg.log=[standardUserDefaults objectForKey:@"log"];
                         reg.dob = date_String6;
                         
                         reg.user_id=[standardUserDefaults objectForKey:@"user_id"];
                         reg.marital_status=@"Single";
                         
                         if (!imageData || imageData == nil || [imageData  isEqual: @""]) {
                             imageData = [NSData dataWithData:imageData];
                         }
                         
                         [reg confirm_profile:[NSDictionary dictionaryWithObjectsAndKeys:@"pic1.jpg",@"filename", nil] file:imageData];
                         
                         
                         
                         
                     }
                                               else{
                                                   [alert showInfo:self title:@""
                                                           subTitle:@"Please enter your Age,We need to know your age to get you better recommendation."
                                                   closeButtonTitle:@"OK" duration:0.0f];
                                                  
                        }
                        
    
                    }
                    else{
                        [alert showInfo:self title:@""
                                subTitle:@"Enter Gender"
                        closeButtonTitle:@"OK" duration:0.0f];                    }
                }
                else{
                    [alert showInfo:self title:@""
                            subTitle:@"Enter Location"
                    closeButtonTitle:@"OK" duration:0.0f];
                }
            }
            else{
                [alert showInfo:self title:@""
                        subTitle:@"Enter Email"
                closeButtonTitle:@"OK" duration:0.0f];
            }
        
            }
    else{
        [alert showInfo:self title:@""
                subTitle:@"Enter Name"
        closeButtonTitle:@"OK" duration:0.0f];
    }
    
    
    
    
    

    
}

-(void) getLocationFromAddressString:(NSString*) addressStr {
    
    
    double latitude1 , longitude1 ;
    //@autoreleasepool
    {
        
        NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
        NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
        if (result) {
            
            
            NSArray *jsonArry =[[result JSONValue]objectForKey:@"results"];
          
            NSDictionary *jsonDct =[jsonArry objectAtIndex:0];
            
            
            latitude1 = [[jsonDct valueForKeyPath:@"geometry.location.lat"] doubleValue];
            longitude1 = [[jsonDct valueForKeyPath:@"geometry.location.lng"] doubleValue];
            
        }
        
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude1;
    center.longitude = longitude1;
    
    NSString  *lat=[NSString stringWithFormat:@"%.8f", latitude1];
    NSString  *log=[NSString stringWithFormat:@"%.8f", longitude1];
   
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [standardUserDefaults setObject:lat forKey:@"lat"];
    [standardUserDefaults setObject:log forKey:@"log"];
  
    
}














-(void) RegistrationProcessFinish:(NSString *) userdetails{
    
 [self stopLoader];
    
    NSDictionary *responseDetails = [userdetails JSONValue];
    NSLog(@"responseDetails---%@",responseDetails);
    
    
    
    if ([[responseDetails objectForKey:@"status"]isEqual:@"true"]) {
                
        
        appD.ServerData=[responseDetails mutableCopy];
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
             [standardUserDefaults setObject:[responseDetails objectForKey:@"image"] forKey:@"pic"];
        
        [standardUserDefaults setObject:[responseDetails objectForKey:@"email"]forKey:@"email"];
        [standardUserDefaults setObject: [responseDetails objectForKey:@"dob"] forKey:@"birthday"];
        
        [standardUserDefaults setObject:[responseDetails objectForKey:@"name"] forKey:@"first_name"];
        [standardUserDefaults setObject:[responseDetails objectForKey:@"gender"] forKey:@"gender"];
        
        [standardUserDefaults setObject:[responseDetails objectForKey:@"location"] forKey:@"location"];
        [standardUserDefaults setObject:[responseDetails objectForKey:@"marital_status"] forKey:@"marital_status"];
        
        Profile1ViewController *reveal =(Profile1ViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"Profile1"];
        [self.navigationController pushViewController:reveal animated:YES];
        
        
    }
    else{
        
        
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showInfo:self title:@"Message"
                subTitle:[responseDetails valueForKey:@"message"]
        closeButtonTitle:@"OK" duration:0.0f];
    }
    
    
    
    
    
}














- (IBAction)imageChange:(id)sender {
    
    UIActionSheet  *photoselect1=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Select Photo", nil ];
    photoselect1.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    
    [photoselect1 showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self takePhoto];
    }
    if(buttonIndex == 1)
    {
        [self selectPhoto];
    }
}


-(void)takePhoto   // invoke camera in iPhone
{
    imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self performSelector: @selector(ShowModalTableViewController) withObject: nil afterDelay: 0];
        
    }
    
    else
    {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        alert.backgroundType = Blur;
        
        [alert showNotice:self title:@"Notice" subTitle:@"Sorry your device wont support" closeButtonTitle:@"Done" duration:0.0f];
        
        
        
    }
    
    
}
-(void) ShowModalTableViewController
{
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

-(void)selectPhoto  // to select photo from photo library
{
    imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    imagePicker.allowsEditing = YES;
    //imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    //imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum ;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    [self performSelector: @selector(ShowModalTableViewController) withObject: nil afterDelay: 0];
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    
    
    
    
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self endAnimation];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    imageData=UIImageJPEGRepresentation([self scaleAndRotateImage:image], 0.5);
    
    
    
    fbProfilePic.image = image;
    fbProfilePic.layer.cornerRadius=fbProfilePic.frame.size.width/2;;
    
    
    
    
}

- (UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}
-(void)endAnimation{
    
    
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        
        
        
        CGFloat screenHeight = screenRect.size.height;
        if (screenHeight<500) {
            EditView.frame=CGRectMake(0,220, EditView.frame.size.width, EditView.frame.size.height);         }
        
        else if (screenHeight<570&&screenHeight>500)
        {
            
            EditView.frame=CGRectMake(0,290, EditView.frame.size.width, EditView.frame.size.height);
        }
        
        
        
        else if (screenHeight>670)
            
        {
            
            EditView.frame=CGRectMake(0,400, EditView.frame.size.width, EditView.frame.size.height);
            
        }else{
            EditView.frame=CGRectMake(0,350, EditView.frame.size.width, EditView.frame.size.height);         }
        
        
        
    } completion:^(BOOL finished)
     {
         HiddenView.hidden=YES;
     }];
    
    
    
    
    
    
    
}


@end
