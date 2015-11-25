//
//  Registration.m
//  nthemix
//
//  Created by NewAgeSMB on 9/27/12.
//
//

#import "Registration.h"

@implementation Registration


@synthesize email,password,devicetoken,facebook_unique_id;


-(void)add_user{
    
    
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    NSString *urlString;
    
    
    urlString =[NSString stringWithFormat:@"%@client/registration",appDelegate.ServerURL];
    
    
    
    
    
    
    
    
    
    
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    
    NSLog(@"urlString%@",urlString);
    
    [request setHTTPMethod:@"POST"];
    
    [request setTimeoutInterval:100];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    /* $_POST['user_id'] = '7';
     $_POST['bike_type_id'] = '2';
     $_POST['manufacture_id'] = '7'; */
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n%@",self.email] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n%@",self.password] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"facebook_unique_id\"\r\n\r\n%@",self.facebook_unique_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"devicetoken\"\r\n\r\n%@",self.devicetoken] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 
    
    
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"token\"\r\n\r\n%@", @""] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    
    
    
    
    //  NSLog(@"image---%@",file);
    
    
    
    
    [request setHTTPBody:postbody];
    
    
    
    NSURLSessionConfiguration *sessionConfig =  [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session =  [NSURLSession sessionWithConfiguration:sessionConfig
                              
                                                           delegate:self
                              
                                                      delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *jsonData = [session dataTaskWithRequest:request];
    
    [jsonData resume];
    
    
}




    -(void)confirm_profile:(NSDictionary *)bits file:(NSData *)file{
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    NSString *urlString;
    
    
    urlString =[NSString stringWithFormat:@"%@client/conrim_facbook",appDelegate.ServerURL];
    
    
    
    
    
    
    
    
    
    
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    
    NSLog(@"urlString%@",urlString);
    
    [request setHTTPMethod:@"POST"];
            [request setTimeoutInterval:100];
        
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    /* $_POST['user_id'] = '7';
     $_POST['bike_type_id'] = '2';
     $_POST['manufacture_id'] = '7'; */
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"first_name\"\r\n\r\n%@",self.firstName] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"marital_status\"\r\n\r\n%@",self.marital_status] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        
        
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n%@",self.user_id] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"dob\"\r\n\r\n%@",self.dob] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"gender\"\r\n\r\n%@",self.gender] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n%@",self.email] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"profilepic\"\r\n\r\n%@",self.profilepic] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"location\"\r\n\r\n%@",self.location] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"lat\"\r\n\r\n%@",self.lat] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"long\"\r\n\r\n%@",self.log] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"token\"\r\n\r\n%@", @""] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    
    
    
    
    //  NSLog(@"image---%@",file);
    
    //  NSLog(@"image---%@",file);
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\n", [bits objectForKey:@"filename"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[NSData dataWithData:file]];
    
    
    
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
   
    [request setHTTPBody:postbody];
    
    
    
        NSURLSessionConfiguration *sessionConfig =  [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session =  [NSURLSession sessionWithConfiguration:sessionConfig
                                  
                                                               delegate:self
                                  
                                                          delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURLSessionDataTask *jsonData = [session dataTaskWithRequest:request];
        
        [jsonData resume];
    
    
}


-(void)upload_photoes:(NSDictionary *)bits file:(NSData *)file{
    
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    NSString *urlString;
    
    
    urlString =[NSString stringWithFormat:@"%@client/upload_image",appDelegate.ServerURL];
    
    
    
    
    
    
    
    
    
    
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    
    NSLog(@"urlString%@",urlString);
    
    [request setHTTPMethod:@"POST"];
      [request setTimeoutInterval:100];
    
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
   
    
    
    
    
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n%@",self.user_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"token\"\r\n\r\n%@", @""] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    
    
    
    
    //  NSLog(@"image---%@",file);
    
    //  NSLog(@"image---%@",file);
    
    
    if ([appDelegate.addCount isEqualToString:@"1"]) {
        
    
    
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\n", [bits objectForKey:@"filename"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[NSData dataWithData:file]];
    
    
    
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }else if([appDelegate.addCount isEqualToString:@"2"]){
        
        
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image1\"; filename=\"%@\"\r\n", [bits objectForKey:@"filename"]] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[NSData dataWithData:file]];
        
        
        
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
    }
    else if([appDelegate.addCount isEqualToString:@"3"]){
        
        
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image2\"; filename=\"%@\"\r\n", [bits objectForKey:@"filename"]] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[NSData dataWithData:file]];
        
        
        
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
    }else if([appDelegate.addCount isEqualToString:@"4"]){
        
        
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image3\"; filename=\"%@\"\r\n", [bits objectForKey:@"filename"]] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[NSData dataWithData:file]];
        
        
        
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
    }else if([appDelegate.addCount isEqualToString:@"5"]){
        
        
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image4\"; filename=\"%@\"\r\n", [bits objectForKey:@"filename"]] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[NSData dataWithData:file]];
        
        
        
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
    }
    [request setHTTPBody:postbody];
    
    
    
    NSURLSessionConfiguration *sessionConfig =  [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session =  [NSURLSession sessionWithConfiguration:sessionConfig
                              
                                                           delegate:self
                              
                                                      delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *jsonData = [session dataTaskWithRequest:request];
    
    [jsonData resume];
    
    
}









- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    
    webData=nil;
    
    webData=[[NSMutableData alloc] init];
    
    [webData setLength:0];
    
    completionHandler(NSURLSessionResponseAllow);
}

 
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask  didReceiveData:(NSData *)data {
    
    [webData appendData:data];
}
 
//-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
//    
//    NSLog(@"Errorrrrr --- %@",error);
//    
//    
//    
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ERROR"  object:@"true"];
//
//	
//}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    
    if (error) {
        
        NSLog(@"Errorrrrr --- %@",error);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ERROR"  object:@"true"];
        
    }
    
    else {
        
        NSString *jsonString = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding] ;
        
        NSLog(@"DONE. Received Bytes: %@", jsonString);
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        
        [self.reg_proces RegistrationProcessFinish:jsonString];
        
    }
    
}





@end
