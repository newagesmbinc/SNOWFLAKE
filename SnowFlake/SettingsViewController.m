//
//  SettingsViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "SettingsViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LoginViewController.h"
#import "webDetailViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

#pragma mark - System Method
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    
    SWRevealViewController *revealController = [self revealViewController];
   
    [revealController tapGestureRecognizer];
    
    
    [DashBtn addTarget:revealController
                action:@selector(revealToggle:)
      forControlEvents:UIControlEventTouchUpInside];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Server Call

- (IBAction)Logout:(id)sender {
    
    
    
    
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
    
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"logout\",\"parameters\": {\"user_id\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"]];
    NSLog(@"post------%@",postData);
    
    [server sendServerRequests:postData];
    
    
}

#pragma mark - Server Response

-(void)ServerRequestProcessFinish:(NSString *)serverResponse
{
    
    
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
        
        
        
        if ([[dict objectForKey:@"status"]isEqual:@"true"]) {
            
            
            
            
            
            
            
            
            
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            
          
                    [standardUserDefaults removeObjectForKey:@"email"];
            
            [standardUserDefaults removeObjectForKey:@"name"];
            [standardUserDefaults removeObjectForKey:@"gender"];
            
            [standardUserDefaults removeObjectForKey:@"pic"];
            
            [standardUserDefaults removeObjectForKey:@"location"];
            
              [standardUserDefaults removeObjectForKey:@"location2nd"];
            
            
            
            
            [standardUserDefaults removeObjectForKey:@"marital_status"];
            [standardUserDefaults removeObjectForKey:@"birthday"];
            
            [standardUserDefaults removeObjectForKey:@"user_id"];
         
            [standardUserDefaults removeObjectForKey:@"fbId"];
            [standardUserDefaults removeObjectForKey:@"facebook_unique_id"];
            [standardUserDefaults setObject:@"" forKey:@"gender"];
           
            
            [standardUserDefaults setObject:@"" forKey:@"facebook_unique_id"];
        
                   [standardUserDefaults setObject:@"" forKey:@"email"];
            [standardUserDefaults setObject:@"" forKey:@"email"];
            [standardUserDefaults setObject:@"" forKey:@"user_id"];
            [standardUserDefaults setObject:@"" forKey:@"name"];
          
            [standardUserDefaults setObject:@"" forKey:@"birthday"];
            [standardUserDefaults setObject:@"" forKey:@"pic"];
            [standardUserDefaults setObject:@"" forKey:@"fbId"];
            
            
            
            
            appD.ServerData=nil;
            appD.ProfileData=nil;
            appD.addCount=nil;
            
            [standardUserDefaults synchronize];
            
            [FBSDKAccessToken setCurrentAccessToken:nil];
            [FBSDKProfile setCurrentProfile:nil];
            FBSDKLoginManager *logMeOut = [[FBSDKLoginManager alloc] init];
            [logMeOut logOut];
            
            
            
            
            
            
            
            LoginViewController *reveal =(LoginViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self.navigationController pushViewController:reveal animated:YES];
            
          
        }
        
        else{
            
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            
            [alert showInfo:self title:@"Error"
                    subTitle:[dict objectForKey:@"message"]
            closeButtonTitle:@"OK" duration:0.0f];
            
            
            
            
        }
        
        
    }
    
}

#pragma mark - Button Action & Navigation






- (IBAction)Terms:(id)sender {

webDetailViewController *reveal =(webDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"webDetailViewController"];
reveal.webData=@"Terms & Conditions";






    [self.navigationController pushViewController:reveal animated:YES];}


- (IBAction)Privacy:(id)sender {
    
    webDetailViewController *reveal =(webDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"webDetailViewController"];
    reveal.webData=@"Privacy Policy";
    
    
    
    
    
    
    [self.navigationController pushViewController:reveal animated:YES];}





@end
