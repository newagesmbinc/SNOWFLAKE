//
//  DetailProfileViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/9/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "DetailProfileViewController.h"
#import "UIImage+PolygonMasking.h"
#import "UIBezierPath+ZEPolygon.h"
#import "UIImageView+WebCache.h"
#import "SCLAlertView.h"
#import "popup.h"
#import "ChatPageViewController.h"
#import "MyprofileViewController.h"
#import "ARKLoader.h"
@interface DetailProfileViewController ()
{
    ARKLoader *ark;
    popup *type123;
}@end

@implementation DetailProfileViewController

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
    
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
   
    
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;    
    
   HiddenView.hidden=YES;    
    
   
    
    
    dict=[_dataFrom mutableCopy];
    
    
    
    profile_id=[_listAry lastObject ];
    
   
    
    
  
    
    self.swipeableView.delegate = self;
    self.swipeableView.dataSource = self;
    
    
    
    [drawView setNeedsDisplay];
    
    
    
    
     [MainSroll setContentSize:CGSizeMake(MainSroll.bounds.size.width, 495)];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Server call

-(void)requestData{
         
         

         
         
  if(![profile_id isEqual:@""]||![profile_id isEqual:[NSNull null]])
  {
      
      
      
      if (_listAry>0) {
      
             ServerRequests *server=[[ServerRequests alloc]init];
             server.server_req_proces=self;
             
             
             
             
             
             NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"get_profile\", \"parameters\": {\"user_id\": \"%@\"},\"token\":\"\"}",  profile_id];
             NSLog(@"post------%@",postData);
             
             [server sendServerRequests:postData];
      }
  }
         
             
             
             
         
         
         
         
         
         
         
     }

-(void)didlike{
    NSString *postData;
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [self startLoader];
    
    serverCalling=@"Like";
    
    postData =[[NSString alloc] initWithFormat:@"{\"function\":\"add_intrested_list\", \"parameters\": {\"user_id\": \"%@\",\"interested_user_id\": \"%@\"},\"token\":\"\"}", [standardUserDefaults objectForKey:@"user_id"],InTErID];
    NSLog(@"post------%@",postData);
    
    [server sendServerRequests:postData];
}













#pragma mark - Server Response

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
        
        NSDictionary *dictAry =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&er];
        NSLog(@"messageArray------%@",dictAry);
        
        
        if ([serverCalling isEqual:@""]) {
            [_listAry removeLastObject];
        profile_id=[_listAry lastObject ];
        dict=[dictAry mutableCopy];
     
        }else{
            
             serverCalling=@"";
            
            if ([[dictAry objectForKey:@"matches_status"]isEqualToString:@"true"]) {
                
           type123 = [[popup alloc]initWithFrame:CGRectMake(00,00, self.view.frame.size.width, self.view.frame.size.height)];
                likeDict=[dictAry objectForKey:@"message"];
                
                appD.matchImage=[[dict objectForKey:@"message" ]objectForKey:@"display_image"];
                 [type123.close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
                [type123.meg addTarget:self action:@selector(messaging) forControlEvents:UIControlEventTouchUpInside];
                [type123.profile addTarget:self action:@selector(profile) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:type123  ];
                
                
                
            }
            
        
       
        
   
    }
    
    }
    
    
    
    
    
    
    
    
    
    
}

#pragma mark - HideActions & Navigation

-(void)hidden{
    HiddenView.hidden=NO;
    MainSroll.hidden=YES;
}

-(void)close{
    type123.hidden=YES;
}
-(void)messaging{
    
    ChatPageViewController *reveal =(ChatPageViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ChatPageViewController"];
    
    reveal.ChatingId=[likeDict objectForKey:@"reciver_id"];
    //
    reveal.ChatingDETAILS=likeDict;
     [self close];
    
    [self.navigationController pushViewController:reveal animated:YES];
    
    
    
}

-(void)profile{
    
    
    MyprofileViewController *reveal =(MyprofileViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MyprofileViewController"];
    
    reveal.FROMMTSELF=@"pop";
    reveal.loginid=[likeDict objectForKey:@"reciver_id"];
    
     [self close];    
    [self.navigationController pushViewController:reveal animated:YES];
    
    
}










-(IBAction)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}









#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
   
    
    
    
    if (direction==4 || direction == 8) {
        
        if (direction==4 ) {
            
            
            
            
            
            
            
        }
        
        if (direction==8 ) {
            
            
            [self didlike];       
            
            
        }
        
  
        
        
        
        
       
        
        
    }}
   








- (void)swipeableView:(ZLSwipeableView *)swipeableView
       didCancelSwipe:(UIView *)view {
    
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
 
    
    
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    
    
    if (location.x>180) {
        
        
              
        
    }
    
    
    if (location.x<50){
        
        
            }
    
    
    
    
    
    
    
    if (location.y<10 || location.y>300) {
        
               
    }
    
    
    if (location.x>50 && location.x <180 && location.y>10  && location.y<300){
        
               
        
    }
    
    
    
    
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
 
    
    
}

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    
    
    
    
    
    
    if ([[dict  objectForKey:@"mountains_name"] isEqualToString:@""]) {
        [self performSelector:@selector(hidden) withObject:nil afterDelay:.5];    }
    
    
    HomeMountain.text=[dict  objectForKey:@"mountains_name"];
    
    NameLbl.text=[NSString stringWithFormat:@"%@, %@",[dict objectForKey:@"first_name"],[dict objectForKey:@"age"]];
    PlaceLbl.text=[dict objectForKey:@"location"];
    
    InTErID=[dict objectForKey:@"member_id"];
    SkingLevel.text=[dict  objectForKey:@"skiing_name"];
    
    SnowingLevel.text=[dict  objectForKey:@"snowboarding_name"];
    
    
    NSArray *dict2=[dict   objectForKey:@"focus_on_name_array"];
    NSArray *dict1=[dict   objectForKey:@"area_to_improve_name_array"];
    
    NSMutableString* result = [NSMutableString stringWithCapacity:150];
    for (int i = 0; i < [dict2 count]; i++) {
        [result appendFormat:@"%@\n", [dict2 objectAtIndex:i]];
    }
    
    NSMutableString* result1 = [NSMutableString stringWithCapacity:150];
    for (int i = 0; i < [dict1 count]; i++) {
        [result1 appendFormat:@"%@\n", [dict1 objectAtIndex:i]];
    }
    
    
    
    FocusLabel.text=result;
    AreaToImprove.text=result1;
    
    [FocusLabel sizeToFit];
    
    
    [AreaToImprove sizeToFit];
    
    
    
    
    
    CardView *view = [[CardView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 280)];
    
    view.backgroundColor = [UIColor clearColor];
    
    //    swipeableView.direction=ZLSwipeableViewDirectionDown;
    UIView *contentView =
    [[[NSBundle mainBundle] loadNibNamed:@"CardContentView"
                                   owner:self
                                 options:nil] objectAtIndex:0];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    imageScrollView = [[UIScrollView alloc]initWithFrame:view.bounds];
    
    imageScrollView.backgroundColor=[UIColor clearColor];
    
    imagesArr=[dict objectForKey:@"image_gallery"];
    int imagesNum =[imagesArr count];
    imageScrollView.delegate  =self;
    PageController.numberOfPages = [imagesArr count];
    imageScrollView.pagingEnabled=YES;
    
    if ([imagesArr count]>0) {
        
        imageScrollView.contentSize = CGSizeMake(screenWidth*imagesNum, imageScrollView.frame.size.height);
        
        
        for (int i=0; i<[imagesArr count]; i++) {
            
            
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*screenWidth, 0, screenWidth, 280)];
            [imgView sd_setImageWithURL:[NSURL URLWithString:[imagesArr objectAtIndex:i]]placeholderImage:nil];
            
            [imageScrollView addSubview:imgView];
        }
    }
    
    
    
    
    
    
    [view addSubview:imageScrollView];
    
    UILabel *namelabel1 = [[UILabel alloc]init];
    
    namelabel1.textAlignment = NSTextAlignmentLeft;
    
    [namelabel1 setFont:[UIFont fontWithName:@"Cabin-Medium" size:20]];
    
    
    
    namelabel1.text = [dict objectForKey:@"location"];
    
    namelabel1.frame = CGRectMake(10, 200, 240, 30);
    
    namelabel1.textColor = [UIColor whiteColor];
    
    [view addSubview:namelabel1];
    
    
    
    
    
    
    UILabel *namelabel = [[UILabel alloc]init];
    
    namelabel.textAlignment = NSTextAlignmentLeft;
    
    [namelabel setFont:[UIFont fontWithName:@"Cabin-Medium" size:20]];
    
    
    
    namelabel.text = [NSString stringWithFormat:@"%@, %@",[dict objectForKey:@"first_name"],[dict objectForKey:@"age"]];
    
    namelabel.frame = CGRectMake(10, 180, 240, 30);
    
    namelabel.textColor = [UIColor whiteColor];
    
    [view addSubview:namelabel];
    
    
    PageController = [[UIPageControl alloc] init];
    PageController.frame = CGRectMake(view.frame.size.width-75, 190, 50, 20);
    PageController.numberOfPages = [imagesArr count];
    
    
    
    PageController.pageIndicatorTintColor = [UIColor whiteColor];
    PageController.currentPageIndicatorTintColor = [UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];
    PageController.backgroundColor = [UIColor clearColor];
    
    
    [view addSubview:PageController];
    
    
    
    
    
    
    
    
    
    [view addSubview:subview1];
    [self.view bringSubviewToFront:MainSroll];
    [self performSelector:@selector(requestData) withObject:nil afterDelay:.5];
    return view;
}




#pragma mark - Button action



-(IBAction)like:(id)sender{
    
    
    //    [self didlike];
    
    [self.swipeableView swipeTopViewToDown];
    
    
    
}

-(IBAction)dislike:(id)sender{
    
    [self.swipeableView swipeTopViewToUp];
}


#pragma mark - ScrollDelegate


- (void)scrollViewDidScroll:(UIScrollView *)sender

{ if (imageScrollView){
    CGFloat pageSize = screenWidth;
    
    if (imageScrollView.contentOffset.x>pageSize*[imagesArr count]) {
        
        
    }
    
    else {
        
        int page = floor((imageScrollView.contentOffset.x - pageSize / 2) / pageSize) + 1;
        
       
        
        
        
        PageController.currentPage = page;
        PageController.pageIndicatorTintColor = [UIColor whiteColor];
         PageController.currentPageIndicatorTintColor =[UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];
        PageController.backgroundColor = [UIColor clearColor];
        
        
        
        
    }
}
}


@end
