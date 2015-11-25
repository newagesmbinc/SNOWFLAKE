//
//  ExploreView.h
//  SnowFlake
//
//  Created by NewageSMB on 11/5/15.
//  Copyright © 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import "AppDelegate.h"



@interface ExploreView : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    AppDelegate *appDelegate;
    
    CLLocationManager *locationManager;
    
    float   latitude,longitude ;
    
    IBOutlet  UITextField *address;
    
    IBOutlet  UIButton *setCurrent;
    IBOutlet  UIView    *setCunt;
    
    
    
    CLLocation *locationFromLM;
    
    BOOL isBack;
    
    CLLocationCoordinate2D testCntr;
    
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)done_fn:(id)sender;

@property (nonatomic,retain) IBOutlet UITableView *NearByTableView;
@property(strong,nonatomic)NSMutableDictionary *placeDict;
@property (weak, nonatomic) IBOutlet UIButton *exploreBtn;

@property(strong,nonatomic)NSMutableArray *placeArray;

@end
