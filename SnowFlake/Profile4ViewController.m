//
//  Profile4ViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "Profile4ViewController.h"
#import "Profile5ViewController.h"
#import "SCLAlertView.h"
@interface Profile4ViewController ()

@end

@implementation Profile4ViewController


#pragma mark - System Method


- (void)viewDidLoad {
    [super viewDidLoad];
    
    fbProfilePic.clipsToBounds = YES;
    fbProfilePic.layer.cornerRadius=50;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
   
    
    fbProfilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[standardUserDefaults objectForKey:@"pic"]]]];
    nameLbl.text=[standardUserDefaults objectForKey:@"name"];
    
    dataMount=[[NSMutableArray alloc]init];
    MuntValue=[[NSMutableArray alloc]init];
    
    dataMount=[[appD.ServerData objectForKey:@"data"] objectForKey:@"focus_on_values"];
    
    
    
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

#pragma mark - Navigation
-(IBAction)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)Next:(id)sender{
   
    
    
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
    
    
    
   
    [appD.ProfileData setObject:MuntValue forKey:@"focus_on_values"];
    
    
    if (MuntValue.count>0) {
     
    
   [self performSegueWithIdentifier:@"ProfileFive" sender:nil];
    
    }
    else{
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showInfo:self title:@""
                subTitle:@"Select One focus on values"
        closeButtonTitle:@"OK" duration:0.0f];
          }
    
}



@end
