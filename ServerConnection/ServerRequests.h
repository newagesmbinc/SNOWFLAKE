//
//  ServerRequests.h
//  Eatthos
//
//  Created by NewAgeSMB on 10/11/12.
//  Copyright (c) 2012 NewAgeSMB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@protocol ServerRequestProcessDelegate <NSObject>

-(void) ServerRequestProcessFinish:(NSString *) serverResponse;

@end

@interface ServerRequests : NSObject<NSURLSessionDelegate>  {
    
    //---web service access ---
    NSMutableData *webData;
    NSURLConnection *conn;
    NSURLSession *conn1;    
    
    NSMutableString *postStatus;
    
    AppDelegate *appDelegate;
    id<ServerRequestProcessDelegate> server_req_proces;
    
}

@property (nonatomic,retain) id<ServerRequestProcessDelegate> server_req_proces;


@property(strong,nonatomic)NSString *user_id,*login_id, *booked_id;

-(void)sendServerRequests:(NSString *) post_data;
-(void)sendServerRequests2:(NSString *) post_data;






@end

