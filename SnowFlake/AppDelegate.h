//
//  AppDelegate.h
//  SnowFlake
//
//  Created by NewAgeSMB on 9/30/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    
    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
    dispatch_queue_t backgroundQueue;
    NSString *hostItemToReach;
    NSMutableDictionary *megLike;
    NSDictionary *dict;
    UILabel *alertLabel;
    
    
}
@property (nonatomic, strong) NSString *ServerURL, *devicetoken;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) UIView *primaryView;
@property (nonatomic, strong) NSString *cuerntView;
@property (nonatomic, strong) NSMutableDictionary *ServerData;

@property (nonatomic, strong) NSMutableDictionary *ProfileData;
@property (nonatomic, strong) NSMutableArray *profilepicarray;

@property (nonatomic, strong) NSString *searchdata,*ssearchdata,*megCount;
@property (nonatomic, strong) NSString *emailID, *passwordId,*fb,*ToListID,*TODotaskId,*alertString,*frgnd,*backgud;
@property (strong, nonatomic) UIViewController *currentviewcontroller;


@property (nonatomic, strong) NSString *editProfile,*matchImage,*loginId;
@property (nonatomic, strong) NSString *addCount;
@property (nonatomic,assign)BOOL networkAvailable;

@property(nonatomic,weak) UINavigationController *navigationController;
-(void)updateInterfaceWithReachability: (Reachability*) curReach;
-(void)displayNetworkAvailability:(id)sender;
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

