//
//  InboxTableViewCell.h
//  SnowFlake
//
//  Created by NewAgeSMB on 10/1/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InboxTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ChatName;
@property (strong, nonatomic) IBOutlet UILabel *ChatDtals;
@property (strong, nonatomic) IBOutlet UILabel *Nofitn;
@property (strong, nonatomic) IBOutlet UILabel *Date;
@property (strong, nonatomic) IBOutlet UIImageView *ChatImage;
@property (strong, nonatomic) IBOutlet UIView *NotView;


@end
