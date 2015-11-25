//
//  popup.h
//  List
//
//  Created by NewageSMB on 7/9/15.
//  Copyright (c) 2015 NewageSMB. All rights reserved.
//
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@interface popup : UIView
{
    AppDelegate *appDelegate;
}
@property (strong, nonatomic) UIView *primaryView;
@property( strong,nonatomic) IBOutlet UIButton *meg;
@property( strong,nonatomic) IBOutlet UIButton *profile;
@property( strong,nonatomic) IBOutlet UIImageView *profilePic;
@property( strong,nonatomic) IBOutlet UIButton *close;
@end
