//
//  CouponViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "ServerRequests.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"



@interface CouponViewController : UIViewController<ServerRequestProcessDelegate>

{
    AppDelegate  *appD;
    
    IBOutlet UITextView *Descriptn;
    
    IBOutlet UIButton *DashBtn;
    
    IBOutlet UILabel *CopnCode;
    IBOutlet UILabel *Pricedtail;
    IBOutlet UILabel *offpricelbl;
    IBOutlet UILabel *DETAILPRICLBL;
    
    IBOutlet UIView *OferView;
    IBOutlet UIView *CoponView;
    
    NSMutableArray *serverDataCoupon;
    NSMutableArray *serverDataOffer;
   
    
}
- (IBAction)coupons:(id)sender;
- (IBAction)offers:(id)sender;
- (IBAction)closeDetailView:(id)sender;



@property (strong, nonatomic) IBOutlet UILabel *detailProductDis;

@property (weak, nonatomic) IBOutlet UIImageView *couponBarImage;
@property (weak, nonatomic) IBOutlet UIImageView *offerBarImage;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;

@property (weak, nonatomic) IBOutlet UICollectionView *couponcollection;
@property (weak, nonatomic) IBOutlet UICollectionView *offercollection;

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIView *detailBakgrd;
@property (strong, nonatomic) IBOutlet UIView *noMatchView;

@end
