//
//  ServerRequests.m
//  Eatthos
//
//  Created by NewAgeSMB on 10/11/12.
//  Copyright (c) 2012 NewAgeSMB. All rights reserved.
//

//
//  ServerRequests.m
//  nthemix
//
//  Created by NewAgeSMB on 10/1/12.
//
//

#import "ServerRequests.h"
 

@implementation ServerRequests

@synthesize server_req_proces,user_id,login_id,booked_id;

-(void) sendServerRequests:(NSString *)post_data{
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (appDelegate.networkAvailable) {    
    
    
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
      //  NSLog(@"post_data==>%@",post_data);
    
        NSData *postData = [post_data dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
   
        
       [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@client",appDelegate.ServerURL]]];

        [request setTimeoutInterval:100];

        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
       
        
        [request setHTTPBody:postData];
    
//        conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//        if (conn) {
//            webData = [[NSMutableData alloc]init];
//        }
        NSURLSessionConfiguration *sessionConfig =  [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session =  [NSURLSession sessionWithConfiguration:sessionConfig
                                  
                                                               delegate:self
                                  
                                                          delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURLSessionDataTask *jsonData = [session dataTaskWithRequest:request];
        
        [jsonData resume];
        
        
        
    }
    else{
        
        [appDelegate displayNetworkAvailability:self];
    }
}

-(void) sendServerRequests2:(NSString *)post_data{
}
 



- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    
    webData=nil;
    
    webData=[[NSMutableData alloc] init];
    
    [webData setLength:0];
    
    completionHandler(NSURLSessionResponseAllow);
}
//Note that the preceding code initializes the length of webData to 0. As the data progressively comes in from the web service, the connection:didReceiveData: method will be called repeatedly. You use the method to append the data received to the webData object:

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask  didReceiveData:(NSData *)data {
    
    [webData appendData:data];
}
//If there is an error during the transmission, the connection:didFailWithError: method will be called:

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
    
   
    NSLog(@"errrooooorrrrrrrrr---%@",error);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ERROR"  object:@"true"];
   
    [self.server_req_proces ServerRequestProcessFinish:@"error"];

	
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    
    if (error) {
        
        NSLog(@"errrooooorrrrrrrrr---%@",error);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ERROR"  object:@"true"];
        
        [self.server_req_proces ServerRequestProcessFinish:@"error"];
        
    }
    
    else {
        
        NSString *jsonString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding] ;
        
        NSLog(@"DONE. Received Bytes: %@", jsonString);
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        
        [server_req_proces ServerRequestProcessFinish:jsonString];
    }
    
}
#pragma mark -MBHud Methods





@end
