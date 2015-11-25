//
//  Profile1ViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 9/30/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "Profile1ViewController.h"
#import "Profile2ViewController.h"
#import "SelectMountainViewController.h"
#import "SCLAlertView.h"

@interface Profile1ViewController ()

@end

@implementation Profile1ViewController

#pragma mark - System Method


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *urlsString;
    urlsString = [NSString stringWithFormat:@"%@client/terms_of_use",appD.ServerURL];
   
    
    NSURL *url = [NSURL URLWithString:urlsString];
    NSURLRequest *rqst = [NSURLRequest requestWithURL:url];
    [termswebView loadRequest:rqst];
    
    fbProfilePic.clipsToBounds = YES;
    fbProfilePic.layer.cornerRadius=60;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
   
    
    fbProfilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[standardUserDefaults objectForKey:@"pic"]]]];
    nameLbl.text=[standardUserDefaults objectForKey:@"name"];
  
}
-(void)viewWillAppear:(BOOL)animated{
    if ([[appD.ProfileData objectForKey:@"Mountain"] count]>0) {
        SelectLbl.text=[[appD.ProfileData objectForKey:@"Mountain"]objectForKey:@"name"];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Button Action

-(IBAction)hidewebview:(id)sender{
    
    termsView.hidden=YES;
    
}

#pragma mark - Navigation
-(IBAction)selectMoun:(id)sender{
    
    
    SelectMountainViewController *reveal =(SelectMountainViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SelectMountainViewController"];
    
    reveal.dataMount=[[appD.ServerData objectForKey:@"data"] objectForKey:@"mountains_list"];
    [self.navigationController pushViewController:reveal animated:YES];
    
}




-(IBAction)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)Next:(id)sender{
    
     if (![SelectLbl.text isEqual:@"Select Mountain"]) {
         
         
         [self performSegueWithIdentifier:@"ProfileTwo" sender:nil];
         
     }  else{
         
                  SCLAlertView *alert = [[SCLAlertView alloc] init];
         
         [alert showInfo:self title:@"Message"
                 subTitle:@"Select a Mountain"
         closeButtonTitle:@"OK" duration:0.0f];
     }
    
}

@end
