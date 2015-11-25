//
//  annotationclass.h
//  Lasso
//
//  Created by NewageSMB on 5/31/14.
//  Copyright (c) 2014 NewageSMB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface annotationclass : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D	coordinate;
	NSString*				title;
	NSString*				subtitle;
    UIImage *imageForMyAnnotation;
}

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)		NSString*	title;
@property (nonatomic, copy)		NSString*	title2;
@property (nonatomic, copy)		NSString*	subtitle;
@property (nonatomic, retain) UIImage *imageForMyAnnotation;


@end
