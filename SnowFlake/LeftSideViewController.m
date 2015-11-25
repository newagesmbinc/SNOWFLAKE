//
//  LeftSideViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "LeftSideViewController.h"

@interface LeftSideViewController ()

@end

@implementation LeftSideViewController



#pragma mark - System Method
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    megCountView.hidden=YES;
    megCountLabel.hidden=YES;
    [self serverCall];
    
    
}

#pragma mark - Server Call

-(void)serverCall{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
  
    
    
    
    
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"get_unread_msg\", \"parameters\": {\"user_id\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"]];
    NSLog(@"post------%@",postData);
    //
    [server sendServerRequests:postData];
   
    
    
}

#pragma mark - Server Response


-(void)ServerRequestProcessFinish:(NSString *)serverResponse
{

    if ([serverResponse isEqualToString:@"ERROR"]) {
        
      
        
        
    }else{
       
        NSData *data=[serverResponse dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSError *er;
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&er];
        NSLog(@"messageArray------%@",dict);
        
        
        if ([[dict objectForKey:@"status"]isEqual:@"true"] ) {
            
            megCountView.hidden=NO;
            megCountLabel.hidden=NO;
            megCountLabel.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"unread_msg"] ];
            
        }
        
       
    }
    
 
    
}


@end
