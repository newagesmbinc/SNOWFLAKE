//
//  DetailProfileViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/9/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSwipeableView.h"
#import "CardView.h"
#import "AppDelegate.h"
#import "ServerRequests.h"


@interface DetailProfileViewController : UIViewController
<ZLSwipeableViewDataSource,ZLSwipeableViewDelegate,ServerRequestProcessDelegate,UIScrollViewDelegate>
{
    CGRect screenRect;
    CGFloat screenWidth;
    CGFloat ImageHt;
    
    AppDelegate *appD;
    
    
    IBOutlet UILabel *HomeMountain;
    IBOutlet UILabel *SkingLevel;
    IBOutlet UILabel *SnowingLevel;
    IBOutlet UILabel *FocusLabel;
    IBOutlet UILabel *AreaToImprove;
    IBOutlet UIScrollView *MainSroll;
    IBOutlet UIView *HiddenView;
    IBOutlet UILabel *NameLbl;
    IBOutlet UILabel *PlaceLbl;
    IBOutlet UIView *MainSubView;
    IBOutlet UIScrollView *imageScrollView;
    IBOutlet UIView *drawView,*subview1,*subview2,*subview3;
    
    
    UIPageControl *PageController;
    NSString    *serverCalling;
    NSString    *InTErID;
    NSString *profile_id;
    NSMutableDictionary *likeDict;
    NSMutableDictionary *dict;
    NSMutableArray  *TMPARY;
    NSMutableArray  *TMPIMGARY;
    NSArray *imagesArr;
    
    
}
@property (nonatomic, weak) IBOutlet ZLSwipeableView *swipeableView;



@property (nonatomic, strong) NSMutableDictionary  *dataFrom;
@property (nonatomic, strong) NSMutableArray  *listAry;
@property (nonatomic, strong) NSMutableArray  *ImgAry;




@end
