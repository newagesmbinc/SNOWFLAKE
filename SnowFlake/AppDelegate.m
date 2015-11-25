//
//  AppDelegate.m
//  SnowFlake
//
//  Created by NewAgeSMB on 9/30/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Reachability.h"
#include <netinet/in.h>
#include <arpa/inet.h>
#import "ServerRequests.h"
#import "SimplePinger.h"
#import "SCLAlertView.h"
#import "MMatchViewController.h"
#import "popup.h"
#import "ChatPageViewController.h"
#import "MyprofileViewController.h"
#import "SWRevealViewController.h"
#import "SCLAlertView.h"


@interface AppDelegate ()
{
    popup *type123;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//                 self.ServerURL = @"http://192.168.1.254/snowflake/";
    
    
    
    
    _ProfileData=[[NSMutableDictionary alloc]init];
    _addCount=@"";
    _ssearchdata=@"";
//   self.ServerURL = @"http://newagesme.com/snowflake/";
     self.ServerURL = @"http://52.27.246.44/";
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if (!hostItemToReach) {
        hostItemToReach=@"www.apple.com"; //start off somewhere familiar
    }
    [self mainItemsAfterLaunching];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];    
    
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        
        
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert) categories:nil];
        
        
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        
        
    }
    
    
    
    
    
    
    
    else{
        
        
        
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound |     UIRemoteNotificationTypeNewsstandContentAvailability;
        
        
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
        
        
        
    }
     _profilepicarray = [[NSMutableArray alloc] init];
    return YES;
}
- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    
    if(curReach == hostReach)
    {
        
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
        
        switch (netStatus)
        
        {
            case NotReachable:
            {
                NSLog(@"A gateway to the host server is down.");
                
                self.networkAvailable=NO;
                break;
                
            }
            case ReachableViaWiFi:
            {
                NSLog(@"A gateway to the host server is working via WIFI.");
                self.networkAvailable=YES;
                break;
                
            }
            case ReachableViaWWAN:
            {
                NSLog(@"A gateway to the host server is working via WWAN.");
                self.networkAvailable=YES;
                break;
                
            }
        }
    }
    if(self.networkAvailable)
    {
        
    }
    else{
        
        
    }
}

- (void) displayNetworkAvailability:(id)sender{
    
    
  
    [[NSNotificationCenter defaultCenter] postNotificationName:@"STOPLOADER"  object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NONETWORKFOUND"  object:nil];
    
    
   }

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


- (void) reachabilityChanged: (NSNotification* )note
{
    /* This method is called every time there is a change */
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    
   
    
    [self simplePingThis:hostItemToReach];
    
    [self updateInterfaceWithReachability: curReach];
}
-(void)clear_push{


  
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    ServerRequests *server=[[ServerRequests alloc]init];
        server.server_req_proces=nil;

    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"clear_push\", \"parameters\": {\"user_id\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"]];
    NSLog(@"post------%@",postData);

    [server sendServerRequests:postData];


}





- (void) simplePingThis:(NSString*) addressToPing
{
    NSLog(@"Going to Ping");
    
    
    backgroundQueue = dispatch_queue_create("com.elbsolutions.simpleping", NULL);
    
    dispatch_async(backgroundQueue, ^{
        
        /* Add the SImplePinger app into here */
        
        
        SimplePinger *mainObj = [[SimplePinger alloc] init];
        //mainObj.stopOnAnyError = true;
        assert(mainObj != nil);
        
        //[mainObj runWithHostName:[NSString stringWithUTF8String:argv[1]]];
        [mainObj runWithHostName:addressToPing];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            NSString *msg = @"";
            if ([mainObj reachedIpAddress]) {
                msg = [NSString stringWithFormat:@"Successful Ping of %@",addressToPing,nil];;
                
            } else {
                
                msg = [NSString stringWithFormat:@"No Response from %@",addressToPing,nil];;
               
            }
            
            NSLog(@"%@",msg);
            
            
        });
    });
    
    
}

-(void) mainItemsAfterLaunching
{
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    [self simplePingThis:hostItemToReach];
    
    
    struct sockaddr_in callAddress;
    callAddress.sin_len = sizeof(callAddress);
    callAddress.sin_family = AF_INET;
    callAddress.sin_port = htons(24);
    callAddress.sin_addr.s_addr = inet_addr([hostItemToReach UTF8String]);
    
    hostReach = [Reachability reachabilityWithAddress:&callAddress];
    
    
    [hostReach startNotifier];
    [self updateInterfaceWithReachability: hostReach];
    
    /* internetReach is an instance of Reachability */
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    [self updateInterfaceWithReachability: internetReach];
    
    /* wifiReach is an instance of Reachability */
    wifiReach = [Reachability reachabilityForLocalWiFi];
    [wifiReach startNotifier];
    [self updateInterfaceWithReachability: wifiReach];
    
    
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings



{

    
    [application registerForRemoteNotifications];
    
}





- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler

{
    
    //handle the actions
    
    if ([identifier isEqualToString:@"declineAction"]){
        
    }
    
    else if ([identifier isEqualToString:@"answerAction"]){
        
    }
    
    
    
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    //NSString *str = [NSString
    //stringWithFormat:@"Device Token=%@",deviceToken];
    NSString *strWithoutSpaces  = [NSString stringWithFormat:@"%@",deviceToken];
    strWithoutSpaces = [strWithoutSpaces stringByReplacingOccurrencesOfString:@" " withString:@""];
    strWithoutSpaces = [strWithoutSpaces stringByReplacingOccurrencesOfString:@"<" withString:@""];
    self.devicetoken = [strWithoutSpaces stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    
    NSLog(@" device token..........%@",self.devicetoken);
    
    
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    
    NSLog(@"remoteNotif--------%@",[userInfo objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]);
    
    
    
    NSLog(@"userInfo--------%@",userInfo);
    

    UINavigationController *navController =(UINavigationController *) self.window.rootViewController;
    UIViewController *lastViewController = [[navController viewControllers] lastObject];

        
    
   
    
   NSMutableDictionary * dict123 = [userInfo objectForKey:@"aps"];
    NSLog(@"%@",dict123);
    
    if ([UIApplication sharedApplication].applicationState==UIApplicationStateActive) {
        if ([[dict123 objectForKey:@"type"]isEqualToString:@"mutual_match"]) {
            if([_cuerntView isEqualToString:@"MMatchViewController"])
            {
                
                
                
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ListDetails"  object:nil];
            }
            _matchImage=[[dict123 objectForKey:@"details" ]objectForKey:@"display_image"];
            
            _loginId=[[dict123 objectForKey:@"details" ]objectForKey:@"reciver_id"];
            megLike=[dict123 objectForKey:@"details" ];
            
   type123 = [[popup alloc]initWithFrame:CGRectMake(00,00, self.window.frame.size.width, self.window.frame.size.height)];
  
            [type123.meg addTarget:self action:@selector(messaging) forControlEvents:UIControlEventTouchUpInside];
            [type123.profile addTarget:self action:@selector(profile) forControlEvents:UIControlEventTouchUpInside];
            
             [type123.close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
            
            [self.window addSubview:type123  ];
            
            
        } else if ([[dict123 objectForKey:@"type"]isEqualToString:@"new_message"]) {
            
            if([_cuerntView isEqualToString:@"ChatPageViewController"])
            {
                
            
           
            }else{
            NSString *meg=[dict123 objectForKey:@"alert"];
            
            
                const char *jsonString = [meg UTF8String];
                NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
                NSString *message123 = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[dict123 objectForKey:@"details"]objectForKey:@"from_name"] message:message123 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            }
            
        }
        
        
    }else
        if ([UIApplication sharedApplication].applicationState==UIApplicationStateInactive||[UIApplication sharedApplication].applicationState==UIApplicationStateBackground) {
            
            
            if([[dict123 objectForKey:@"type"]isEqualToString:@"mutual_match"]){
                
                
                if([lastViewController   isKindOfClass:[MMatchViewController class]])
                {
                    
                    
                    
                    
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ListDetails"  object:nil];
                }
                else {
                
               
                
                       MMatchViewController *reveal =(MMatchViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MMatchViewController"];
                    UINavigationController *navController =(UINavigationController *) self.window.rootViewController;
                    [navController pushViewController:reveal animated:YES];
                     }
                
                
            }
            
            
                        
            
            
            
            
            
            
        }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
}






- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];    [self clear_push];
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
 [FBSDKAppEvents activateApp];
     [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];    [self clear_push];    

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

-(void)messaging{
    
     ChatPageViewController *reveal =(ChatPageViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ChatPageViewController"];
    
    
    
    
    reveal.ChatingId=_loginId;
    
    reveal.ChatingDETAILS=megLike;
    
    [self close];
    
    UINavigationController *navController =(UINavigationController *) self.window.rootViewController;
    [navController pushViewController:reveal animated:YES];
    
    
}

-(void)profile{
    
   
    
    
    
    MyprofileViewController *reveal =(MyprofileViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MyprofileViewController"];
    
    reveal.FROMMTSELF=@"pop";
    reveal.loginid=_loginId;
    
     [self close];
    UINavigationController *navController =(UINavigationController *) self.window.rootViewController;
    [navController pushViewController:reveal animated:YES];
  
    
    
   
     
    
}

-(void)close{
    type123.hidden=YES;
}





#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.NewAgeSMB.SnowFlake" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SnowFlake" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SnowFlake.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
