//
//  Profile2ViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "Profile2ViewController.h"
#import "Profile3ViewController.h"

@interface Profile2ViewController ()

@end

@implementation Profile2ViewController

#pragma mark - System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    
    fbProfilePic.clipsToBounds = YES;
    fbProfilePic.layer.cornerRadius=60;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
       
    fbProfilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[standardUserDefaults objectForKey:@"pic"]]]];
    nameLbl.text=[standardUserDefaults objectForKey:@"name"];
    
    dataMount=[[NSMutableArray alloc]init];
    
    dataMount=[[appD.ServerData objectForKey:@"data"] objectForKey:@"skiing_values"];
    
    
    
 
    
    
    
    
    
value=@"Noob";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(IBAction)RadioOne:(id)sender{
    radioPic1.image=[UIImage imageNamed:@"radiograyactive.png"];
radioPic2.image=[UIImage imageNamed:@"radiograynorm.png"];
radioPic3.image=[UIImage imageNamed:@"radiograynorm.png"];
value=@"Noob";


}
-(IBAction)Radiotwo:(id)sender{

    
    value=@"Intermediate";
    
    radioPic1.image=[UIImage imageNamed:@"radiograynorm.png"];
    radioPic2.image=[UIImage imageNamed:@"radiograyactive.png"];
    radioPic3.image=[UIImage imageNamed:@"radiograynorm.png"];

}
-(IBAction)RadioThree:(id)sender{

    
    value=@"Pro";
    
    radioPic1.image=[UIImage imageNamed:@"radiograynorm.png"];
    radioPic2.image=[UIImage imageNamed:@"radiograynorm.png"];
    radioPic3.image=[UIImage imageNamed:@"radiograyactive.png"];


}

#pragma mark - Navigation

-(IBAction)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)Next:(id)sender{
    
        
    NSMutableDictionary *article = [[NSMutableDictionary alloc] init];
    
    
    [ article setObject:value forKey:@"name"];
    if ([value isEqualToString:@"Noob"]) {
        [ article setObject:@"1" forKey:@"id"];    }
    
    
    else if ([value isEqualToString:@"Pro"]) {
        [ article setObject:@"3"  forKey:@"id"];}
    else{
        [ article setObject:@"2"  forKey:@"id"];
    }
    
    [appD.ProfileData setObject:article forKey:@"skiing_values"];
        
      [self performSegueWithIdentifier:@"ProfileThree" sender:nil];
       
   
}


@end
