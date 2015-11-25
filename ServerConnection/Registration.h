//
//  Registration.h
//  nthemix
//
//  Created by NewAgeSMB on 9/27/12.
//
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@protocol RegistrationProcess <NSObject>

-(void) RegistrationProcessFinish:(NSString *) userdetails;

@end




@interface Registration : NSObject<NSURLSessionDelegate> {
    
    //---web service access ---
    NSMutableData *webData;
    NSURLConnection *conn;
    NSMutableString *postStatus;
    
    AppDelegate *appDelegate;
    id<RegistrationProcess> reg_proces;
    
}




@property (nonatomic,retain) NSString *email,*password,*facebook_unique_id,*devicetoken;

@property (nonatomic,retain) NSString *firstName,*dob,*gender,*location,*user_id,*message,*marital_status,*profilepic,*lat,*lg;

@property (nonatomic,retain) NSString *event_id,*club_id,*club_type,*full_name,*no_boys,*no_girls,*details,*is_whatsapp,*event_date,*log;





// Change image
@property (nonatomic,retain) NSData *imgData;

@property (nonatomic,retain) NSData *imgData1;
@property (nonatomic,retain) NSData *imgData2;
@property (nonatomic,retain) NSData *imgData3;
@property (nonatomic,retain) NSData *imgData4;

@property (nonatomic,retain) id<RegistrationProcess> reg_proces;

-(void)add_user;
-(void)send_messages;
 -(void)confirm_profile:(NSDictionary *)bits file:(NSData *)file;
-(void)add_guest;

-(void)upload_photoes:(NSDictionary *)bits file:(NSData *)file;


@end
