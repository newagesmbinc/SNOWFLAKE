//
//  popup.m
//  SnowFlake
//
//  Created by NewageSMB on 7/9/15.
//  Copyright (c) 2015 NewageSMB. All rights reserved.
//

#import "popup.h"
#import "MyprofileViewController.h"
#import "UIImageView+WebCache.h"

@implementation popup
@synthesize  primaryView,meg,profile,profilePic,close;




#pragma Push notification

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
      
  appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        primaryView=[[UIView alloc]initWithFrame: CGRectMake(00,00, screenWidth,screenHeight)];
        primaryView.backgroundColor=[UIColor clearColor];
       
   [self addSubview:primaryView];
    
        UIImageView *image12=[[UIImageView alloc]initWithFrame:primaryView.frame];
        image12.image=[UIImage imageNamed:@"bg16.png"];
        [primaryView addSubview:image12];
        
        
        
       close= [UIButton buttonWithType:UIButtonTypeCustom];
       
        close.backgroundColor=[UIColor clearColor];
        close.frame = primaryView.frame;
        [primaryView addSubview:close];
        
        
        
        
        
        UIView * primaryView1=[[UIView alloc]initWithFrame:CGRectMake((primaryView.frame.size.width/2)-150,(primaryView.frame.size.height/2)-120,300,200)];
        primaryView1.backgroundColor=[UIColor clearColor];

        [primaryView addSubview:primaryView1];
        
       
       
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0,40,300,160)];
        image.image=[UIImage imageNamed:@"bgpopup.png"];
        [primaryView1 addSubview:image];
        
        UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(95,0,110,110)];
        image1.image=[UIImage imageNamed:@"imageholder.png"];
        [primaryView1 addSubview:image1];
        
        profilePic=[[UIImageView alloc]initWithFrame:CGRectMake(100,5,100,100)];
        
        
     
         [profilePic sd_setImageWithURL:[NSURL URLWithString:appDelegate.matchImage] placeholderImage:nil];
        
        profilePic.clipsToBounds = YES;
        profilePic.layer.cornerRadius=50;
        
        [primaryView1 addSubview:profilePic];
        
        
       
   UILabel * pop=[[UILabel alloc]initWithFrame:CGRectMake(0,115,300,30)];
    pop.backgroundColor=[UIColor clearColor];
        pop.textAlignment = NSTextAlignmentCenter;
        pop.textColor=[UIColor whiteColor];
        [pop setFont:[UIFont fontWithName:@"cabin-Regular" size:18]];
        pop.text=[NSString stringWithFormat:@"You got a new match"];
      
    [primaryView1 addSubview:pop];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        
        meg = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [meg.titleLabel setFont:[UIFont fontWithName:@"cabin-Regular" size:15]  ];
        
        [meg setTitle:@"MESSAGING" forState:UIControlStateNormal];
        meg.frame = CGRectMake(00.0, 150.0, 130.0, 50.0);
        
        
         meg.backgroundColor=[UIColor clearColor];
        
        
        [primaryView1 addSubview:meg];
        
        profile     = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [profile setTitle:@"PROFILE" forState:UIControlStateNormal];
        [profile.titleLabel setFont:[UIFont fontWithName:@"cabin-Regular" size:15]  ];
        profile.backgroundColor=[UIColor clearColor];
        profile.frame = CGRectMake(160.0, 150.0, 150.0, 50.0);
        [primaryView1 addSubview:profile];
     
    }
    return self;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}



@end
