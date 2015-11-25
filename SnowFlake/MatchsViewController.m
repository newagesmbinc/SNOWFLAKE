//
//  MatchsViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "MatchsViewController.h"
#import "SCLAlertView.h"
#import "SWRevealViewController.h"
#import "UIImage+PolygonMasking.h"
#import "UIImageView+WebCache.h"
#import "UIBezierPath+ZEPolygon.h"
#import "DetailProfileViewController.h"
#import "ARKLoader.h"
#import "popup.h"
#import "ChatPageViewController.h"
#import "MyprofileViewController.h"
@interface MatchsViewController ()
{
    ARKLoader *ark;
    popup *type123;
}
@end

@implementation MatchsViewController

#pragma mark - System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    SWRevealViewController *revealController = [self revealViewController];
    //    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;    
    [DashBtn addTarget:revealController
                action:@selector(revealToggle:)
      forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    page=@"0";
    self.count = 0;
    aray=[[NSMutableArray alloc]init];
    
    NSLog(@"%@",appD.ServerData);
    
    HiddenView.hidden=YES;
    
    
    _Mysuggestions  =[[NSMutableArray alloc]init];
    
    [self.swipeableView discardAllSwipeableViews];
    self.navigationController.navigationBarHidden=YES;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    serverCalling=@"";
    
     [self serverCall];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




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




#pragma mark - Server Call



-(void)serverCall{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
  
    NSString *latitudeonserach;
    NSString *longitudeonserach;
    
    if ([appD.searchdata isEqualToString:@"base_location"]) {
        
        
        latitudeonserach= [standardUserDefaults objectForKey:@"lat"] ;
        longitudeonserach= [standardUserDefaults objectForKey:@"log"] ;
    }else{
        latitudeonserach= [standardUserDefaults objectForKey:@"lat2nd"] ;
        longitudeonserach= [standardUserDefaults objectForKey:@"log2nd"] ;
    }
    
    
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"get_my_suggestions\", \"parameters\": {\"user_id\": \"%@\",\"page\": \"%@\",\"lat\": \"%@\",\"long\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"],@"0",latitudeonserach,longitudeonserach];
    
    [server sendServerRequests:postData];
    [self startLoader];
    
    
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
        //NSLog(@"serverResponse %@",serverResponse);
        NSData *data=[serverResponse dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSError *er;
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&er];
        NSLog(@"messageArray------%@",dict);
        if ([serverCalling isEqual:@""]) {
         
        _Mysuggestions=[dict objectForKey:@"my_suggestions"];
        [aray removeAllObjects];        
      
        aray=[_Mysuggestions valueForKey:@"member_id"];
        
        aray=[[[aray reverseObjectEnumerator] allObjects] mutableCopy];
        
            if ([_Mysuggestions count]>0) {
                HiddenView.hidden=YES;
            }else{
                HiddenView.hidden=NO;        }
          
        
        
            
        self.swipeableView.delegate = self;
        self.swipeableView.dataSource = self;
        
        
        
        [drawView setNeedsDisplay];
        
        }else{
            
            serverCalling=@"";            if ([[dict objectForKey:@"matches_status"]isEqualToString:@"true"]) {
                
type123  = [[popup alloc]initWithFrame:CGRectMake(00,00, self.view.frame.size.width, self.view.frame.size.height)];
                likeDict=[dict objectForKey:@"message"];
                
               appD.matchImage=[[dict objectForKey:@"message" ]objectForKey:@"display_image"];
                
                [type123.meg addTarget:self action:@selector(messaging) forControlEvents:UIControlEventTouchUpInside];
                [type123.profile addTarget:self action:@selector(profile) forControlEvents:UIControlEventTouchUpInside];
                
                [type123.close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
                
                
                [self.view addSubview:type123  ];
                
                
                
            }
            
            
            
            
            
            
            
            
            
            
            serverCalling=@"";
        }
            
            
            
            
        }
        
    
        
  
}


#pragma mark - HideActions & Navigation





-(void)close{
    type123.hidden=YES;
}




-(void)messaging{
   
    ChatPageViewController *reveal =(ChatPageViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ChatPageViewController"];
    
        reveal.ChatingId=[likeDict objectForKey:@"reciver_id"];

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
-(void)hidden{
    
    
    NSLog(@"%lu",(unsigned long)self.count);
    if (self.count==[_Mysuggestions count]) {
        
        HiddenView.hidden=NO;
    }
}


#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    NSLog(@"did swipe in direction: %zd", direction);

    
   
    
    if (direction==4 ) {
        
     
      
        
   
        
        
    }
    
    if (direction==8 ) {
        
        
         [self didlike];       
        
        
    }
    if (self.count==[_Mysuggestions count]) {    [self performSelector:@selector(hidden) withObject:nil afterDelay:1];}
    
    
    
    
    
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
       didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
//    likeUnlikeImage.image = nil;
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x    %f", location.x);
    
    
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
   
    
    NSLog(@"swiping at location:  y %f", location.y);
    
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
    
    
    
    
    
    
    
    if (self.count < _Mysuggestions.count) {
        
        
        //self.count = 0;
        
        
        [aray removeLastObject];
        
        
        
        CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
        
        view.backgroundColor = [UIColor clearColor];
        
        
        
        UIView *contentView =
        [[[NSBundle mainBundle] loadNibNamed:@"CardContentView"
                                       owner:self
                                     options:nil] objectAtIndex:0];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        
        if(_Mysuggestions.count>0){
            
            
            
            
            
            NSDictionary *dict = [_Mysuggestions objectAtIndex:self.count];
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 230, 230)];
            
            imageView.clipsToBounds = YES;
            imageView.layer.cornerRadius=115;
            
            
            imageView.backgroundColor = [UIColor clearColor];
            
            imageView.image = [UIImage imageNamed:@"imageholder.png"];
            
            
            [view addSubview:imageView];
            
            
            
            UIImageView * imageViewFrnd = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 220, 220)];
            
            imageViewFrnd.clipsToBounds = YES;
            imageViewFrnd.layer.cornerRadius=110;
            
            
            imageViewFrnd.backgroundColor = [UIColor clearColor];
            
            [imageViewFrnd sd_setImageWithURL:[NSURL URLWithString:[dict  objectForKey:@"image"]]  placeholderImage:[UIImage imageNamed:@"ic_camera.png"]];
            
            
            
            [view addSubview:imageViewFrnd];
            UILabel *namelabel = [[UILabel alloc]init];
            
            namelabel.textAlignment = NSTextAlignmentCenter;
            
            [namelabel setFont:[UIFont fontWithName:@"Cabin-Medium" size:20]];
            
            
            
            namelabel.text = [dict objectForKey:@"first_name"];
            
            namelabel.frame = CGRectMake(10, 280, 240, 30);
            
            namelabel.textColor = [UIColor whiteColor];
            
            [view addSubview:namelabel];
            
            InTErID=[dict objectForKey:@"member_id"];
            
            
            
        }
        
        
        
        
        
        [view addSubview:subview1];
        
        
        self.count++;
        
        return view;
    }
    
    
    
    
    
    
    return nil;
    
    
    
}





#pragma mark - Button Action

-(IBAction)Info:(id)sender{

    if (self.count-1==[_Mysuggestions count]) {
        
        HiddenView.hidden=NO;
    }else{
        [aray removeLastObject];
        
      DetailProfileViewController *reveal =(DetailProfileViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailProfileViewController"];
    reveal.dataFrom=[_Mysuggestions objectAtIndex:self.count-1];
    
         reveal.listAry=aray;
    
    
    
    
    [self.navigationController pushViewController:reveal animated:YES];
 
    }
    
    
    
}

-(IBAction)like:(id)sender{


    
[self.swipeableView swipeTopViewToDown];
    
    
    
}

-(IBAction)dislike:(id)sender{

   [self.swipeableView swipeTopViewToUp];
}














       


@end
