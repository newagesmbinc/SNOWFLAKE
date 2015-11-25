//
//  ViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 9/30/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ServerRequests.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>

@interface LoginViewController : UIViewController<CLLocationManagerDelegate,ServerRequestProcessDelegate,MKMapViewDelegate>
{
 
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    AppDelegate *appD;
    NSMutableDictionary *storeTemp;
    NSMutableArray *storeTempImage;
}

@property(nonatomic, strong) CLLocationManager *locationManager;
@end

