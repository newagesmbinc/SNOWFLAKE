//
//  Profile5ViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "Profile5ViewController.h"
#import "SWRevealViewController.h"
#import "SCLAlertView.h"
#import "ARKLoader.h"




@interface Profile5ViewController ()
{
    ARKLoader *ark;
}
@end

@implementation Profile5ViewController

#pragma mark - Loader

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

#pragma mark - System Method


- (void)viewDidLoad {
    [super viewDidLoad];
    
    fbProfilePic.clipsToBounds = YES;
    fbProfilePic.layer.cornerRadius=50;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"%@",[standardUserDefaults objectForKey:@"pic"]);
    
    fbProfilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[standardUserDefaults objectForKey:@"pic"]]]];
    nameLbl.text=[standardUserDefaults objectForKey:@"name"];
    
    dataMount=[[NSMutableArray alloc]init];
    MuntValue=[[NSMutableArray alloc]init];
    
    dataMount=[[appD.ServerData objectForKey:@"data"] objectForKey:@"area_to_improve_values"];
    
    
    serverDataLbl1.text=[[dataMount objectAtIndex:0]objectForKey:@"name"];
    
    serverDataLbl2.text=[[dataMount objectAtIndex:1]objectForKey:@"name"];
    serverDataLbl3.text=[[dataMount objectAtIndex:2]objectForKey:@"name"];
    serverDataLbl4.text=[[dataMount objectAtIndex:3]objectForKey:@"name"];
    
    serverDataLbl5.text=[[dataMount objectAtIndex:4]objectForKey:@"name"];
    serverDataLbl6.text=[[dataMount objectAtIndex:5]objectForKey:@"name"];
    
   
    value1=@"1";
    value2=@"0";
    value3=@"0";
    value4=@"0";
    value5=@"0";
    value6=@"0";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
-(IBAction)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Button Action


-(IBAction)RadioOne:(id)sender{
    if ([value1 isEqualToString:@"1"]) {
        
        value1=@"0";
        radioPic1.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value1=@"1";
        radioPic1.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
}
-(IBAction)Radiotwo:(id)sender{
    
    
    if ([value2 isEqualToString:@"1"]) {
        
        value2=@"0";
        radioPic2.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value2=@"1";
        radioPic2.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
    
}
-(IBAction)RadioThree:(id)sender{
    
    
    if ([value3 isEqualToString:@"1"]) {
        
        value3=@"0";
        radioPic3.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value3=@"1";
        radioPic3.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
}

-(IBAction)Radiofour:(id)sender{
    if ([value4 isEqualToString:@"1"]) {
        
        value4=@"0";
        radioPic4.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value4=@"1";
        radioPic4.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
}
-(IBAction)Radiofive:(id)sender{
    
    
    if ([value5 isEqualToString:@"1"]) {
        
        value5=@"0";
        radioPic5.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value5=@"1";
        radioPic5.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
    
}
-(IBAction)Radiosix:(id)sender{
    
    
    if ([value6 isEqualToString:@"1"]) {
        
        value6=@"0";
        radioPic6.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value6=@"1";
        radioPic6.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
}


-(IBAction)submit:(id)sender{
    

    
    
    
    
    if ([value1 isEqualToString:@"1"]) {
        
        
        
        
     
        [ MuntValue  addObject:@"1"];
    }
    
    if ([value2 isEqualToString:@"1"]) {
        
        
        
        [ MuntValue  addObject:@"2"];
        
        
    }
    
    if ([value3 isEqualToString:@"1"]) {
        
        
        
        
        
        [ MuntValue  addObject:@"3"];
    }
    
    if ([value4 isEqualToString:@"1"]) {
        
        
        
        
        [ MuntValue  addObject:@"4"];
    }
    if ([value5 isEqualToString:@"1"]) {
        
       
        
        
        [ MuntValue  addObject:@"5"];
    }
    if ([value6 isEqualToString:@"1"]) {
        
       
        
        
        [ MuntValue  addObject:@"6"];
        
    }
    
    
    
    
    [appD.ProfileData setObject:MuntValue forKey:@"area_to_improve_values"];
    
    NSLog(@"%@",appD.ProfileData);
   
 if (MuntValue.count>0) {
     
     
    NSString *joinedComponents = [MuntValue componentsJoinedByString:@","];
    
    NSString *joinedComponents1 = [[appD.ProfileData objectForKey:@"focus_on_values"] componentsJoinedByString:@","];
    
     [self startLoader];
     
     
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
    
    
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"complete_profile\", \"parameters\": {\"user_id\": \"%@\",\"mountain_id\": \"%@\",\"skiing_id\": \"%@\",\"snowboarding_id\": \"%@\",\"focus_on\": \"%@\",\"area_to_improve\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"],[[appD.ProfileData objectForKey:@"Mountain"] objectForKey:@"id"],[[appD.ProfileData objectForKey:@"skiing_values"] objectForKey:@"id"],[[appD.ProfileData objectForKey:@"snowboarding_values"] objectForKey:@"id"],joinedComponents1,joinedComponents];
    NSLog(@"post------%@",postData);
//
     [server sendServerRequests:postData];}

    else{
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showInfo:self title:@""
                subTitle:@"Select One area to improve values"
        closeButtonTitle:@"OK" duration:0.0f];
    }}

-(void)ServerRequestProcessFinish:(NSString *)serverResponse
{
    
    
    [self stopLoader];
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
        appD.ServerData=[dict mutableCopy];
        
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
        [standardUserDefaults setObject:[dict objectForKey:@"search_radius"] forKey:@"search_radius"];
        
        [standardUserDefaults setObject:[dict objectForKey:@"privacy_age_from"] forKey:@"privacy_age_from"];
        [standardUserDefaults setObject:[dict objectForKey:@"privacy_age_to"] forKey:@"privacy_age_to"];
        
        [standardUserDefaults setObject:[dict objectForKey:@"privacy_gender"] forKey:@"privacy_gender"];
        [standardUserDefaults setObject:[dict objectForKey:@"preferred_location"] forKey:@"preferred_location"];        
        [standardUserDefaults setObject:[dict objectForKey:@"age"]forKey:@"age"];
        
        [standardUserDefaults setObject:[dict objectForKey:@"lat"] forKey:@"lat"];
        [standardUserDefaults setObject:[dict objectForKey:@"long"] forKey:@"log"];
        
        [standardUserDefaults setObject:[dict objectForKey:@"search_lat"] forKey:@"lat2nd"];
        [standardUserDefaults setObject:[dict objectForKey:@"search_long"] forKey:@"log2nd"];
        
         [standardUserDefaults setObject:[dict objectForKey:@"search_type"] forKey:@"search_type"];        
        
        
        appD.searchdata=[dict objectForKey:@"search_type"];
        
        
        
        
        
        
        
            SWRevealViewController *reveal =(SWRevealViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"REVEALVIEW"];
            [self.navigationController pushViewController:reveal animated:YES];
     
    }
}
@end
