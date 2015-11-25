//
//  UploadPhotoViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/19/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "UploadPhotoViewController.h"
#import "SCLAlertView.h"
#import "JSON.h"
#import "UIImageView+WebCache.h"
#import "ARKLoader.h"

@interface UploadPhotoViewController ()
{
    ARKLoader *ark;
}
@end

@implementation UploadPhotoViewController

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
     appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    int count=[_imageArry count];
    
    NSLog(@"%@",_imageArry);
    if (count==1) {
    
    [photo sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:0]] placeholderImage:nil];
        
        editImage1.hidden=YES;
        editImage2.hidden=YES;
        editImage3.hidden=YES;
        editImage4.hidden=YES;
        imageData= UIImagePNGRepresentation(photo.image);
    
    }if (count==2) {
        
        
        [photo sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:0]] placeholderImage:nil];
        
        editImage1.hidden=YES;
        editImage2.hidden=YES;
        editImage3.hidden=YES;
        editImage4.hidden=YES;

        imageData= UIImagePNGRepresentation(photo.image);
        
        editImage1.hidden=NO;
        editImage2.hidden=YES;
        editImage3.hidden=YES;
        editImage4.hidden=YES;
        addImage1.hidden=YES;
        
        [photo1 sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:1]] placeholderImage:nil];
    

        imageData1= UIImagePNGRepresentation(photo1.image);
    
    
    
    }
      if (count==3) {
          
          [photo sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:0]] placeholderImage:nil];
          
          editImage1.hidden=YES;
          editImage2.hidden=YES;
          editImage3.hidden=YES;
          editImage4.hidden=YES;
          imageData= UIImagePNGRepresentation(photo.image);
          
          editImage1.hidden=NO;
          editImage2.hidden=YES;
          editImage3.hidden=YES;
          editImage4.hidden=YES;
          addImage1.hidden=YES;
          
          [photo1 sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:1]] placeholderImage:nil];
          

          imageData1= UIImagePNGRepresentation(photo1.image);
          editImage2.hidden=NO;
          editImage3.hidden=YES;
          editImage4.hidden=YES;
          addImage2.hidden=YES;
          
          
          
          
          [photo2 sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:2]] placeholderImage:nil];
          

          imageData2= UIImagePNGRepresentation(photo2.image);
          
          
          
          
      }
    
      if (count==4) {
          
          [photo sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:0]] placeholderImage:nil];
          
          editImage1.hidden=YES;
          editImage2.hidden=YES;
          editImage3.hidden=YES;
          editImage4.hidden=YES;
          imageData= UIImagePNGRepresentation(photo.image);
          
          editImage1.hidden=NO;
          editImage2.hidden=YES;
          editImage3.hidden=YES;
          editImage4.hidden=YES;
          addImage1.hidden=YES;
          
          [photo1 sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:1]] placeholderImage:nil];
          

          imageData1= UIImagePNGRepresentation(photo1.image);
          editImage2.hidden=NO;
          editImage3.hidden=YES;
          editImage4.hidden=YES;
          addImage2.hidden=YES;
          
          
          
          
          [photo2 sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:2]] placeholderImage:nil];
 
          imageData2= UIImagePNGRepresentation(photo2.image);
          editImage3.hidden=NO;
          editImage4.hidden=YES;
          addImage3.hidden=YES;
          
          
          
          
          
          [photo3 sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:3]] placeholderImage:nil];

          imageData3= UIImagePNGRepresentation(photo3.image);
      
      
      }
    if (count==5) {
        [photo sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:0]] placeholderImage:nil];
        
        editImage1.hidden=YES;
        editImage2.hidden=YES;
        editImage3.hidden=YES;
        editImage4.hidden=YES;
        photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_imageArry objectAtIndex:0]]]];
        imageData= UIImagePNGRepresentation(photo.image);
        
        editImage1.hidden=NO;
        editImage2.hidden=YES;
        editImage3.hidden=YES;
        editImage4.hidden=YES;
        addImage1.hidden=YES;
        
        [photo1 sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:1]] placeholderImage:nil];

        imageData1= UIImagePNGRepresentation(photo1.image);
        editImage2.hidden=NO;
        editImage3.hidden=YES;
        editImage4.hidden=YES;
        addImage2.hidden=YES;
        
        
        
        
        [photo2 sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:2]] placeholderImage:nil];
        
        imageData2= UIImagePNGRepresentation(photo2.image);
        editImage3.hidden=NO;
        editImage4.hidden=YES;
        addImage3.hidden=YES;
        
        
        
        
        
        [photo3 sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:3]] placeholderImage:nil];
        

        imageData3= UIImagePNGRepresentation(photo3.image);
        editImage4.hidden=NO;
 
        addImage4.hidden=YES;
        
        
        [photo4 sd_setImageWithURL:[NSURL URLWithString:[_imageArry objectAtIndex:4]] placeholderImage:nil];
    
        imageData4= UIImagePNGRepresentation(photo4.image);
    
    
    
    }
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

#pragma mark - Button Action

- (IBAction)savePhoto:(id)sender {

    
    
    
}
-(void)uploadImages{
    
    // image.finalImage - is image itself
    // totalCount - Total number of images need to upload on server
    Registration *reg = [[Registration alloc] init];
    reg.reg_proces = self;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    reg.user_id=[standardUserDefaults objectForKey:@"user_id"];
    NSLog(@"%@",appDelegate.addCount);
    
    
    
   if([appDelegate.addCount isEqual:@"1"]){
   
       if (!imageData || imageData == nil || [imageData  isEqual: @""]) {
           imageData = [NSData dataWithData:imageData];
       }
       
       [reg upload_photoes:[NSDictionary dictionaryWithObjectsAndKeys:@"pic1.jpg",@"filename", nil] file:imageData];
   }
    else if([appDelegate.addCount isEqual:@"2"]){
    
        if (!imageData1 || imageData1 == nil || [imageData1  isEqual: @""]) {
            imageData1 = [NSData dataWithData:imageData1];
        }
        
        [reg upload_photoes:[NSDictionary dictionaryWithObjectsAndKeys:@"pic1.jpg",@"filename", nil] file:imageData1];
    
    }
       else if([appDelegate.addCount isEqual:@"3"]){
       
           if (!imageData2 || imageData2 == nil || [imageData2  isEqual: @""]) {
               imageData2 = [NSData dataWithData:imageData2];
           }
           
           [reg upload_photoes:[NSDictionary dictionaryWithObjectsAndKeys:@"pic1.jpg",@"filename", nil] file:imageData2];
       
       }
       else if([appDelegate.addCount isEqual:@"4"]){
       
           if (!imageData3 || imageData3 == nil || [imageData3  isEqual: @""]) {
               imageData3 = [NSData dataWithData:imageData3];
           }
           
           [reg upload_photoes:[NSDictionary dictionaryWithObjectsAndKeys:@"pic1.jpg",@"filename", nil] file:imageData3];
       }
       else if([appDelegate.addCount isEqual:@"5"]){
       
           if (!imageData4 || imageData4 == nil || [imageData4  isEqual: @""]) {
               imageData4 = [NSData dataWithData:imageData4];
           }
           
           [reg upload_photoes:[NSDictionary dictionaryWithObjectsAndKeys:@"pic1.jpg",@"filename", nil] file:imageData4];
       
       
       
       }
    
  


}



- (IBAction)EditMainPhoto:(id)sender {
    IdetfyPhoto=@"MainPhoto";
    
    appDelegate.addCount=@"1";
   photoselect=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Select Photo", nil ];
    photoselect.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    
    [photoselect showInView:self.view];
    
}

- (IBAction)addPhoto1:(id)sender {
    IdetfyPhoto=@"AddPhoto1";
    appDelegate.addCount=@"2";
  photoselect=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Select Photo", nil ];
    photoselect.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    
    [photoselect showInView:self.view];
    
    
}
- (IBAction)editPhoto1:(id)sender {
    
    IdetfyPhoto=@"EditPhoto1";
    appDelegate.addCount=@"2";
    photoselect1=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Select Photo",@"Remove Photo", nil ];
    photoselect1.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    
    [photoselect1 showInView:self.view];
    
    
    
    
    
    
}
- (IBAction)editPhoto2:(id)sender {
    
    IdetfyPhoto=@"EditPhoto2";
    appDelegate.addCount=@"3";    photoselect1=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Select Photo",@"Remove Photo", nil ];
    photoselect1.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    
    [photoselect1 showInView:self.view];
}
- (IBAction)editPhoto3:(id)sender {
    
    IdetfyPhoto=@"EditPhoto3";
    appDelegate.addCount=@"4";    photoselect1=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Select Photo",@"Remove Photo", nil ];
    photoselect1.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    
    [photoselect1 showInView:self.view];
    
    
}
- (IBAction)editPhoto4:(id)sender {
    IdetfyPhoto=@"EditPhoto4";
    
    appDelegate.addCount=@"5";    photoselect1=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Select Photo",@"Remove Photo", nil ];
    photoselect1.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    
    [photoselect1 showInView:self.view];
    
    
}
- (IBAction)addPhoto2:(id)sender {
      IdetfyPhoto=@"AddPhoto2";
    appDelegate.addCount=@"3";
    photoselect=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Select Photo", nil ];
    photoselect.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    
    [photoselect showInView:self.view];
}
- (IBAction)addPhoto3:(id)sender {
    
      IdetfyPhoto=@"AddPhoto3";
    
    appDelegate.addCount=@"4";    photoselect=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Select Photo", nil ];
    photoselect.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    
    [photoselect showInView:self.view];
    
}
- (IBAction)addPhoto4:(id)sender {
    
      IdetfyPhoto=@"AddPhoto4";
    appDelegate.addCount=@"5";
    photoselect=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Select Photo", nil ];
    photoselect.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    
    [photoselect showInView:self.view];
    
    
    
}


#pragma mark - Action Sheet



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet==photoselect1) {
    
    
    
    if(buttonIndex == 0)
    {
        [self takePhoto];
    }
    if(buttonIndex == 1)
    {
        [self selectPhoto];
    }
    if(buttonIndex == 2)
    {
        [self removePhoto];
    }
    }else{
        
        if(buttonIndex == 0)
        {
            [self takePhoto];
        }
        if(buttonIndex == 1)
        {
            [self selectPhoto];
        }
    }
    
}


-(void)takePhoto
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


#pragma mark - Server Call


-(void)removePhoto{
    
    NSString *postData;
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [self startLoader];
    if([IdetfyPhoto isEqual:@"EditPhoto1"]){
        
   
    
   postData =[[NSString alloc] initWithFormat:@"{\"function\":\"remove_image\", \"parameters\": {\"user_id\": \"%@\",\"image1\": \"%@\"},\"token\":\"\"}", [standardUserDefaults objectForKey:@"user_id"],@""];
    NSLog(@"post------%@",postData);
        
    }
    if([IdetfyPhoto isEqual:@"EditPhoto2"]){
      
        
        
        postData =[[NSString alloc] initWithFormat:@"{\"function\":\"remove_image\", \"parameters\": {\"user_id\": \"%@\",\"image2\": \"%@\"},\"token\":\"\"}", [standardUserDefaults objectForKey:@"user_id"],@""];
        NSLog(@"post------%@",postData);
        
    }
    if([IdetfyPhoto isEqual:@"EditPhoto3"]){
   
        
        
        postData =[[NSString alloc] initWithFormat:@"{\"function\":\"remove_image\", \"parameters\": {\"user_id\": \"%@\",\"image3\": \"%@\"},\"token\":\"\"}", [standardUserDefaults objectForKey:@"user_id"],@""];
        NSLog(@"post------%@",postData);
        
    }
    if([IdetfyPhoto isEqual:@"EditPhoto4"]){
       
        
        
        postData =[[NSString alloc] initWithFormat:@"{\"function\":\"remove_image\", \"parameters\": {\"user_id\": \"%@\",\"image4\": \"%@\"},\"token\":\"\"}", [standardUserDefaults objectForKey:@"user_id"],@""];
        NSLog(@"post------%@",postData);
        
    }
    
    
    
    [server sendServerRequests:postData];
    
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


#pragma mark - ServerResponse



-(void)ServerRequestProcessFinish:(NSString *)serverResponse
{
    
     [self stopLoader];
    
    if ([serverResponse isEqualToString:@"ERROR"]) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showInfo:self title:@"Connection error"
                subTitle:@"Cannot connect with server. Please try again later."
        closeButtonTitle:@"OK" duration:0.0f];
        
        
    }else{
      
        NSData *data=[serverResponse dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSError *er;
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&er];
        NSLog(@"messageArray------%@",dict);
        
        
        
        if ([[dict objectForKey:@"status"]isEqualToString:@"true"]) {
            
            
            [appDelegate.ServerData removeObjectForKey:@"image_gallery"];
            [appDelegate.ServerData setObject:[dict objectForKey:@"image_gallery"] forKey:@"image_gallery"];
            
            if([IdetfyPhoto isEqual:@"EditPhoto4"]){
                editImage4.hidden=YES;
                
                addImage4.hidden=NO;
            
                [photo4 sd_setImageWithURL:[NSURL URLWithString:nil] placeholderImage:nil];
              
                imageData4= UIImagePNGRepresentation(photo4.image);
                
                
                
                
            
            }
            
            if([IdetfyPhoto isEqual:@"EditPhoto3"]){
                editImage3.hidden=YES;
                
                addImage3.hidden=NO;
                [photo3 sd_setImageWithURL:[NSURL URLWithString:nil] placeholderImage:nil];
               
                imageData3= UIImagePNGRepresentation(photo3.image);
            }
            
            if([IdetfyPhoto isEqual:@"EditPhoto2"]){
                editImage2.hidden=YES;
                
                addImage2.hidden=NO;
            
                [photo2 sd_setImageWithURL:[NSURL URLWithString:nil] placeholderImage:nil];
             
                imageData2= UIImagePNGRepresentation(photo2.image);
            }
            
            if([IdetfyPhoto isEqual:@"EditPhoto1"]){
                editImage1.hidden=YES;
                
                addImage1.hidden=NO;
            
                [photo1 sd_setImageWithURL:[NSURL URLWithString:nil] placeholderImage:nil];
               
                imageData1= UIImagePNGRepresentation(photo1.image);
            
            }
            
            
        }
        
        
        else{
            
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            
            [alert showInfo:self title:@"Message"
                    subTitle:[dict valueForKey:@"message"]
            closeButtonTitle:@"OK" duration:0.0f];
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
    }
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
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    
    if ([IdetfyPhoto isEqual:@"MainPhoto"]) {
  
    
    imageData=UIImageJPEGRepresentation([self scaleAndRotateImage:image], 0.5);
        
        photo.image = image;
        
        
        
    }else if([IdetfyPhoto isEqual:@"AddPhoto1"]||[IdetfyPhoto isEqual:@"EditPhoto1"])
    
    {
        if([IdetfyPhoto isEqual:@"AddPhoto1"]){
            editImage1.hidden=NO;
           
            addImage1.hidden=YES;
        }
        
      imageData1=UIImageJPEGRepresentation([self scaleAndRotateImage:image], 0.5);
        photo1.image = image;
        
    }
    else if([IdetfyPhoto isEqual:@"AddPhoto2"]||[IdetfyPhoto isEqual:@"EditPhoto2"])
        
    {
        if([IdetfyPhoto isEqual:@"AddPhoto2"]){
            editImage2.hidden=NO;
            
            addImage2.hidden=YES;
        }
        
        
        imageData2=UIImageJPEGRepresentation([self scaleAndRotateImage:image], 0.5);
        
        photo2.image = image;
        
    }
    else if([IdetfyPhoto isEqual:@"AddPhoto3"]||[IdetfyPhoto isEqual:@"EditPhoto3"])
        
    {
        
        if([IdetfyPhoto isEqual:@"AddPhoto3"]){
            editImage3.hidden=NO;
            
            addImage3.hidden=YES;
        }
        
        
        imageData3=UIImageJPEGRepresentation([self scaleAndRotateImage:image], 0.5);
        photo3.image = image;
        
    }
    
    else if([IdetfyPhoto isEqual:@"AddPhoto4"]||[IdetfyPhoto isEqual:@"EditPhoto4"])
        
    {
        if([IdetfyPhoto isEqual:@"AddPhoto4"]){
            editImage4.hidden=NO;
            
            addImage4.hidden=YES;
        }
        
        
        imageData4=UIImageJPEGRepresentation([self scaleAndRotateImage:image], 0.5);
        photo4.image = image;
        
    }
    [self uploadImages];
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



-(void) RegistrationProcessFinish:(NSString *) userdetails{
    
    
    
    
    NSDictionary *responseDetails = [userdetails JSONValue];
    NSLog(@"responseDetails---%@",responseDetails);
    
    [self stopLoader];
    if ([[responseDetails objectForKey:@"status"]isEqual:@"true"]) {
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
        [standardUserDefaults setObject:[responseDetails objectForKey:@"image"] forKey:@"pic"];
        
        [appDelegate.ServerData removeObjectForKey:@"image_gallery"];
        
           [appDelegate.ServerData removeObjectForKey:@"image"];
         [appDelegate.ServerData setObject:[responseDetails objectForKey:@"image"] forKey:@"image"];
        
        
        [appDelegate.ServerData setObject:[responseDetails objectForKey:@"image_gallery"] forKey:@"image_gallery"];
    }
    else{
        
        
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showInfo:self title:@"Message"
                subTitle:[responseDetails valueForKey:@"message"]
        closeButtonTitle:@"OK" duration:0.0f];
    }
    
    
    
    
    
}







@end
