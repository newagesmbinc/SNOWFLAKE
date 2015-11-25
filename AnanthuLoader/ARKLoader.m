//
//  NMKLoader.m
//  crossa
//
//  Created by NewageSMB on 3/2/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "ARKLoader.h"

@interface ARKLoader ()

@end

@implementation ARKLoader

- (void)viewDidLoad {
    [super viewDidLoad];
     screenRect = [[UIScreen mainScreen] bounds];
      // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
[self.window addSubview:myView];
 [[[UIApplication sharedApplication] keyWindow] addSubview:someView]
 
 */


-(void)showLoader{
     screenRect = [[UIScreen mainScreen] bounds];    
    
    
    
    mainview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenRect.size.width,  screenRect.size.height)];
    mainview.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
    
    
    UIView *Black_view = [[UIView alloc]initWithFrame:CGRectMake(screenRect.size.width/2-40, screenRect.size.height/2-40, 80, 80)];
    Black_view.clipsToBounds = YES;
    Black_view.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];
    Black_view.layer.cornerRadius=5.0;
    
    

    UIImageView *manImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    manImage.image = [UIImage imageNamed:@"Flake.png"];
    [Black_view addSubview:manImage];

    
   

    
    
    [mainview addSubview:Black_view];
    
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    animation.duration = 5.0f;
    animation.repeatCount = INFINITY;
    [manImage.layer addAnimation:animation forKey:@"SpinAnimation"];
   

    
    [[[UIApplication sharedApplication] keyWindow] addSubview:mainview];
 
    
    
}


-(void)removeLoader{
    
    [mainview removeFromSuperview];
    
}







@end
