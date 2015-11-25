//
//  EditMYACNTXIBViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/15/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "EditMYACNTXIBViewController.h"
#import "SCLAlertView.h"
#import "ExploreView.h"


@interface EditMYACNTXIBViewController ()

@end

@implementation EditMYACNTXIBViewController


#pragma mark - Loader

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




#pragma mark - System Method

- (void)viewDidLoad {
    [super viewDidLoad];
    
    genderArray=[NSArray arrayWithObjects:@"Male",@"Female",nil];
    _genderTable.hidden=YES;
      appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    UIColor *color = [UIColor blackColor];
    _name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName: color}];
    _email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    
    _location.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Location" attributes:@{NSForegroundColorAttributeName: color}];
    _dob.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"DOB" attributes:@{NSForegroundColorAttributeName: color}];
    _gender.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Gender" attributes:@{NSForegroundColorAttributeName: color}];
    
    _marital.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Marital Status" attributes:@{NSForegroundColorAttributeName: color}];
 
    _name.text=[standardUserDefaults objectForKey:@"name"];
    _email.text= [standardUserDefaults objectForKey:@"email"];
    _dob.text=[standardUserDefaults objectForKey:@"birthday"];
    _location.text=[standardUserDefaults objectForKey:@"location"];
    _gender.text=[standardUserDefaults objectForKey:@"gender"];
    
    
    
    _marital.text=[standardUserDefaults objectForKey:@"marital_status"];
    
    
    dateView.hidden=YES;
    

}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    _location.text= [standardUserDefaults objectForKey:@"location"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
}

#pragma mark - TableView






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [genderArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.backgroundColor=[UIColor colorWithRed:58.0/255.0 green:180/255.0 blue:240/255.0 alpha:1.0];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if ([genderArray containsObject:@"Male"]) {
        _gender.text=[genderArray objectAtIndex:indexPath.row];
        
    }else{
        _marital.text=[genderArray objectAtIndex:indexPath.row];
    }
    _genderTable.hidden=YES;
}


#pragma mark - Navigation



-(IBAction)back:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - TextField


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    
    
    
    [textField resignFirstResponder];
    if (textField==_name ) {
        
        
        
        [_email becomeFirstResponder];
    }
    if (textField==_email ) {
        
        
        [_location becomeFirstResponder];
    }
    if (textField==_location ) {
      
    }
    
    
    
    
    return NO;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    if ([textField isEqual:_dob]) {
        
      
        
    }
    else if ([textField isEqual:_location]) {
        
    }
    else if ([textField isEqual:_name]) {
        
        
        
    }
    
    else if ([textField isEqual:_gender]) {
        
        
    }
    
    else if ([textField isEqual:_marital]) {
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    return YES;
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    
    
    
    [textField resignFirstResponder];
    if ([textField isEqual:_name]) {
      
        
        
    }
    
    else if ([textField isEqual:_email]) {
        
        if (_email.text.length>0) {
            
            
            if ([self validateEmail:[_email text]]){
                         }
            
            else{
                
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                
                [alert showInfo:self title:@"Invalid Email"
                        subTitle:@"Enter a valid Email"
                closeButtonTitle:@"OK" duration:0.0f];
                
            }
            
        }
    }
    
    else if ([textField isEqual:_location]) {
        
    }
    else if ([textField isEqual:_dob]) {
           }
    
    else if ([textField isEqual:_gender]) {
        
        
    }
    
    return YES;
}

- (BOOL)validateEmail:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}


#pragma mark - Button Action






-(IBAction)save:(id)sender{
    
    [_name resignFirstResponder];
    [_email resignFirstResponder];
    [_gender resignFirstResponder];
    [_location resignFirstResponder];
    [_dob resignFirstResponder];
    [_marital resignFirstResponder];
    
    
    
    
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    if(![[_name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]){
        if(![[_email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]){
            if(![[_location.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]){
                if(![[_gender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]){
                    if(![[_dob.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]){
                        if(![[_marital.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ]isEqualToString:@""]){
                            
                            
                            NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"edit_account\", \"parameters\": {\"user_id\": \"%@\",\"first_name\": \"%@\",\"dob\": \"%@\",\"location\": \"%@\",\"email\": \"%@\",\"gender\": \"%@\",\"marital_status\": \"%@\",\"lat\": \"%@\",\"long\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"],_name.text,_dob.text,_location.text,_email.text,_gender.text,_marital.text,[standardUserDefaults objectForKey:@"lat"],[standardUserDefaults objectForKey:@"log"]];
                            NSLog(@"post------%@",postData);
                            
                            
                            [server sendServerRequests:postData];
                                [self startLoader];
                            
                        }else{
                            [alert showInfo:self title:@""
                                    subTitle:@"Enter Marital Status"
                            closeButtonTitle:@"OK" duration:0.0f];                        }
                        
                    }
                    else{
                        [alert showInfo:self title:@""
                                subTitle:@"Enter Date of Birth"
                        closeButtonTitle:@"OK" duration:0.0f];
                        
                    }
                    
                    
                }
                else{
                    [alert showInfo:self title:@""
                            subTitle:@"Enter Gender"
                    closeButtonTitle:@"OK" duration:0.0f];                    }
            }
            else{
                [alert showInfo:self title:@""
                        subTitle:@"Enter Location"
                closeButtonTitle:@"OK" duration:0.0f];
            }
        }
        else{
            [alert showInfo:self title:@""
                    subTitle:@"Enter Email"
            closeButtonTitle:@"OK" duration:0.0f];
        }
        
    }
    else{
        [alert showInfo:self title:@""
                subTitle:@"Enter Name"
        closeButtonTitle:@"OK" duration:0.0f];
    }
    
    
    
    
    
    
    
    
    
}



-(IBAction)dob:(id)sender{
    [_dob resignFirstResponder];
    
    NSDate *selectedDate = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentTime = [dateFormatter stringFromDate:selectedDate];
    
    _dob.text= currentTime;
    
    
    _genderTable.hidden=YES;
    dateView.hidden=NO;
    
    
}
-(IBAction)mARITAL:(id)sender{
    
    [_marital resignFirstResponder];
    
    genderArray =nil;
    genderArray=[NSArray arrayWithObjects:@"Single",@"Married",nil];
    [_genderTable reloadData];
    dateView.hidden=YES;
    
    _genderTable.hidden=NO;
}

-(IBAction)Gender:(id)sender{
    [_gender resignFirstResponder];
    genderArray =nil;
    genderArray=[NSArray arrayWithObjects:@"Male",@"Female",nil];
    [_genderTable reloadData];
    dateView.hidden=YES;
    _genderTable.hidden=NO;
    
    
    
    
    
}

-(IBAction)dateDone:(id)sender{
   
    
    [dateView setHidden:YES];
}



-(IBAction)DateChanged:(id)sender{
    
    NSDate *selectedDate = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentTime = [dateFormatter stringFromDate:selectedDate];
    
    _dob.text = [dateFormatter stringFromDate:selectedDate];
    
    
}
- (IBAction)getLocationMap:(id)sender {
    ExploreView *exploreView=[[ExploreView alloc]init];
    [self.navigationController pushViewController:exploreView animated:YES];
}



#pragma mark - Server Respone




-(void)ServerRequestProcessFinish:(NSString *)serverResponse
{
    [self stopLoader];
    if ([serverResponse isEqualToString:@"ERROR"]) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showError:self title:@"Connection error"
                subTitle:@"Cannot connect with server. Please try again later."
        closeButtonTitle:@"OK" duration:0.0f];
        
        
    }else{
        //NSLog(@"serverResponse %@",serverResponse);
        NSData *data=[serverResponse dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSError *er;
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&er];
        NSLog(@"messageArray------%@",dict);
        
        
        
        if ([[dict objectForKey:@"status"]isEqualToString:@"true"]) {
            
            [appD.ServerData setObject:[dict objectForKey:@"first_name"] forKey:@"first_name"];
            
            [appD.ServerData setObject:[dict objectForKey:@"age"] forKey:@"age"];
            [appD.ServerData setObject:[dict objectForKey:@"location"] forKey:@"location"];
            
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            [standardUserDefaults setObject:[dict objectForKey:@"email"]forKey:@"email"];
            [standardUserDefaults setObject:[dict objectForKey:@"dob"] forKey:@"birthday"];
            
            [standardUserDefaults setObject:[dict objectForKey:@"first_name"] forKey:@"name"];
            [standardUserDefaults setObject:[dict objectForKey:@"gender"] forKey:@"gender"];
            
            [standardUserDefaults setObject:[dict objectForKey:@"age"]forKey:@"age"];
            
            [standardUserDefaults setObject:[dict objectForKey:@"lat"] forKey:@"lat"];
            [standardUserDefaults setObject:[dict objectForKey:@"long"] forKey:@"log"];
            
            
            
            [standardUserDefaults setObject:[dict objectForKey:@"location"] forKey:@"location"];
            [standardUserDefaults setObject:[dict objectForKey:@"marital_status"] forKey:@"marital_status"];
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            
            [alert showInfo:self title:@"Message"
                   subTitle:[dict valueForKey:@"message"]
           closeButtonTitle:@"OK" duration:0.0f];
            
        }
        
        else{
            
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            
            [alert showInfo:self title:@"Message"
                   subTitle:[dict valueForKey:@"message"]
           closeButtonTitle:@"OK" duration:0.0f];
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
    }
}

















@end

