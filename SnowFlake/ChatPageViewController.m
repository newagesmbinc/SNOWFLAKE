//
//  ChatPageViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/22/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "ChatPageViewController.h"
#import "SocketIOJSONSerialization.h"
#import "SocketIOPacket.h"
#import "SelectMountainTableViewCell.h"
#import "ChatLeftTableViewCell.h"
#import "ChatRightTableViewCell.h"
#import "SCLAlertView.h"


@interface ChatPageViewController ()
{
    CGRect screenRect ;
    CGFloat screenWidth ;
    CGFloat screenHeight;
    NSString *typing;
    ARKLoader *ark;
    NSTimer *timer;
    int i;
    
    
}







@end

@implementation ChatPageViewController


-(void)startLoader

{
    
    if (!ark) {
        
        ark =[[ARKLoader alloc]init];
        [ark showLoader];
        
    }
    
    
    
}

-(void)stopLoader

{
    
    [ark removeLoader];
    
    ark = nil;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    appD.cuerntView=@"";
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //arunb
    typing=@"NO";
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    [self startLoader];
    i=0;
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
     appD.cuerntView=@"ChatPageViewController";
    
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    
    socketIO.useSecure = NO;
    
    [socketIO connectToHost:@"52.27.246.44" onPort:3000];
    
    //    [self setGateway];
    self.tableArray=[[NSMutableArray alloc]init  ];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [CHATIDIMAGE sd_setImageWithURL:[NSURL URLWithString:[_ChatingDETAILS objectForKey:@"display_image"]]  placeholderImage:[UIImage imageNamed:@"ic_camera.png"]];
    
    
    
    
    CHATIDIMAGE.layer.masksToBounds=YES;
    CHATIDIMAGE.layer.cornerRadius=20;
    CHATIDNAME.text=[_ChatingDETAILS objectForKey:@"display_name"];    self.tableView.allowsSelection = NO;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    userId=[standardUserDefaults objectForKey:@"user_id"];
    // Do any additional setup after loading the view.
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height -43, self.view.frame.size.width, 43)];
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 5, 245, 25)];
    textView.font = [UIFont fontWithName:@"Roboto-Light" size:13.0f];
    
    
    
    
    
    textView.layer.cornerRadius = 3.0;
    
    
    //109 219 179
    [containerView setBackgroundColor:[self colorWithHexString:@"F6F6F6"]];
    
    
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 6;
    textView.returnKeyType = UIReturnKeyGo;
    textView.delegate =self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor clearColor];
    textView.placeholder = @"Type here";
    //  textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    textView.placeholderColor=[UIColor grayColor];
    [self.view addSubview:containerView];
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
    [containerView addSubview:textView];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    
    tapGesture1.numberOfTapsRequired = 1;
    
    [tapGesture1 setDelegate:self];
    
    [self.tableView addGestureRecognizer:tapGesture1];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    doneBtn.frame = CGRectMake(containerView.frame.size.width - 65,0, 65, 43);
    doneBtn.titleLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:15.0f];
    
    
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setImage:[UIImage imageNamed:@"btnsend.png"] forState:UIControlStateNormal];
    doneBtn.backgroundColor=[UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];
    
    [containerView addSubview:doneBtn];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    // [textView becomeFirstResponder];
    
    
    
    
    
    [self serverCall];
    
    
    
    
}

-(void)serverCall{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=nil;
    
    
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"clear_unread_msg\", \"parameters\": {\"user_id\": \"%@\",\"reciver_id\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"],_ChatingId];
    NSLog(@"post------%@",postData);

    [server sendServerRequests:postData];

    
    
}

-(void)serverCall1{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=nil;
    
    
    
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"send_message_push_only\", \"parameters\": {\"from_id\": \"%@\",\"to_id\": \"%@\",\"message\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"],_ChatingId,chat];
    NSLog(@"post------%@",postData);
   
    [server sendServerRequests:postData];
    
    
    
}








- (void)viewWillAppear:(BOOL)animated{
    
    appD.cuerntView=@"ChatPageViewController";
    [self.tableView setContentOffset:CGPointMake(0.0, self.tableView.contentSize.height - self.tableView.bounds.size.height)
                            animated:NO];
    
    if ([self.tableArray count]>0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.tableArray count]-1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }
    
    
}- (void) tapGesture: (id)sender
{
    [textView resignFirstResponder];
}





-(void)resignTextView
{
    
    
    if([[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""])
    {
        
        
        
    }
    else
    {
        messageStr =textView.text;
        textView.text = @"";
        
        //
        [self send_meg:messageStr];
        
        
    }
}








-(IBAction)back:(id)sender{
 
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
# pragma mark -
# pragma mark socket.IO-objc delegate methods

- (void) socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"socket.io connected.");
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:userId forKey:@"username"];
    [dict setObject:userId forKey:@"from_id"];
    [dict setObject:_ChatingId forKey:@"to_id"];
    [socketIO sendEvent:@"add user" withData:dict];
    
    
}
- (void) typing{
    NSLog(@"socket.io typing.");
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:userId forKey:@"from_id"];
    [dict setObject:_ChatingId forKey:@"to_id"];
    [socketIO sendEvent:@"typing" withData:dict];
    
    
}
- (void) to_disconnect{
    NSLog(@"socket.io disconnect.");
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:userId forKey:@"from_id"];
    [dict setObject:_ChatingId forKey:@"to_id"];
    [socketIO sendEvent:@"to_disconnect" withData:dict];
    
    
}






- (void) stoptyping{
    NSLog(@"socket.io stop typing.");
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:userId forKey:@"from_id"];
    [dict setObject:_ChatingId forKey:@"to_id"];
    [socketIO sendEvent:@"stop typing" withData:dict];
    
    
}
- (void)send_meg:(NSString *)message
{
    
    if([[[self.tableArray lastObject]  objectForKey:@"message"]isEqualToString:@"typing"])
    {
        
        [_tableArray removeLastObject];
        typing=@"NO";
    }
    
    NSString *uniText = [NSString stringWithUTF8String:[message UTF8String]];
    NSData *msgData = [uniText dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *finalMsgStr = [[NSString alloc] initWithData:msgData encoding:NSUTF8StringEncoding];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:finalMsgStr forKey:@"message"];
    [dict setObject:userId forKey:@"from_id"];
    [dict setObject:_ChatingId forKey:@"to_id"];
    
    
    [self.tableArray addObject:dict];
    NSLog(@"%@",self.tableArray);
    [self.tableView reloadData];
    if ([self.tableArray count]>0) {
        
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.tableArray count]-1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }
    [socketIO sendEvent:@"send message" withData:dict];
    
    chat=message;
     [self serverCall1];
    
    
    
    
}
- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveEvent()");
    [self stopLoader];
    NSDictionary *json = [packet dataAsJSON];
    packet.name = [json objectForKey:@"name"];
    packet.args = [json objectForKey:@"args"];
    //
    //   NSLog(@"ack name: %@", packet.name);
    NSLog(@"ack name: %@", [[packet.args objectAtIndex:0]objectForKey:@"response"]);
    
    if ([packet.name isEqualToString:@"chat history"]) {
       
        
        if ([[[packet.args objectAtIndex:0]objectForKey:@"response"] isKindOfClass:[NSArray class]]) {
            
           
            self.tableArray=[[[packet.args objectAtIndex:0]objectForKey:@"response"] mutableCopy];
            
            [self.tableView reloadData];
            
            
        }
        
        
        
        
        
    }
    
    
    
    if ([packet.name isEqualToString:@"typing"]) {
        
        NSLog(@"ack name: typing");
        NSLog(@"%@",[[packet.args objectAtIndex:0]objectForKey:@"response"]);
    
        if([typing isEqualToString:@"NO"])
        {
            typing=@"YES";
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:@"typing" forKey:@"message"];
            [dict setObject:_ChatingId forKey:@"from_id"];
            [dict setObject:userId forKey:@"to_id"];
            
            [self.tableArray addObject:dict];
            [self.tableView reloadData];
           
        }
        if ([[[packet.args objectAtIndex:0]objectForKey:@"response"] isKindOfClass:[NSArray class]]) {
            
         
        }
        
        
        
        
    }
    
    
    
    if ([packet.name isEqualToString:@"stop typing"]) {
    
        
        
        if([[[self.tableArray lastObject]  objectForKey:@"message"]isEqualToString:@"typing"])
        {
            [_tableArray removeLastObject];
        }
        else
        {
            for (int z=0; z<_tableArray.count; z++) {
                if([[[_tableArray objectAtIndex:z] objectForKey:@"message"]isEqualToString:@"typing"])
                {
                    [_tableArray removeObjectAtIndex:z];
                }
            }
        }
       
        typing=@"NO";
        [self.tableView reloadData];
        
        
    }
    
    
    if ([packet.name isEqualToString:@"receive message"]) {
      
        
        if([[[self.tableArray lastObject]  objectForKey:@"message"]isEqualToString:@"typing"])
        {
            [_tableArray removeLastObject];
        }
        else
        {
            for (int z=0; z<_tableArray.count; z++) {
                if([[[_tableArray objectAtIndex:z] objectForKey:@"message"]isEqualToString:@"typing"])
                {
                    [_tableArray removeObjectAtIndex:z];
                }
            }
        }
        
        typing=@"NO";
     
        NSDictionary *str=[[packet.args objectAtIndex:0] mutableCopy];
        [self.tableArray addObject:str];;
        
        [self.tableView reloadData];
    }
    
    SocketIOCallback cb = ^(id args) {
        NSDictionary *response = args;
       
    };
   
    if ([self.tableArray count]>0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.tableArray count]-1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];}
    
    
}


- (void) socketIO:(SocketIO *)socket didReceiveJSON:(SocketIOPacket *)packet{
    
    NSLog(@"didReceiveJSON >>> data: %@", packet);
    
}

- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveMessage >>> data: %@", packet);
}











- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    if ([error code] == SocketIOUnauthorized) {
        NSLog(@"not authorized");
    } else {
        NSLog(@"onError() %@", error);
    }
    if (i<5) {
        
        [self reconnect];}else{
            [self stopLoader];
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            
            [alert showInfo:self title:@"Connection error"
                   subTitle:@"Messaging  service is currently unavailable. Please try after some time."
           closeButtonTitle:@"OK" duration:0.0f];
            
            
            
        }

 
    
}
- (void) reconnect
{
    [socketIO disconnectForced];
    
    i++;
    
    
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    socketIO.useSecure = NO;
    [socketIO connectToHost:@"52.27.246.44" onPort:3000];
    
    
    
    
    
    
    
}
- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"socket.io disconnected. did error occur? %@", error);
    
    if (i<5) {
     
        [self reconnect];}else{
            [self stopLoader];
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            
            [alert showInfo:self title:@"Connection error"
                   subTitle:@"Messaging  service is currently unavailable. Please try after some time."
           closeButtonTitle:@"OK" duration:0.0f];
            
            
            
        }
    
}

# pragma mark -

- (void) viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
+(NSDate *)accurateDateFromDateString:(NSString *)dateString
{
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[dateformatter dateFromString:dateString];
    
    return date;
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    const char *jsonString = [[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"message"] UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *message123 = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    
    
    
    UIFont *font = [UIFont boldSystemFontOfSize:16];

    
    
    CGSize textRect=[self text:message123 sizeWithFont:font constrainedToSize:CGSizeMake(200, FLT_MAX)];

    
    
    
    return 15+textRect.height;
    
    
}

- (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size

{
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_0)
        
    {
        
        CGRect frame = [text boundingRectWithSize:size
                        
                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                        
                                       attributes:@{NSFontAttributeName:font}
                        
                                          context:nil];
        
        return frame.size;
        
    }
    
    else{
        
        return [text sizeWithFont:font constrainedToSize:size];
        
    }
    
}




- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)sectionn {
    
    if ([self.tableArray count]>0) {
        NoConversn.hidden=YES;
    }
    
    return [self.tableArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *checkId=[NSString stringWithFormat:@"%@",[[self.tableArray objectAtIndex:indexPath.row]  objectForKey:@"from_id"]];
    
    
    if ([checkId  isEqualToString:userId]) {
        
        static NSString *CellIdentifier = @"ChatLeftTableViewCell";
        ChatLeftTableViewCell *cell = (ChatLeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatLeftTableViewCell" owner:self options:Nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        cell.backgroundColor=[UIColor clearColor];
        
        const char *jsonString = [[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"message"] UTF8String];
        NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
        NSString *message123 = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
        
        CGSize textRect=[self text:message123 sizeWithFont:font constrainedToSize:CGSizeMake(200, FLT_MAX)];
        
        
        cell.ChatName.frame=CGRectMake((self.view.frame.size.width-textRect.width)-35, 4, textRect.width+10, textRect.height+5);
        cell.ChatImage.frame=CGRectMake((self.view.frame.size.width-textRect.width)-40, 5, textRect.width+28, textRect.height+8);
        
        
        
        
        cell.ChatName.text=message123;
        //arunb
        NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
        if(totalRow!=0 && indexPath.row!=totalRow-1)
        {
            
            
            NSString *newId=[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"from_id"];
            
            
            NSString *nextid=[[self.tableArray objectAtIndex:indexPath.row+1] objectForKey:@"from_id"];
            
            if( newId!=nextid)
            {
                
                cell.ChatImage.image=[UIImage imageNamed:@"graybubletalk.png"];
                
            }
        }
        
        else
        {
            cell.ChatImage.image=[UIImage imageNamed:@"graybubletalk.png"];
            
        }
        
        
        
        
        return cell;
        
    }
    else{
        
        static NSString *CellIdentifier1 = @"ChatRightTableViewCell";
        ChatRightTableViewCell *cell1 = (ChatRightTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if (cell1 == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatRightTableViewCell" owner:self options:Nil];
            cell1 = [nib objectAtIndex:0];
            
        }
        
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        
        cell1.backgroundColor=[UIColor clearColor];
      
        
        
        const char *jsonString = [[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"message"] UTF8String];
        NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
        NSString *message123 = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
        
        CGSize textRect=[self text:message123 sizeWithFont:font constrainedToSize:CGSizeMake(200, FLT_MAX)];
        
        
        
        
        
        
        
        
        
        
        cell1.ChatName.frame=CGRectMake(25, 4, textRect.width+10, textRect.height+5);
        cell1.ChatImage.frame=CGRectMake(10, 5, textRect.width+25, textRect.height+8);
        cell1.ChatName.text=message123;
        
        //arunb
        
        NSString *checktyping=[NSString stringWithFormat:@"%@",[[self.tableArray objectAtIndex:indexPath.row]  objectForKey:@"message"]];
        if([checktyping isEqualToString:@"typing"])
        {
            cell1.ChatImage.image=[UIImage animatedImageNamed:@"anim" duration:1];
            cell1.ChatName.text=@"";
            
          
            
            textRect=[self text:@"Text" sizeWithFont:font constrainedToSize:CGSizeMake(200, FLT_MAX)];
            
         
            
        }
        else{
            
            
            const char *jsonString = [[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"message"] UTF8String];
            NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
            NSString *message123 = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
            
            
            
            
            
            
            cell1.ChatName.text=message123;
            
            [cell1.ChatName sizeToFit];
            
            NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
            if(totalRow!=0 && indexPath.row!=totalRow-1)
            {
                
                
                NSString *newId=[[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"from_id"];
                
                
                NSString *nextid=[[self.tableArray objectAtIndex:indexPath.row+1] objectForKey:@"from_id"];
                
                if( newId!=nextid)
                {
                    
                    cell1.ChatImage.image=[UIImage imageNamed:@"bluebubletalk.png"];
                    
                }
            }
            
            else{
                cell1.ChatImage.image=[UIImage imageNamed:@"bluebubletalk.png"];
            }
            
        }
    
        return cell1;
        
        
    }
    
}

#pragma mark - Keyboard events

- (void)keyboardWillShow:(NSNotification*)note
{
   
    
    [UIView animateWithDuration:0.2f animations:^{
       
        
        hide=@"Unhide";
        
        CGRect keyboardBounds;
        
        [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
        
        NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        
        NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        
        
        
        // Need to translate the bounds to account for rotation.
        
        keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
        
        
        
        // get a rect for the textView frame
        
        CGRect containerFrame = containerView.frame;
        
        containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
        
        // animations settings
        
        [UIView beginAnimations:nil context:NULL];
        
        [UIView setAnimationBeginsFromCurrentState:YES];
        
        [UIView setAnimationDuration:[duration doubleValue]];
        
        [UIView setAnimationCurve:[curve intValue]];
        
        
        
        // set views with new info
        
        containerView.frame = containerFrame;
        
        
        
        self.tableView.frame = CGRectMake(0, 70, self.view.frame.size.width, screenHeight-(keyboardBounds.size.height +120));
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = YES;
        
        
        // commit animations
        
        [UIView commitAnimations];
        
        if ([self.tableArray count]>0) {        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.tableArray count]-1 inSection:0]
                                                                      atScrollPosition:UITableViewScrollPositionBottom
                                                                              animated:NO];}
        
        
        
        
        CGRect frame = containerView.frame;
        //                  frame.origin.y -= keyboardBounds.size.height;
        containerView.frame = frame;
       
        
    }];
    //}
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    //    hide=@"hide";
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = containerView.frame;
        frame.origin.y += kbSize.height;
        containerView.frame = frame;
        
        frame = self.tableView.frame;
        frame.size.height += kbSize.height;
        self.tableView.frame = frame;
    }];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    containerView.frame = r;
    
    diff=diff*-1;
    
    CGRect frame;
    frame = self.tableView.frame;
    frame.size.height -=diff;
    self.tableView.frame = frame;
    
    
}
-(void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView



{
    
    
    
    
    
    NSLog(@"didbein");
    [self typing];
}
-(void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView
{
    
    
    
    
    
    NSLog(@"didbend");
    [self stoptyping];
}
-(void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView{
    if(growingTextView.text.length>0)
    {
        [self typing];
    }
    
    
    
    
    
}

@end