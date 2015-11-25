//
//  ExploreViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/27/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import "AppDelegate.h"



@interface ExploreViewController : UIViewController
<MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate *appDelegate;
  
    
    IBOutlet  UITextField *address;
    
    IBOutlet  UIButton *setCurrent;
    IBOutlet UIButton *doneBtn;
    IBOutlet UIButton *donehide;
    
    IBOutlet  UIView    *setCunt;
    
    IBOutlet UIImageView *donehideimage;
    
    CLLocation *locationFromLM;
    CLLocationCoordinate2D testCntr;
    CLLocationManager *locationManager;
    float   latitude,longitude ;
    
    
    NSString *hide;
    BOOL isBack;
    
}
@property (strong, nonatomic)  MKMapView *mapView;
@property (nonatomic,retain) IBOutlet UITableView *NearByTableView;
@property(strong,nonatomic)NSMutableDictionary *placeDict;
@property (weak, nonatomic) IBOutlet UIButton *exploreBtn;
@property(strong,nonatomic) NSString *frmMyacunt;
@property(strong,nonatomic)NSMutableArray *placeArray;

- (IBAction)done_fn:(id)sender;


@end
