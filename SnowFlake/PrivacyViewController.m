//
//  PrivacyViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 11/10/15.
//  Copyright © 2015 NewAgeSMB. All rights reserved.
//

#import "PrivacyViewController.h"
#import "SCLAlertView.h"
#import "ARKLoader.h"


@interface PrivacyViewController ()
{
    ARKLoader *ark;
}
@end

@implementation PrivacyViewController
-(void)startLoader

{if (!ark) {
        
        ark =[[ARKLoader alloc]init];
        [ark showLoader];
        
    }
}

-(void)stopLoader

{
[ark removeLoader];
ark = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    float minimunrangeValue=0.016667;
    
    RangeSlider.minimumValue = 0.3;
    RangeSlider.minimumRange=minimunrangeValue;
    RangeSlider.upperValue =1.0;
    RangeSlider.continuous = YES;
    RangeSlider.lowerValue =0.3;
    str=@"";
    
    float lowerrangeValue=[[standardUserDefaults  objectForKey:@"privacy_age_from"]floatValue]*minimunrangeValue;
    float upperrangeValue=[[standardUserDefaults  objectForKey:@"privacy_age_to"]floatValue]*minimunrangeValue;
    
    RangeSlider.upperValue =upperrangeValue;
    RangeSlider.lowerValue =lowerrangeValue;
   
    
    UIImage *buttonOff = [UIImage imageNamed:@"graychecknorm.png"];
    UIImage *buttonOn = [UIImage imageNamed:@"graycheckactive.png"];
    
    str=[standardUserDefaults objectForKey:@"privacy_gender"];
    if ([[standardUserDefaults objectForKey:@"age"] integerValue]<18) {AgeView.hidden=YES;}
    if ([[standardUserDefaults objectForKey:@"privacy_gender"] isEqualToString:@"All"]) {
        
        male=@"YES";
        female=@"YES";
        [maleBtn setImage:buttonOn forState:UIControlStateNormal];
        [femaleBtn setImage:buttonOn forState:UIControlStateNormal];
    }
    else if ([[standardUserDefaults objectForKey:@"privacy_gender"] isEqualToString:@"Male"])
    {
        female=@"NO";
        male=@"YES";
        [maleBtn setImage:buttonOn forState:UIControlStateNormal];
        [femaleBtn setImage:buttonOff forState:UIControlStateNormal];
        
        
    }
    else{
        female=@"YES";
        male=@"NO";
        
        [maleBtn setImage:buttonOff forState:UIControlStateNormal];
        [femaleBtn setImage:buttonOn forState:UIControlStateNormal];
        
        }

    
    sliderAgeValue.text=[NSString stringWithFormat:@"%@-%@",[standardUserDefaults  objectForKey:@"privacy_age_from"],[standardUserDefaults  objectForKey:@"privacy_age_to"]];
    
    
    Str1=[standardUserDefaults  objectForKey:@"privacy_age_from"];
    Str2=[standardUserDefaults  objectForKey:@"privacy_age_to"];
    
    
    [RangeSlider addTarget:self action:@selector(sliderAction1:) forControlEvents:UIControlEventValueChanged];    
    

}

- (IBAction)sliderAction1:(id)sender{
    
    float upper=  RangeSlider.upperValue*60;
    
    float lower=  RangeSlider.lowerValue*60;
    
    Str2=[NSString stringWithFormat:@"%.0f",upper];
    Str1=[NSString stringWithFormat:@"%.0f",lower];
    
    sliderAgeValue.text=[NSString stringWithFormat:@"%@-%@",Str1,Str2];
 
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(IBAction)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)femaleAction:(id)sender {
    UIImage *buttonOff = [UIImage imageNamed:@"graychecknorm.png"];
    UIImage *buttonOn = [UIImage imageNamed:@"graycheckactive.png"];
    
    
    
    if ([ female isEqualToString:@"YES"]) {
        female=@"NO";
        [femaleBtn setImage:buttonOff forState:UIControlStateNormal];
        
    }else{
        female=@"YES";
        [femaleBtn setImage:buttonOn forState:UIControlStateNormal];    }

}

- (IBAction)maleAction:(id)sender {
    
    UIImage *buttonOff = [UIImage imageNamed:@"graychecknorm.png"];
    UIImage *buttonOn = [UIImage imageNamed:@"graycheckactive.png"];
    
    
    
    if ([ male isEqualToString:@"YES"]) {
        male=@"NO";
        [maleBtn setImage:buttonOff forState:UIControlStateNormal];
        
    }else{
        male=@"YES";
        [maleBtn setImage:buttonOn forState:UIControlStateNormal];    }
   
}
- (IBAction)saveAction:(id)sender {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
 
    if ([male isEqualToString:@"YES"]&&[female isEqualToString:@"YES"]) {str=@"All";}
    else if ([male isEqualToString:@"NO"]&&[female isEqualToString:@"YES"]){str=@"Female";}
    else if ([male isEqualToString:@"YES"]&&[female isEqualToString:@"NO"]){str=@"Male";}
    else{
        
        str=@"";
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert showInfo:self title:@"Message"
               subTitle:@"Select atleast a Gender"
       closeButtonTitle:@"OK" duration:0.0f];
        }
    
    
    
    
    if ([ str isEqualToString:@""]) {
        
    }
    else{
        ServerRequests *server=[[ServerRequests alloc]init];
        server.server_req_proces=self;
        [self startLoader];
        NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"privacy_settings\", \"parameters\": {\"user_id\": \"%@\",\"privacy_gender\": \"%@\",\"privacy_age_from\": \"%@\",\"privacy_age_to\": \"%@\"},\"token\":\"\"}",  [standardUserDefaults objectForKey:@"user_id"],str,Str1,Str2];
        NSLog(@"post------%@",postData);
        [server sendServerRequests:postData];
        }
    
    }
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
        
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
        
        
        [standardUserDefaults setObject:[dict objectForKey:@"privacy_age_from"] forKey:@"privacy_age_from"];
        [standardUserDefaults setObject:[dict objectForKey:@"privacy_age_to"] forKey:@"privacy_age_to"];
        
        [standardUserDefaults setObject:[dict objectForKey:@"privacy_gender"] forKey:@"privacy_gender"];
        
        
        
       }
}














@end
