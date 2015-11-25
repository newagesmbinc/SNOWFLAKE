//
//  LocalResortViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 11/5/15.
//  Copyright © 2015 NewAgeSMB. All rights reserved.
//

#import "LocalResortViewController.h"
#import "SWRevealViewController.h"
#import "ARKLoader.h"
#import "SCLAlertView.h"
#import "LOCALTableViewCell.h"
#import "ResortMapView.h"

@interface LocalResortViewController ()
{
    int i;
    ARKLoader *ark;
}@end

@implementation LocalResortViewController

#pragma System Method

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    i=0;
    
    SWRevealViewController *revealController = [self revealViewController];
   [revealController tapGestureRecognizer];
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [DashBtn addTarget:revealController
                action:@selector(revealToggle:)
      forControlEvents:UIControlEventTouchUpInside];
    [self serverCall];
    _InboxTable.separatorColor = [UIColor clearColor];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }

#pragma Loader

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

#pragma Server Call



-(void)serverCall{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
  
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"get_resorts\", \"parameters\": {\"user_id\": \"%@\",\"lat\": \"%@\",\"long\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"],[standardUserDefaults objectForKey:@"lat"],[standardUserDefaults objectForKey:@"log"]];
    NSLog(@"post------%@",postData);
 
    [server sendServerRequests:postData];
    [self startLoader];
    
    
}

#pragma Server Response

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
        
        serverData=[dict objectForKey:@"resorts"];
     if ([serverData count]>0) {
            noResult.hidden=YES;
        }else{
            noResult.hidden=NO;        }
        [_InboxTable reloadData];
    }
    
}













#pragma mark - TableView

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

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    
    static NSString *myCellIdentifier = @"LOCALTableViewCell";
    
    
    
    LOCALTableViewCell *cell = (LOCALTableViewCell *)[tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
   
    if (cell == nil) {
        
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"LOCALTableViewCell" owner:self options:nil];
        
        cell = [array objectAtIndex:0];
        
    }
    
    
    NSLog(@"%@",[[serverData objectAtIndex:indexPath.row] objectForKey:@"display_image"]);
    
    
    cell.ResortName.text=[[serverData objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    
    
    cell.ResotLoc.text=[[serverData objectAtIndex:indexPath.row] objectForKey:@"location"];
    
    
    cell.resortdis.text=[NSString stringWithFormat:@"%@miles",[[serverData objectAtIndex:indexPath.row] objectForKey:@"distance"]];
    cell.megbutton.hidden=YES;
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

        UIView *cellContentView  = [cell contentView];
        CGFloat rotationAngleDegrees = -30;
        CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
        CGPoint offsetPositioning = CGPointMake(500, -20.0);
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, rotationAngleRadians, -50.0, 0.0, 1.0);
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
        cellContentView.layer.transform = transform;
        cellContentView.layer.opacity = 0.8;
        
        [UIView animateWithDuration:.65 delay:0.0 usingSpringWithDamping:0.85 initialSpringVelocity:.8 options:0 animations:^{
            cellContentView.layer.transform = CATransform3DIdentity;
            cellContentView.layer.opacity = 1;
        } completion:^(BOOL finished) {}];

}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    ResortMapView *reveal =(ResortMapView *)[self.storyboard instantiateViewControllerWithIdentifier:@"ResortMapView"];
    
    reveal.Mysuggestions=[serverData objectAtIndex:indexPath.row];
                          [self.navigationController pushViewController:reveal animated:YES];
    
    
 
}

@end
