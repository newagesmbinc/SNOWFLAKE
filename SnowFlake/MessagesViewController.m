//
//  MessagesViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "MessagesViewController.h"
#import "InboxTableViewCell.h"
#import "ChatPageViewController.h"
#import "ARKLoader.h"
#import "SCLAlertView.h"

@interface MessagesViewController ()
{
    ARKLoader *ark;
}
@end

@implementation MessagesViewController


#pragma mark - System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    
    SWRevealViewController *revealController = [self revealViewController];
   
    [revealController tapGestureRecognizer];
    
    
    [DashBtn addTarget:revealController
                action:@selector(revealToggle:)
      forControlEvents:UIControlEventTouchUpInside];
    
    
    
       _InboxTable.separatorColor = [UIColor clearColor];
   
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self serverCall];    
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
    
        NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"get_message_list\", \"parameters\": {\"user_id\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"]];
    NSLog(@"post------%@",postData);
    //
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
        
        serverData=[dict objectForKey:@"message_list"];
        if ([serverData count]>0) {
            _noMatchView.hidden=YES;
        }else{
            _noMatchView.hidden=NO;        }
    
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

    return 90;
    
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    
    static NSString *myCellIdentifier = @"InboxTableViewCell";
    
    
    
    InboxTableViewCell *cell = (InboxTableViewCell *)[tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
    
    
    
    if (cell == nil) {
        
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"InboxTableViewCell" owner:self options:nil];
        
        cell = [array objectAtIndex:0];
        
    }
    cell.ChatImage.layer.masksToBounds = YES;
    cell.ChatImage.layer.cornerRadius=30;
    [cell.ChatImage sd_setImageWithURL:[NSURL URLWithString:[[serverData objectAtIndex:indexPath.row] objectForKey:@"display_image"]]  placeholderImage:[UIImage imageNamed:@"ic_camera.png"]];
  
    NSString *myString =[[serverData objectAtIndex:indexPath.row] objectForKey:@"ago"];
    
    const char *jsonString = [[[serverData objectAtIndex:indexPath.row] objectForKey:@"message"] UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *message123 = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    
    cell.ChatDtals.text=message123;
    
    cell.Date.text=myString;
    
    cell.ChatName.text=[[serverData objectAtIndex:indexPath.row] objectForKey:@"display_name"];
  
    if ([[[serverData objectAtIndex:indexPath.row] objectForKey:@"unread_count"]integerValue]>0) {
   
        cell.Nofitn.text=[[serverData objectAtIndex:indexPath.row] objectForKey:@"unread_count"];}else{
            cell.NotView.hidden=YES;        }
    
    if (![[[serverData objectAtIndex:indexPath.row] objectForKey:@"read_status"]isEqualToString:@"N"]) {
        cell.NotView.hidden=YES;
    }
    
    
    
    return cell;
    
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
    rowselect=indexPath.row;
    
    
    ChatPageViewController *reveal =(ChatPageViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ChatPageViewController"];
    
    reveal.ChatingId=[[serverData objectAtIndex:rowselect]objectForKey:@"reciver_id"];
    
    reveal.ChatingDETAILS=[serverData objectAtIndex:rowselect];
    
    
    
    [self.navigationController pushViewController:reveal animated:YES];
 
}


#pragma mark -  UIStoryboard Segue Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        if ([[segue identifier] isEqualToString:@"ChatPage"])
    {
        ChatPageViewController *vc = [segue destinationViewController];
        vc.ChatingId=[[serverData objectAtIndex:rowselect] objectForKey:@"from_id"];
        
        vc.ChatingDETAILS=[serverData objectAtIndex:rowselect];
    }
}













@end
