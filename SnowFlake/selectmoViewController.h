//
//  selectmoViewController.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/8/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface selectmoViewController : UIViewController
{
    
    NSMutableDictionary *MuntValue;
    AppDelegate *appD;
}


@property (strong, nonatomic) IBOutlet UITableView *MonutainTable;
@property (strong, nonatomic) NSMutableArray *dataMount;

@end


