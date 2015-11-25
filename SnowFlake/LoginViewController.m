//
//  ViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 9/30/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "LoginViewController.h"
#import "ConfirmViewController.h"
#import "SWRevealViewController.h"
#import "Profile1ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "SCLAlertView.h"
#import "ARKLoader.h"
#import "JSON.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface LoginViewController ()
{
   ARKLoader *ark;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBarHidden=YES;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self start];
   
}
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


#pragma LOCATION
-(void)loadLocation
{
    
    if ([CLLocationManager locationServicesEnabled]) {
        if (!self.locationManager) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.distanceFilter = kCLDistanceFilterNone;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            
            NSLog(@"[DEBUG] [locationManager startUpdatingLocation] (%@, %@)", _locationManager, _locationManager.delegate);
            if(IS_OS_8_OR_LATER){
                NSUInteger code = [CLLocationManager authorizationStatus];
                if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
                    // choose one request according to your business.
                    if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                        [self.locationManager requestAlwaysAuthorization];
                    } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                        [self.locationManager  requestWhenInUseAuthorization];
                    } else {
                        NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
                    }
                }
            }
            [self.locationManager startUpdatingLocation];
        }
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Location Services Not Available!" message:@"Please switch on your Location Services in Device Settings & Restart the Snowflake application." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}








- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    
    SWRevealViewController *reveal =(SWRevealViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"REVEALVIEW"];
    [self.navigationController pushViewController:reveal animated:YES];
    
    
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
     NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    if (currentLocation != nil) {
         NSString  *lat=[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSString  *log=[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        
        
       
        if ([appD.searchdata isEqualToString:@"current_location"]) {
        
        
       
        
        [standardUserDefaults setObject:lat forKey:@"lat2nd"];
        [standardUserDefaults setObject:log forKey:@"log2nd"];
        }
    }
    
    // Stop Location Manager
    [_locationManager stopUpdatingLocation];
    
    NSLog(@"Resolving the Address");
    if(!geocoder)
    {
        geocoder = [[CLGeocoder alloc] init];
    }
    
    
    
    NSLog(@"Begin");
    
    
    [geocoder reverseGeocodeLocation:_locationManager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error){
            NSLog(@"%@", [error localizedDescription]);
        }
        
       placemark = [placemarks lastObject];
        
        
        
       NSString* startAddressString = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                              placemark.subThoroughfare, placemark.thoroughfare,
                              placemark.postalCode, placemark.locality,
                              placemark.administrativeArea,
                              placemark.country];
     
        
   
        
        NSLog(@"%@",startAddressString);
        NSLog(@"Einde");
        
      
    }];

}


-(void)start{
    [self startLoader];
    
    if (appD.devicetoken.length>10) {
        
        [self stopLoader];
        
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
        
       if( [[standardUserDefaults objectForKey:@"fbId"] length]>6) {
            
            
            [self fbloginaction];
           
            
        }
    }
    else{
        [self performSelector:@selector(start) withObject:nil afterDelay:0.5f];
        
    }
    
    
}








#pragma Facebook Login




- (IBAction)fblogin:(id)sender {
    

    
NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];    
        
        
        
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        
        [login logInWithReadPermissions:@[@"public_profile", @"email",@"user_location",@"user_birthday",@"user_hometown",@"user_photos"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            
            if (error) {
            
                
            } else if (result.isCancelled) {
           
                
            } else {
                                if ([result.grantedPermissions containsObject:@"email"]) {
                    
                    // Do work
                    

                    
                    
                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/albums" parameters:nil]
                     
                     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                         
                         if (!error) {
                                                          NSArray *array = [((NSDictionary *)result) objectForKey:@"data"];
                             
                             
                             
                             if(array.count>0){
                                 
                                 for(int i = 0; i<array.count;i++){
                                     
                                    NSString *STR=[NSString stringWithFormat:@"https://graph.facebook.com/%@/photos?",[[array objectAtIndex:i] objectForKey:@"id"]];
                                     
                                   
                                     
                                     [storeTempImage addObject:[NSString stringWithFormat:@"https://graph.facebook.com/%@/photos?",[[array objectAtIndex:i] objectForKey:@"id"]]];
                                   
                                     
                                 }
                                 NSLog(@"HAIIIIIII %@ ",appD.profilepicarray);
                             }
                             
                             
                         }
                         
                     }];
                    
                    
                    
                    
                    
                    
                        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"picture,email,birthday,name,gender,location"}] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id res, NSError *error)
                         
                         {
                             
                             if (!error) {
                                 
                                 
                                 
                                 
                                 
                                   [standardUserDefaults setObject: [res objectForKey:@"id"] forKey:@"fbId"];
                                 
                                 
                                 
                                 
                                 
                                 
                                 storeTemp=[res mutableCopy];
                                 

                                 
                                 
                                [self fbloginaction];
                             
                             
//                             }
                                 
                                 
                                 
                                 
                                 
                                 
                                 
                             }
                             else
                                 
                             {
                                 
                                 NSLog(@"%@", [error localizedDescription]);
                                 
                             }}];
                        
                        
                        
                            
                        
                        
                        
                    
                        
                        
                        
                        
                        
                        
                        
                
                    
                    
                    
                    
                    
                }
                
                
                
                
                
            }
            
        }];
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

-(void)fbloginaction{
    
      NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];    NSString *latitudeonserach;
    NSString *longitudeonserach;
    
    
    latitudeonserach= [standardUserDefaults objectForKey:@"lat"] ;
    longitudeonserach= [standardUserDefaults objectForKey:@"log"] ;



    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;

    if ([[standardUserDefaults objectForKey:@"search_type"] isEqualToString:@"current_location"] ){
        
        latitudeonserach= [standardUserDefaults objectForKey:@"lat2nd"] ;
        longitudeonserach= [standardUserDefaults objectForKey:@"log2nd"] ;
    }
    
    
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"facebook_login\", \"parameters\": {\"facebook_unique_id\": \"%@\",\"device_id\": \"%@\",\"gcm_id\": \"%@\",\"device\": \"%@\",\"lat\": \"%@\",\"long\": \"%@\"},\"token\":\"\"}",  [standardUserDefaults objectForKey:@"fbId"],appD.devicetoken,@"",@"ios",latitudeonserach,longitudeonserach];
    NSLog(@"post------%@",postData);
    
    [server sendServerRequests:postData];
 [self startLoader];




}

-(void)ServerRequestProcessFinish:(NSString *)serverResponse
{
    [self stopLoader   ];
    
    if ([serverResponse isEqualToString:@"ERROR"]) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showInfo:self title:@"Connection error"
                subTitle:@"Cannot connect with server. Please try again later."
        closeButtonTitle:@"OK" duration:0.0f];
        
        
    }else{
        //NSLog(@"serverResponse %@",serverResponse);
        NSData *data=[serverResponse dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSError *er;
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&er];
        NSLog(@"messageArray------%@",dict);
        
       
            
            if ([[dict objectForKey:@"status"]isEqualToString:@"true"]) {
                if ([[dict objectForKey:@"is_new_acount"] isEqualToString:@"1"]) {
                    
                     NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                    
                    
                    NSURL *fburl = [NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", [storeTemp objectForKey:@"id"]]];
                    NSString *string= [fburl absoluteString];
                    
                    
                    
                    
                    [standardUserDefaults setObject:[storeTemp objectForKey:@"email"]forKey:@"email"];
                    
                    
                    
                    [standardUserDefaults setObject: [storeTemp objectForKey:@"birthday"] forKey:@"birthday"];
                    
                    [standardUserDefaults setObject:[storeTemp objectForKey:@"name"] forKey:@"name"];
                    [standardUserDefaults setObject:[storeTemp objectForKey:@"gender"] forKey:@"gender"];
                    
                    
                    [standardUserDefaults setObject:string forKey:@"pic"];
                    
                    [standardUserDefaults setObject: [storeTemp objectForKey:@"id"] forKey:@"fbId"];
                    NSDictionary *location=[storeTemp valueForKey:@"location"];
                    if (location.count>0) {
                        [self getLocationFromAddressString:[location valueForKey:@"name"]];
                        
                        [standardUserDefaults setObject:[location valueForKey:@"name"] forKey:@"location"];
                        
                        [standardUserDefaults setObject:[location valueForKey:@"name"] forKey:@"locationbase"];
                    }
                    
                    
                    
                    
                    
                    
                    
                
                
                  
                    
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"user_id"]forKey:@"user_id"];
                   
                    
                    
                    appD.profilepicarray=[storeTempImage mutableCopy];
                    
                    
                    
                    
                    ConfirmViewController *reveal =(ConfirmViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"CONFIRMVIEW"];
                    [self.navigationController pushViewController:reveal animated:YES];
                    
                    
                    
                }
                
                
                
                
                else {
                    
                    
                    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                    
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"user_id"]forKey:@"user_id"];
                    
                    [standardUserDefaults setObject: [dict objectForKey:@"dob"] forKey:@"birthday"];
                    [standardUserDefaults setObject:[dict objectForKey:@"image"] forKey:@"pic"];
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"email"]forKey:@"email"];
                   
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"first_name"] forKey:@"name"];
                    [standardUserDefaults setObject:[dict objectForKey:@"gender"] forKey:@"gender"];
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"location"] forKey:@"location"];
                    [standardUserDefaults setObject:[dict objectForKey:@"marital_status"] forKey:@"marital_status"];
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"search_age_from"] forKey:@"search_age_from"];
                    [standardUserDefaults setObject:[dict objectForKey:@"search_age_to"] forKey:@"search_age_to"];
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"search_gender"] forKey:@"search_gender"];
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"privacy_age_from"] forKey:@"privacy_age_from"];
                    [standardUserDefaults setObject:[dict objectForKey:@"privacy_age_to"] forKey:@"privacy_age_to"];
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"privacy_gender"] forKey:@"privacy_gender"];
                    
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"age"]forKey:@"age"];
                    
                    
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"search_radius"] forKey:@"search_radius"];
                    
                    [standardUserDefaults setObject:[dict objectForKey:@"lat"] forKey:@"lat"];
                    [standardUserDefaults setObject:[dict objectForKey:@"long"] forKey:@"log"];
                    [standardUserDefaults setObject:[dict objectForKey:@"search_lat"] forKey:@"lat2nd"];
                    [standardUserDefaults setObject:[dict objectForKey:@"search_long"] forKey:@"log2nd"];
                    
                     [standardUserDefaults setObject:[dict objectForKey:@"search_type"] forKey:@"search_type"];
                    
                     [standardUserDefaults setObject:[dict objectForKey:@"preferred_location"] forKey:@"preferred_location"];
                    
                    
                    
                    
                     appD.ServerData=[dict mutableCopy];
                    appD.searchdata=[dict objectForKey:@"search_type"];
                    if([[dict objectForKey:@"is_profile_created"]isEqualToString:@"1"]){
               
                    
                          if([appD.searchdata isEqualToString:@"current_location"]){
                              
                              
                              [self loadLocation];
                          }else{
                              SWRevealViewController *reveal =(SWRevealViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"REVEALVIEW"];
                              [self.navigationController pushViewController:reveal animated:YES];                          }
                        
        
                }
                    
                    else{
                        
                        Profile1ViewController *reveal =(Profile1ViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"Profile1"];
                        [self.navigationController pushViewController:reveal animated:YES];
                        

                    }
                
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

    
    
    
    

    







-(void)fbloginwithuuid{
    

    ConfirmViewController *reveal =(ConfirmViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"CONFIRMVIEW"];
    [self.navigationController pushViewController:reveal animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
