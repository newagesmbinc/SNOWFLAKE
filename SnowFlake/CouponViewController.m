//
//  CouponViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "CouponViewController.h"
#import "SCLAlertView.h"
#import "ARKLoader.h"

@interface CouponViewController ()
{
    
    
    CGRect screenRect;
    CGFloat screenWidth;
    ARKLoader *ark;
    UICollectionViewCell *cel;
    


}
@end

@implementation CouponViewController


#pragma mark - System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    SWRevealViewController *revealController = [self revealViewController];
   [revealController tapGestureRecognizer];
    [DashBtn addTarget:revealController
                action:@selector(revealToggle:)
      forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
   
    _couponcollection.hidden=NO;
    NSString *sma=@"Snowflake must be the little white doe you decided to keep.";
    
        [_detailView setFrame:CGRectMake(8, 102, 304, 307)];
        
        _detailProductDis.text=sma;
        
        screenRect = [[UIScreen mainScreen] bounds];
        screenWidth = screenRect.size.width;
                 _detailBakgrd.hidden=YES;
        
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self requestCall];
    
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

-(void)requestCall{
    
    
    [self startLoader];
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *latitudeonserach;
    NSString *longitudeonserach;
    
    
    
    if ([appD.searchdata isEqualToString:@"base_location"]) {
        
        
        latitudeonserach= [standardUserDefaults objectForKey:@"lat"] ;
        longitudeonserach= [standardUserDefaults objectForKey:@"log"] ;
    }else{
        latitudeonserach= [standardUserDefaults objectForKey:@"lat2nd"] ;
        longitudeonserach= [standardUserDefaults objectForKey:@"log2nd"] ;
    }
    
    
    
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"get_coupons\", \"parameters\": {\"lat\": \"%@\",\"long\": \"%@\",\"user_id\": \"%@\"},\"token\":\"\"}",latitudeonserach,longitudeonserach,  [standardUserDefaults objectForKey:@"user_id"]];
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
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&er];
    
            
            serverDataCoupon=[dict objectForKey:@"coupons"];
        
        serverDataOffer=[dict objectForKey:@"offers"];
        
        if ([serverDataCoupon count]>0||[serverDataOffer count]>0) {
            _noMatchView.hidden=YES;
        }else{
            _noMatchView.hidden=NO;        }
        
        
        
        
        [_couponcollection  reloadData];
        
         [_offercollection  reloadData];
      
     
        }
        
 
    
}

- (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size

{
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_0)
        
    {
        
        CGRect labelRect = [text
                            boundingRectWithSize:size
                            options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{
                                         NSFontAttributeName : [UIFont systemFontOfSize:17]
                                         }
                            context:nil];
        
        return labelRect.size;
        
    }
    
    else{
        
        return [text sizeWithFont:font constrainedToSize:size];
        
    }
    
}

#pragma mark - Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        if(collectionView==_offercollection)
        {
            return [serverDataOffer count];
        }
        else
            return [serverDataCoupon count];
        
        
    }

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    CGSize calCulateSizze =self.view.bounds.size;
    
    calCulateSizze.width = calCulateSizze.width/2-10;
    calCulateSizze.height=175;
    return calCulateSizze;
}


    
    - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
    {
        if(collectionView==_couponcollection)
        {
            cel=[collectionView dequeueReusableCellWithReuseIdentifier:@"couponcell" forIndexPath:indexPath];
            
            
          
           
            NSLog(@"%@",[[serverDataCoupon objectAtIndex:indexPath.item]objectForKey:@"image"]);
          
           
            
            
            
            UIImageView *couponImage=(UIImageView *)[cel viewWithTag:1];
  
            
              [couponImage sd_setImageWithURL:[NSURL URLWithString:[[serverDataCoupon objectAtIndex:indexPath.item]objectForKey:@"image"]]  placeholderImage:[UIImage imageNamed:@"ic_camera.png"]];
            
            UILabel *offPercent=(UILabel *)[cel viewWithTag:2];
            
            offPercent.text=[NSString stringWithFormat:@"%@%%",[[serverDataCoupon objectAtIndex:indexPath.item]objectForKey:@"offer_prentage"]];
            UILabel *couponCode=(UILabel *)[cel viewWithTag:3];
            couponCode.text=[[serverDataCoupon objectAtIndex:indexPath.item]objectForKey:@"coupon_code"];
            
            UILabel *productDescription=(UILabel *)[cel viewWithTag:4];
            productDescription.text=[[serverDataCoupon objectAtIndex:indexPath.item]objectForKey:@"name"];
            
            
//            UILabel *OfferName=(UILabel *)[cel viewWithTag:6];
//            OfferName.text=[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"name"];
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        if(collectionView==_offercollection)
        {
            cel=[collectionView dequeueReusableCellWithReuseIdentifier:@"offercell" forIndexPath:indexPath];
            
            
            UIImageView *offerImage=(UIImageView *)[cel viewWithTag:1];
         
            
              [offerImage sd_setImageWithURL:[NSURL URLWithString:[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"image"]]  placeholderImage:[UIImage imageNamed:@"ic_camera.png"]];
            
            
            UILabel *offPercent=(UILabel *)[cel viewWithTag:2];
            
            offPercent.text=[NSString stringWithFormat:@"%@%%",[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"offer_prentage"]];
            UILabel *offerPrice=(UILabel *)[cel viewWithTag:3];
            offerPrice.text=[NSString stringWithFormat:@"$%@",[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"off_price"]];
            
            UILabel *productDescription=(UILabel *)[cel viewWithTag:4];
            productDescription.text=[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"name"];
            
            UILabel *oldPrice=(UILabel *)[cel viewWithTag:5];
            
            NSDictionary* attributes = @{
                                         NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]
                                         };
            
            NSAttributedString* attrText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"$%@",[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"price"]] attributes:attributes];
            oldPrice.attributedText = attrText;
            
            
            
            
            
//            oldPrice.text=[NSString stringWithFormat:@"$%@",[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"price"]];
//            UILabel *OfferName=(UILabel *)[cel viewWithTag:6];
//            OfferName.text=[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"name"];
        }
        
        return cel;
    }
    
    - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
    {
        
        _detailView.hidden=NO;
        _detailBakgrd.hidden=NO;
        
        
        if(collectionView==_offercollection)
        {OferView.hidden=NO;
            CoponView.hidden=YES;
            
            
            
            
             [_detailImage sd_setImageWithURL:[NSURL URLWithString:[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"image"]]  placeholderImage:[UIImage imageNamed:@"ic_camera.png"]];
            
            
            
            
            DETAILPRICLBL.text= [NSString stringWithFormat:@"%@%%",[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"offer_prentage"]];
            Pricedtail.text=[NSString stringWithFormat:@"$%@",[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"price"]];
            
            offpricelbl.text=[NSString stringWithFormat:@"$%@",[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"off_price"]];
            
            
            
            Descriptn.text=[[serverDataOffer objectAtIndex:indexPath.item]objectForKey:@"description"];

            
            
            
            
          
        }
        
        
        if(collectionView==_couponcollection)
        {
            OferView.hidden=YES;
            CoponView.hidden=NO;
            
             [_detailImage sd_setImageWithURL:[NSURL URLWithString:[[serverDataCoupon objectAtIndex:indexPath.item]objectForKey:@"image"]]  placeholderImage:[UIImage imageNamed:@"ic_camera.png"]];
            CopnCode.text=[[serverDataCoupon objectAtIndex:indexPath.item]objectForKey:@"coupon_code"];
            DETAILPRICLBL.text= [NSString stringWithFormat:@"%@%%",[[serverDataCoupon objectAtIndex:indexPath.item]objectForKey:@"offer_prentage"]];
            Descriptn.text=[[serverDataCoupon objectAtIndex:indexPath.item]objectForKey:@"description"];
            
           
        }
        
        
        
    }

#pragma mark - Button Action

    
    - (IBAction)coupons:(id)sender {
        [_couponcollection setContentOffset:CGPointZero animated:NO];
        _couponBarImage.hidden=NO;
        _offerBarImage.hidden=YES;
        _couponcollection.hidden=NO;
        _offercollection.hidden=YES;
    }
    
    - (IBAction)offers:(id)sender {
                 
        
        
        [_offercollection setContentOffset:CGPointZero animated:NO];
        _couponBarImage.hidden=YES;
        _offerBarImage.hidden=NO;
        _couponcollection.hidden=YES;
        _offercollection.hidden=NO;
    }
    - (IBAction)closeDetailView:(id)sender {
        _detailView.hidden=YES;
        _detailBakgrd.hidden=YES;
    }

    -(CGSize)labelsizefns:(NSString *)input
    {
        
        CGSize labelsize;
        
        UIFont *font = [UIFont systemFontOfSize:11];
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]
         initWithString:input
         attributes:@
         {
         NSFontAttributeName: font
         }];
        
        labelsize = [attributedText boundingRectWithSize:(CGSize){self.view.frame.size.width,CGFLOAT_MAX}
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                 context:nil].size;
        return labelsize;
        
        
    }
@end
    
