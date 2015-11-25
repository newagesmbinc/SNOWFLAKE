//
//  ResortMapView.h
//  SnowFlake
//
//  Created by NewAgeSMB on 11/5/15.
//  Copyright © 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import "AppDelegate.h"
#import "annotationclass.h"
@interface ResortMapView : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation>{
    
    IBOutlet UILabel *ResortName;
    CLLocation *locationFromLM;    
    
    
}
@property (nonatomic, strong) NSMutableDictionary  *Mysuggestions;
@property (strong, nonatomic)  MKMapView *mapView;
@property(nonatomic,retain)  annotationclass *myAnnotation1;@end
