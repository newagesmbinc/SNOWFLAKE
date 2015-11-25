//
//  SearchsetViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/27/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "SearchsetViewController.h"
#import "SCLAlertView.h"
#import "ARKLoader.h"
@interface SearchsetViewController ()
{
    ARKLoader *ark;
    
    int adesconut;
}
@end

@implementation SearchsetViewController
@synthesize actionAgeSlider,actionDisSlider,myAnnotation1;

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


-(void)viewWillAppear:(BOOL)animated{
    
    
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    RangeSlider.minimumRange=0.0;
    RangeSlider.maximumValue=1.0;
    
    
    if ([appDelegate.searchdata isEqualToString:@"base_location"]) {
        
    
    lat= [[standardUserDefaults objectForKey:@"lat"] floatValue];
    lng= [[standardUserDefaults objectForKey:@"log"] floatValue];
    } else if ([appDelegate.searchdata isEqualToString:@"current_location"]) {
        lat= [[standardUserDefaults objectForKey:@"lat3nd"] floatValue];
        lng= [[standardUserDefaults objectForKey:@"lat3nd"] floatValue];    }
    
    else{
        lat= [[standardUserDefaults objectForKey:@"lat2nd"] floatValue];
        lng= [[standardUserDefaults objectForKey:@"lat2nd"] floatValue];
    }
    
    
    CLLocationCoordinate2D location;
    location.latitude=lat ;
    location.longitude=lng ;
    UIImage *buttonOn = [UIImage imageNamed:@"graycheckactive.png"];
    UIImage *buttonOff = [UIImage imageNamed:@"graychecknorm.png"];
    baseLocation.text=[standardUserDefaults objectForKey:@"location"];

    if (![appDelegate.ssearchdata isEqualToString:@""]&&![appDelegate.ssearchdata isEqualToString:@"preferred_location"]) {
        [cuntBtn setImage:buttonOff forState:UIControlStateNormal];
        
        [baseBtn setImage:buttonOff forState:UIControlStateNormal];
        [preferredBtn setImage:buttonOn forState:UIControlStateNormal];
        
        setlocatin.text=appDelegate.ssearchdata;
    }else{
        appDelegate.ssearchdata=@"";
    
 
    if ([locId isEqualToString:@"base_location"]) {
        
        setlocatin.text=@"";
        [preferredBtn setImage:buttonOff forState:UIControlStateNormal];        
        [baseBtn setImage:buttonOn forState:UIControlStateNormal];
        [cuntBtn setImage:buttonOff forState:UIControlStateNormal];
    }
    else if ([locId isEqualToString:@"current_location"])
        
    {
        
        setlocatin.text=@"";
        
          [preferredBtn setImage:buttonOff forState:UIControlStateNormal];
        
        [cuntBtn setImage:buttonOn forState:UIControlStateNormal];
        
        [baseBtn setImage:buttonOff forState:UIControlStateNormal];
    }
    
    }

    
    
    
    
    
}

-(void)loadLocation
{
    
    
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate=self;
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        
        if([currSysVer integerValue] >=8)
        {
            if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [locationManager requestWhenInUseAuthorization];
            }
            
        }
        locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
        [locationManager startUpdatingLocation];
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Location Services Not Available!" message:@"Please switch on your Location Services in Device Settings & Restart the bizChat application." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //NSLog(@"%@", [locations lastObject]);
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    adesconut=0;
    
    NSLog(@"%@",[standardUserDefaults objectForKey:@"latitude"]);
    
    
    locationFromLM = [locations objectAtIndex:0];
    NSLog(@"%@",[locations objectAtIndex:0]);
    
    
    latitude = locationFromLM.coordinate.latitude;
    longitude = locationFromLM.coordinate.longitude;
    
    
    
    NSString  *lat1=[NSString stringWithFormat:@"%.8f", latitude];
    NSString  *log1=[NSString stringWithFormat:@"%.8f", longitude];
    

        
        [standardUserDefaults setObject:lat1 forKey:@"lat3nd"];
        [standardUserDefaults setObject:log1 forKey:@"log3nd"];

    
    
    
    NSLog(@"%f%f",latitude,longitude);
    if(locationFromLM != nil)
    {
        [locationManager stopUpdatingLocation];
        locationManager =nil;
        
        // @autoreleasepool
        {
            
         
            
            [self getlocationname];
 
            
            
            
        }
    }
    
}

-(void)getlocationname{


    NSLog(@"Begin");
    __block   NSString *returnAddress = @"";
    
  
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    
    
    
    
    [geocoder reverseGeocodeLocation:[[CLLocation alloc]  initWithLatitude:latitude longitude:longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error){
            NSLog(@"%@", [error localizedDescription]);
        }
        
        CLPlacemark *placemark = [placemarks lastObject];
        
        
        returnAddress = [NSString stringWithFormat:@"%@,%@ ",
                         
                         placemark.administrativeArea,
                         placemark.country];
        
        
        
       
        
        
        
        

        
        
        
        NSLog(@"%lu",(unsigned long)returnAddress.length);
       
      
        if ([returnAddress isEqualToString:@"(null),(null) "])
        {
            returnAddress =@"Unspecified";
            
           
        }
        
         cuntLoctn.text=returnAddress;
        
        
        if(locationManager)
        {
            locationManager=nil;
            locationManager.delegate=nil;
        }
       
        
        
        
    }];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    

    [self loadLocation];
    float minimunrangeValue=0.016667;
    
    actionDisSlider.minimumValue = 1.0;
    actionDisSlider.maximumValue = 300.0;
    actionDisSlider.continuous = YES;
    RangeSlider.minimumValue = 0.3;
    RangeSlider.minimumRange=minimunrangeValue;
    RangeSlider.upperValue =1.0;
    RangeSlider.continuous = YES;
    RangeSlider.lowerValue =0.3;
    str=@"";
    float lowerrangeValue=[[standardUserDefaults  objectForKey:@"search_age_from"]floatValue]*minimunrangeValue;
    float upperrangeValue=[[standardUserDefaults  objectForKey:@"search_age_to"]floatValue]*minimunrangeValue;
    RangeSlider.upperValue =upperrangeValue;
   
    RangeSlider.lowerValue =lowerrangeValue;
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    myAnnotation1 = [[annotationclass alloc] init];
    UIImage *buttonOff = [UIImage imageNamed:@"graychecknorm.png"];
    UIImage *buttonOn = [UIImage imageNamed:@"graycheckactive.png"];
    
     str=[standardUserDefaults objectForKey:@"search_gender"];
    if ([[standardUserDefaults objectForKey:@"age"] integerValue]<18) {
        
        
        AgeView.hidden=YES;
        
        
    }
    if ([[standardUserDefaults objectForKey:@"search_gender"] isEqualToString:@"All"]) {
        male=@"YES";
        
               female=@"YES";
        [maleBtn setImage:buttonOn forState:UIControlStateNormal];
        [femaleBtn setImage:buttonOn forState:UIControlStateNormal];
    }else if ([[standardUserDefaults objectForKey:@"search_gender"] isEqualToString:@"Male"])
    {
        female=@"NO";
   male=@"YES";
        [maleBtn setImage:buttonOn forState:UIControlStateNormal];
        [femaleBtn setImage:buttonOff forState:UIControlStateNormal];
        
        
        
    }else{
        female=@"YES";
        male=@"NO";
        
        [maleBtn setImage:buttonOff forState:UIControlStateNormal];
        [femaleBtn setImage:buttonOn forState:UIControlStateNormal];
    
    
    }
    sliderAgeValue.text=[NSString stringWithFormat:@"%@-%@",[standardUserDefaults  objectForKey:@"search_age_from"],[standardUserDefaults  objectForKey:@"search_age_to"]];
    
    
    Str1=[standardUserDefaults  objectForKey:@"search_age_from"];
    Str=[standardUserDefaults  objectForKey:@"search_age_to"];
    
    locId=appDelegate.searchdata;
    
    if ([locId isEqualToString:@"base_location"]) {
        [baseBtn setImage:buttonOn forState:UIControlStateNormal];
    [cuntBtn setImage:buttonOff forState:UIControlStateNormal];
    }
    else if ([locId isEqualToString:@"current_location"])
    
        {
            [cuntBtn setImage:buttonOn forState:UIControlStateNormal];
            
            [baseBtn setImage:buttonOff forState:UIControlStateNormal];
        }else{
            
            appDelegate.ssearchdata=locId;
            
            [cuntBtn setImage:buttonOff forState:UIControlStateNormal];
            
            [baseBtn setImage:buttonOff forState:UIControlStateNormal];        }
    
     sliderDisValue.text=[NSString stringWithFormat:@"%@ miles",[standardUserDefaults  objectForKey:@"search_radius"]];
   
    Str2=[standardUserDefaults  objectForKey:@"search_radius"];
    
   actionDisSlider.value = [[standardUserDefaults objectForKey:@"search_radius"]floatValue];
    
    RangeSlider.tintColor=[UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];
    actionDisSlider.tintColor=[UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];
   
    
    
    
    [actionDisSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
 [RangeSlider addTarget:self action:@selector(sliderAction1:) forControlEvents:UIControlEventValueChanged];
    
    appDelegate.ssearchdata=[standardUserDefaults objectForKey:@"preferred_location"];
    
    
     NSLog(@"%@",appDelegate.ssearchdata);
   
    
    
    
   
    
}
- (IBAction)saveAction:(id)sender {
NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *latitudeonserach;
    NSString *longitudeonserach;
       NSString *preferdserachlction;
    
    
    
    
    
    appDelegate.searchdata=locId;
    
    
   NSLog(@"%@",appDelegate.ssearchdata);
    
    if (![appDelegate.ssearchdata isEqualToString:@""]&&![appDelegate.ssearchdata isEqualToString:@"preferred_location"]) {
        latitudeonserach= [standardUserDefaults objectForKey:@"lat2nd"] ;
        longitudeonserach= [standardUserDefaults objectForKey:@"log2nd"] ;
    appDelegate.searchdata=@"preferred_location";
        preferdserachlction=appDelegate.ssearchdata;
        
        
    }else{
        
        preferdserachlction=@"";
        
    appDelegate.ssearchdata=@"";
    if ([appDelegate.searchdata isEqualToString:@"base_location"]) {
        
        
        latitudeonserach= [standardUserDefaults objectForKey:@"lat"] ;
        longitudeonserach= [standardUserDefaults objectForKey:@"log"] ;
    }else{
        
        appDelegate.searchdata=@"current_location";
        latitudeonserach= [standardUserDefaults objectForKey:@"lat3nd"] ;
        longitudeonserach= [standardUserDefaults objectForKey:@"log3nd"] ;
    }
    }
   
    
  
    
    if ([male isEqualToString:@"YES"]&&[female isEqualToString:@"YES"]) {
       str=@"All";
    }else if ([male isEqualToString:@"NO"]&&[female isEqualToString:@"YES"])
    {
         str=@"Female";
    }else if ([male isEqualToString:@"YES"]&&[female isEqualToString:@"NO"])
    {
       str=@"Male";
        
        
    }else
{
    
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

   NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"save_settings\", \"parameters\": {\"user_id\": \"%@\",\"search_gender\": \"%@\",\"search_age_to\": \"%@\",\"search_age_from\": \"%@\",\"search_radius\": \"%@\",\"search_lat\": \"%@\",\"search_long\": \"%@\",\"search_type\": \"%@\",\"preferred_location\": \"%@\"},\"token\":\"\"}",  [standardUserDefaults objectForKey:@"user_id"],str,Str,Str1,Str2,latitudeonserach,longitudeonserach,appDelegate.searchdata,preferdserachlction];
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
        
       
        
        [standardUserDefaults setObject:[dict objectForKey:@"search_age_from"] forKey:@"search_age_from"];
        [standardUserDefaults setObject:[dict objectForKey:@"search_age_to"] forKey:@"search_age_to"];
        [standardUserDefaults setObject:[dict objectForKey:@"search_gender"] forKey:@"search_gender"];
        [standardUserDefaults setObject:[dict objectForKey:@"search_radius"] forKey:@"search_radius"];
        [standardUserDefaults setObject:[dict objectForKey:@"search_type"] forKey:@"search_type"];
        [standardUserDefaults setObject:[dict objectForKey:@"lat"] forKey:@"lat"];
        [standardUserDefaults setObject:[dict objectForKey:@"long"] forKey:@"log"];
        [standardUserDefaults setObject:[dict objectForKey:@"search_lat"] forKey:@"lat2nd"];
        [standardUserDefaults setObject:[dict objectForKey:@"search_long"] forKey:@"log2nd"];
        [standardUserDefaults setObject:[dict objectForKey:@"preferred_location"] forKey:@"preferred_location"];
        
    appDelegate.searchdata=[dict objectForKey:@"search_type"];    }
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

- (IBAction)sliderAction:(id)sender{
    Str2=[NSString stringWithFormat:@"%.0f",actionDisSlider.value];
    
    sliderDisValue.text=[NSString stringWithFormat:@"%.0f miles",actionDisSlider.value];
    

    
    
}
- (IBAction)sliderAction1:(id)sender{
    
    float upper=  RangeSlider.upperValue*60;
    
    float lower=  RangeSlider.lowerValue*60;
    
    Str=[NSString stringWithFormat:@"%.0f",upper];
    Str1=[NSString stringWithFormat:@"%.0f",lower];
    
    sliderAgeValue.text=[NSString stringWithFormat:@"%@-%@",Str1,Str];
    
}


- (IBAction)locCuntAction:(id)sender {
        appDelegate.ssearchdata=@"";
    UIImage *buttonOff = [UIImage imageNamed:@"graychecknorm.png"];
    UIImage *buttonOn = [UIImage imageNamed:@"graycheckactive.png"];
    
    
    
    if ([ locId isEqualToString:@"current_location"]) {
        locId=@"";
        
        [cuntBtn setImage:buttonOff forState:UIControlStateNormal];
        
    }else{
       
        locId= @"current_location";
        [baseBtn setImage:buttonOff forState:UIControlStateNormal];
        
        [preferredBtn setImage:buttonOff forState:UIControlStateNormal];
        [cuntBtn setImage:buttonOn forState:UIControlStateNormal];
     setlocatin.text=@"";
    
    
    }
    
    
    
    
    
}
- (IBAction)locBaseAction:(id)sender {
    
    UIImage *buttonOff = [UIImage imageNamed:@"graychecknorm.png"];
    UIImage *buttonOn = [UIImage imageNamed:@"graycheckactive.png"];
    
    appDelegate.ssearchdata=@"";
    if ([ locId isEqualToString:@"base_location"]) {
        locId=@"";
        
        [baseBtn setImage:buttonOff forState:UIControlStateNormal];
        
    }else{
        
        locId= @"base_location";
           setlocatin.text=@"";
          [preferredBtn setImage:buttonOff forState:UIControlStateNormal];
        
        [cuntBtn setImage:buttonOff forState:UIControlStateNormal];
        
        [baseBtn setImage:buttonOn forState:UIControlStateNormal];
 
    }

    
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



-(IBAction)back:(id)sender{
    appDelegate.ssearchdata=@"";
    [self.navigationController popViewControllerAnimated:YES];
  
    

}
-(IBAction)locationMap:(id)sender{

 [self performSegueWithIdentifier:@"SetLocation" sender:nil];

}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString * const kPinAnnotationIdentifier = @"PinIdentifier";
    if(annotation == mapView.userLocation)
    {
        return nil;
    }
    
    myAnnotation1  = (annotationclass *)annotation;
    MKAnnotationView *newAnnotation = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationIdentifier];
    
    if(!newAnnotation){
        newAnnotation = [[MKAnnotationView alloc] initWithAnnotation:myAnnotation1 reuseIdentifier:@"userloc"];
        
      
        
        
        newAnnotation.image =[UIImage imageNamed:@"Flake.png"];
        
        newAnnotation.enabled = YES;
        newAnnotation.canShowCallout = YES;
        
        
        
    }else {
        newAnnotation = [[MKAnnotationView alloc] initWithAnnotation:myAnnotation1 reuseIdentifier:@"userloc"];             newAnnotation.image =[UIImage imageNamed:@"Flake.png"];
        
        newAnnotation.enabled = YES;
        newAnnotation.canShowCallout = YES;
        
    }
    
    
    
    
    return newAnnotation;
}







@end
