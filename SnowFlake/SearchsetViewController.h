//
//  SearchsetViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/27/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerRequests.h"
#import "annotationclass.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "NMRangeSlider.h"



@interface SearchsetViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation,ServerRequestProcessDelegate>{
    AppDelegate *appDelegate;
    
    
    
    
    IBOutlet UIButton *femaleBtn;
    IBOutlet UIButton *maleBtn;
    IBOutlet UIButton *cuntBtn;
    IBOutlet UIButton *baseBtn;
    IBOutlet UIButton *tapmap;
    IBOutlet UIButton *preferredBtn;
    
    
    IBOutlet UILabel *sliderDisValue;
    IBOutlet UILabel *sliderAgeValue;
    IBOutlet UILabel *cuntLoctn,*baseLocation,*setlocatin;
    
    
    IBOutlet UIView  *AgeView;
    
    
    
    CLLocationManager *locationManager;
    CLLocation *locationFromLM;
    float   latitude,longitude ;
    double lat;
    double lng;
    
    IBOutlet NMRangeSlider *RangeSlider;
    
    NSString *locId;
    NSString *male;
    NSString *female;
    NSString *titleStr;
    NSString *Str1;
    NSString *Str2;
    NSString *str;
    NSString *Str;



}

@property (strong, nonatomic) IBOutlet MKMapView *mapView1;

@property(nonatomic,retain)  annotationclass *myAnnotation1;
@property (strong, nonatomic) IBOutlet UISlider *actionDisSlider;
@property (strong, nonatomic) IBOutlet UISlider *actionAgeSlider;


- (IBAction)femaleAction:(id)sender;
- (IBAction)maleAction:(id)sender;


@end
