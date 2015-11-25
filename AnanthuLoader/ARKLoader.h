//
//  NMKLoader.h
//  crossa
//
//  Created by NewageSMB on 3/2/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARKLoader : UIViewController
{
    UIView *mainview;
    
    CGRect screenRect;

}

-(void)showLoader;
-(void)removeLoader;


@end
