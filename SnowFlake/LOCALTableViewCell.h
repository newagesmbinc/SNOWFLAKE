//
//  LOCALTableViewCell.h
//  SnowFlake
//
//  Created by NewAgeSMB on 11/5/15.
//  Copyright © 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOCALTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ResortName;
@property (strong, nonatomic) IBOutlet UILabel *ResotLoc;
@property (strong, nonatomic) IBOutlet UILabel *resortdis;
@property (strong, nonatomic) IBOutlet UIImageView *userimage;
@property (strong, nonatomic) IBOutlet UIImageView *arrowimage;
@property (strong, nonatomic) IBOutlet UIImageView *megimage;
@property (strong, nonatomic) IBOutlet UIButton *megbutton;



@end
