//
//  ResortMapView.m
//  SnowFlake
//
//  Created by NewAgeSMB on 11/5/15.
//  Copyright © 2015 NewAgeSMB. All rights reserved.
//

#import "ResortMapView.h"

@interface ResortMapView ()

@end

@implementation ResortMapView
@synthesize myAnnotation1;



#pragma System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ResortName.text=[_Mysuggestions objectForKey:@"name"];
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 70,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height -70)];
  
    [self.view addSubview:self.mapView];
  
    CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:[[_Mysuggestions objectForKey:@"lat"] floatValue] longitude:[[_Mysuggestions objectForKey:@"long"] floatValue]];
   
  
    
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(LocationAtual.coordinate, 20000, 20000);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    
    _mapView.showsUserLocation = YES;
    _mapView.delegate=self;
    
    float latitude1 = [[_Mysuggestions objectForKey:@"lat"]floatValue] ;
    float longitude1 = [[_Mysuggestions objectForKey:@"long"]floatValue];
    CLLocationCoordinate2D theCoordinate_2;
    theCoordinate_2.latitude = latitude1;
    theCoordinate_2.longitude = longitude1;
    myAnnotation1 = [[annotationclass alloc] init];
    myAnnotation1.coordinate=theCoordinate_2;
    
    myAnnotation1.coordinate = adjustedRegion.center;
    
    
    myAnnotation1.title =[_Mysuggestions objectForKey:@"name"];
    
    myAnnotation1.imageForMyAnnotation=[UIImage imageNamed:@"map_pin.png"];
   
     [self.mapView addAnnotation:myAnnotation1];    
    [self.mapView selectAnnotation:myAnnotation1 animated:YES];
    
   
    
    
    
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma Mapview Delegate


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString * const kPinAnnotationIdentifier = @"PinIdentifier";
    if(annotation == mapView.userLocation)
    {
        return nil;
    }
    
    myAnnotation1  = (annotationclass *)annotation;
    MKAnnotationView *newAnnotation = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationIdentifier];
    
    if(!newAnnotation){
        newAnnotation = [[MKAnnotationView alloc] initWithAnnotation:myAnnotation1 reuseIdentifier:@"userloc"];
        
        
        newAnnotation.image =[UIImage imageNamed:@"map_pin.png"];
        
        newAnnotation.enabled = YES;
        newAnnotation.canShowCallout = YES;
        
        
        
    }else {
        newAnnotation = [[MKAnnotationView alloc] initWithAnnotation:myAnnotation1 reuseIdentifier:@"userloc"];
        newAnnotation.image =[UIImage imageNamed:@"map_pin.png"];
        
        newAnnotation.enabled = YES;
        newAnnotation.canShowCallout = YES;
        
    }
    
   
 
    
    return newAnnotation;
}


#pragma Navigation

-(IBAction)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
