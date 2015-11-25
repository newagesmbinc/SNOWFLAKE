//
//  MMatchViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/21/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "MMatchViewController.h"
#import "ARKLoader.h"
#import "SCLAlertView.h"
#import "MyprofileViewController.h"
#import "LOCALTableViewCell.h"
#import "ChatPageViewController.h"
#import "UIImageView+WebCache.h"



@interface MMatchViewController ()
{
 ARKLoader *ark;
}
    

@end

@implementation MMatchViewController


#pragma mark - System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealController = [self revealViewController];
   
    
    [revealController tapGestureRecognizer];
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [DashBtn addTarget:revealController
                action:@selector(revealToggle:)
      forControlEvents:UIControlEventTouchUpInside];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(serverCall) name:@"ListDetails" object:nil];
    
    appD.cuerntView=@"MMatchViewController";
    
    [self serverCall];
    _table.separatorColor = [UIColor clearColor];

    
}
-(void)viewWillDisappear:(BOOL)animated{
    appD.cuerntView=@"";
    }




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"get_my_friends\", \"parameters\": {\"user_id\": \"%@\",\"page\": \"%@\",\"lat\": \"%@\",\"long\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"],@"0",latitudeonserach,longitudeonserach];
 
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
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&er];
        NSLog(@"messageArray------%@",dict);
        
        serverData=[dict objectForKey:@"my_friends"];

        
        if ([serverData count]>0) {
            _noMatchView.hidden=YES;
        }else{
            _noMatchView.hidden=NO;        }
        [_table reloadData];
    }
    
}


#pragma mark -  Navigation


- (void)meglike:(UIButton *)sender {
  
    
    
    ChatPageViewController *reveal =(ChatPageViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ChatPageViewController"];
    
    reveal.ChatingId=[[[serverData objectAtIndex:sender.tag] objectForKey:@"message"]objectForKey:@"reciver_id"];
    
    reveal.ChatingDETAILS=[[serverData objectAtIndex:sender.tag]objectForKey:@"message"];
    
    
    
    [self.navigationController pushViewController:reveal animated:YES];
    
    
    
}

#pragma mark - Table View



-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return 1;
    
}





- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)sectionn {
    
    
    
    return [serverData count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    return 70;
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIView *cellContentView = [cell contentView];
    CGFloat rotationAngleDegrees = -30;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPositioning = CGPointMake(0, cell.contentView.frame.size.height*4);
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, -50.0, 0.0, 1.0);
    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
    cellContentView.layer.transform = transform;
    cellContentView.layer.opacity = 0.8;
    
    [UIView animateWithDuration:0.65 delay:00 usingSpringWithDamping:0.85 initialSpringVelocity:0.8 options:0 animations:^{
        cellContentView.layer.transform = CATransform3DIdentity;
        cellContentView.layer.opacity = 1;
    } completion:^(BOOL finished) {}];
}




-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    MyprofileViewController *reveal =(MyprofileViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MyprofileViewController"];
    reveal.FROMMM=[[serverData objectAtIndex:indexPath.row] mutableCopy];
    
    reveal.loginid=[[[serverData objectAtIndex:indexPath.row] objectForKey:@"message"]objectForKey:@"reciver_id"];
    
     appD.cuerntView=@"";
    
    reveal.FROMMTSELF=@"Yes";
    
[self.navigationController pushViewController:reveal animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *myCellIdentifier = @"LOCALTableViewCell";
    
    
    
    LOCALTableViewCell *cell = (LOCALTableViewCell *)[tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
    
    
    
    if (cell == nil) {
        
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"LOCALTableViewCell" owner:self options:nil];
        
        cell = [array objectAtIndex:0];
        
    }
    
    cell.ResortName.text=[[serverData objectAtIndex:indexPath.row] objectForKey:@"first_name"];
    
    
    
    cell.ResotLoc.text=[[serverData objectAtIndex:indexPath.row] objectForKey:@"location"];
    
    
    cell.resortdis.text=[NSString stringWithFormat:@"%.fmiles",[[[serverData objectAtIndex:indexPath.row] objectForKey:@"distance"]floatValue]];
    cell.userimage.clipsToBounds = YES;
    cell.userimage.layer.cornerRadius=20;
    
     [cell.userimage sd_setImageWithURL:[NSURL URLWithString:[[serverData objectAtIndex:indexPath.row] objectForKey:@"image"]]placeholderImage:nil];    cell.megimage.hidden=YES;
     cell.arrowimage.hidden=YES;
    cell.megbutton.tag=indexPath.row;
     [cell.megbutton addTarget:self action:@selector(meglike:) forControlEvents:UIControlEventTouchUpInside];
    
        
    return cell;
}



@end
