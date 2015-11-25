//
//  MyprofileViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "MyprofileViewController.h"
#import "UIImageView+WebCache.h"
#import "EditPrViewController.h"
#import "ARKLoader.h"
#import "SCLAlertView.h"


@interface MyprofileViewController ()
{
    ARKLoader *ark;
}@end

@implementation MyprofileViewController

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
   self.navigationController.navigationBarHidden=YES;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController tapGestureRecognizer];
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;    
    [DashBtn addTarget:revealController
                action:@selector(revealToggle:)
      forControlEvents:UIControlEventTouchUpInside];
 screenRect = [[UIScreen mainScreen] bounds];
screenWidth = screenRect.size.width;
    
     fullview.hidden=YES;
    
    
    serverCalled=@"";
    
    
    if ([_FROMMTSELF isEqualToString:@"Yes"]) {
        DashBtn.hidden=YES;
        navImage.hidden=YES;

         editLevel.image=[UIImage imageNamed:@"flag.png"];
        
        
        disPlayData=[_FROMMM mutableCopy];
    } else if ([_FROMMTSELF isEqualToString:@"pop"]) {
        DashBtn.hidden=YES;
        navImage.hidden=YES;

        editLevel.image=[UIImage imageNamed:@"flag.png"];
        
      
        [self serverCall];
    }
    
    
    
    else{
        
        backBtn.hidden=YES;
        backImage.hidden=YES    ;
        disPlayData =appD.ServerData;}
    
  
}

-(void)viewWillAppear:(BOOL)animated    {

    
    HomeMountain.text=[[disPlayData objectForKey:@"profile"]objectForKey:@"mountains_name"];
    
    NameLbl.text=[NSString stringWithFormat:@"%@, %@",[disPlayData objectForKey:@"first_name"],[disPlayData objectForKey:@"age"]];
    PlaceLbl.text=[disPlayData objectForKey:@"location"];
    
    
    SkingLevel.text=[[disPlayData objectForKey:@"profile"]objectForKey:@"skiing_name"];
    
    SnowingLevel.text=[[disPlayData objectForKey:@"profile"]objectForKey:@"snowboarding_name"];
    
    
    NSArray *dict=[[disPlayData objectForKey:@"profile"]objectForKey:@"focus_on_name_array"];
    NSArray *dict1=[[disPlayData objectForKey:@"profile"]objectForKey:@"area_to_improve_name_array"];
    
    NSMutableString* result = [NSMutableString stringWithCapacity:150];
    for (int i = 0; i < [dict count]; i++) {
        [result appendFormat:@"%@\n", [[dict objectAtIndex:i]objectForKey:@"name"]];
    }
    
    NSMutableString* result1 = [NSMutableString stringWithCapacity:150];
    for (int i = 0; i < [dict1 count]; i++) {
        [result1 appendFormat:@"%@\n", [[dict1 objectAtIndex:i]objectForKey:@"name"]];
    }

    
    FocusLabel.text=result;
    AreaToImprove.text=result1;
    
    
    [FocusLabel sizeToFit];
    
    
    [AreaToImprove sizeToFit];
 
    
    
    
    
    
    
    
     imagesArr=[disPlayData objectForKey:@"image_gallery"];
    int imagesNum =[imagesArr count];
    
    PageController.numberOfPages = [imagesArr count];
    PageController.pageIndicatorTintColor = [UIColor whiteColor];
    PageController.currentPageIndicatorTintColor = [UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];
    
    
    if ([imagesArr count]>0) {
        
        imageScrollView.contentSize = CGSizeMake(screenWidth*imagesNum, imageScrollView.frame.size.height);
        
        if (screenRect.size.height<570) {
            ImageHt=260;
        }else if(screenRect.size.height>670)
        {
            ImageHt=350;        }else{
                ImageHt=320;            }
        
        for (int i=0; i<[imagesArr count]; i++) {
            
          
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*screenWidth, 0, screenWidth, ImageHt)];
            [imgView sd_setImageWithURL:[NSURL URLWithString:[imagesArr objectAtIndex:i]]placeholderImage:nil];
            
            [imageScrollView addSubview:imgView];
        }
    }

    
    [MainSroll setContentSize:CGSizeMake(MainSroll.bounds.size.width, 495)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Server Call

-(void)serverCall{
    
    
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;

    
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"get_profile\", \"parameters\": {\"user_id\": \"%@\"},\"token\":\"\"}",_loginid];
    
    [server sendServerRequests:postData];
    [self startLoader];
    
    
}






-(void)reportCall{
    
    serverCalled=@"Yes";
     NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
       NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"report_user\", \"parameters\": {\"user_id\": \"%@\",\"reported_user_id\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"],_loginid];
    NSLog(@"post------%@",postData);

    [server sendServerRequests:postData];
    [self startLoader];
    
    
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
        
        NSDictionary *dict2 =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&er];
       
        
        
        if ([serverCalled isEqualToString:@""]) {
       
        
        disPlayData=[dict2 mutableCopy];
        
        
        HomeMountain.text=[[disPlayData objectForKey:@"profile"]objectForKey:@"mountains_name"];
        
        NameLbl.text=[NSString stringWithFormat:@"%@, %@",[disPlayData objectForKey:@"first_name"],[disPlayData objectForKey:@"age"]];
        PlaceLbl.text=[disPlayData objectForKey:@"location"];
        
        
        SkingLevel.text=[[disPlayData objectForKey:@"profile"]objectForKey:@"skiing_name"];
        
        SnowingLevel.text=[[disPlayData objectForKey:@"profile"]objectForKey:@"snowboarding_name"];
        
        
        NSArray *dict=[[disPlayData objectForKey:@"profile"]objectForKey:@"focus_on_name_array"];
        NSArray *dict1=[[disPlayData objectForKey:@"profile"]objectForKey:@"area_to_improve_name_array"];
        
        NSMutableString* result = [NSMutableString stringWithCapacity:150];
        for (int i = 0; i < [dict count]; i++) {
            [result appendFormat:@"%@\n", [[dict objectAtIndex:i]objectForKey:@"name"]];
        }
        
        NSMutableString* result1 = [NSMutableString stringWithCapacity:150];
        for (int i = 0; i < [dict1 count]; i++) {
            [result1 appendFormat:@"%@\n", [[dict1 objectAtIndex:i]objectForKey:@"name"]];
        }
        
        
        FocusLabel.text=result;
        AreaToImprove.text=result1;
        
        
        [FocusLabel sizeToFit];
        
        
        [AreaToImprove sizeToFit];
        
        
        
        
        
        
        
        
        imagesArr=[disPlayData objectForKey:@"image_gallery"];
        int imagesNum =[imagesArr count];
        
        PageController.numberOfPages = [imagesArr count];
        PageController.pageIndicatorTintColor = [UIColor whiteColor];
        PageController.currentPageIndicatorTintColor = [UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];
        
        
        if ([imagesArr count]>0) {
            
            imageScrollView.contentSize = CGSizeMake(screenWidth*imagesNum, imageScrollView.frame.size.height);
            
            if (screenRect.size.height<570) {
                ImageHt=260;
            }else if(screenRect.size.height>670)
            {
                ImageHt=350;        }else{
                    ImageHt=320;            }
            NSLog(@"%f",ImageHt);
            for (int i=0; i<[imagesArr count]; i++) {
                
                
                
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*screenWidth, 0, screenWidth, ImageHt)];
                [imgView sd_setImageWithURL:[NSURL URLWithString:[imagesArr objectAtIndex:i]]placeholderImage:nil];
                
                [imageScrollView addSubview:imgView];
            }
        }
        
        
        
        
        
        }else{
            
                serverCalled=@"";
            
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            
            [alert showInfo:self title:@"Report User"
                   subTitle:[dict2 objectForKey:@"message"]
           closeButtonTitle:@"OK" duration:0.0f];
            
            
        }
        
        
        
        
        
        
        
        
    }

}




#pragma mark - Button Action & Navigation

-(IBAction)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)edit:(id)sender{
    if ([_FROMMTSELF isEqualToString:@"Yes"]) {
        
        
        [self reportCall];
        
    }else if ([_FROMMTSELF isEqualToString:@"pop"]) {
        
        [self reportCall];
        
    }
    
    
    else{
        
        EditPrViewController *task = [[EditPrViewController alloc]initWithNibName:@"EditPrViewController" bundle:nil];
        
        [self.navigationController pushViewController:task animated:YES];}
}


- (void)highlightLetter {
   
    
    
    
    
    NameLbl1.text=[NSString stringWithFormat:@"%@, %@",[disPlayData objectForKey:@"first_name"],[disPlayData objectForKey:@"age"]];
    PlaceLbl1.text=[disPlayData objectForKey:@"location"];
    
    imagesArr=[disPlayData objectForKey:@"image_gallery"];
    int imagesNum =[imagesArr count];
    
    PageController1.numberOfPages = [imagesArr count];
    PageController1.pageIndicatorTintColor = [UIColor whiteColor];
    PageController1.currentPageIndicatorTintColor = [UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];
    
    if ([imagesArr count]>0) {
        
        imageScrollView1.contentSize = CGSizeMake(screenWidth*imagesNum, imageScrollView1.frame.size.height);
        
       
        for (int i=0; i<[imagesArr count]; i++) {
            
            
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*screenWidth, 0, screenWidth, imageScrollView1.frame.size.height)];
            [imgView sd_setImageWithURL:[NSURL URLWithString:[imagesArr objectAtIndex:i]]placeholderImage:nil];
            
            [imageScrollView1 addSubview:imgView];
        }
    }
    
    
    [fullview bringSubviewToFront:NameLbl1];
    [fullview bringSubviewToFront:PlaceLbl1];
    [fullview bringSubviewToFront:PageController1];
    [fullview bringSubviewToFront:closeBtn];
    
    
    
    
    
    
      fullview.hidden=NO;}








-(IBAction)close:(id)sender{
    
    fullview.hidden=YES;
    
}

#pragma mark - Scroll Delegate


- (void)scrollViewDidScroll:(UIScrollView *)sender

{ if (imageScrollView){
    CGFloat pageSize = screenWidth;
    
    if (imageScrollView.contentOffset.x>pageSize*[imagesArr count]) {
        
   
        
    }
    
    else {
        
        int page = floor((imageScrollView.contentOffset.x - pageSize / 2) / pageSize) + 1;
        
    
        
        
        
        PageController.currentPage = page;
        PageController.pageIndicatorTintColor = [UIColor whiteColor];
        PageController.currentPageIndicatorTintColor = [UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];
        PageController.backgroundColor = [UIColor clearColor];
    
    
    
    
    }
}
    if (imageScrollView1){
        CGFloat pageSize = screenWidth;
        
        if (imageScrollView1.contentOffset.x>pageSize*[imagesArr count]) {
            
            //do whatever u want...
            
        }
        
        else {
            
            int page = floor((imageScrollView1.contentOffset.x - pageSize / 2) / pageSize) + 1;
            
            //NSLog(@"%d",page);
            
            
            
            PageController1.currentPage = page;
            PageController1.pageIndicatorTintColor = [UIColor whiteColor];
            PageController1.currentPageIndicatorTintColor = [UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];
            PageController1.backgroundColor = [UIColor clearColor];
            
            
            
            
        }
    }
  
    
    
    
    
}





@end
