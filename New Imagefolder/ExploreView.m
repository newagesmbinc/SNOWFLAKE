//
//  ExploreView.m
//  SnowFlake
//
//  Created by NewageSMB on 11/5/15.
//  Copyright © 2015 NewAgeSMB. All rights reserved.
//

#import "ExploreView.h"

#import "JSON.h"
#import "BikeProfileCell.h"
@interface ExploreView ()

@end

@implementation ExploreView

@synthesize placeArray,placeDict;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    placeArray = [[NSMutableArray alloc]init];
    placeDict = [[NSMutableDictionary alloc]init];
    //    _mapView.frame = CGRectMake(0, 100,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height -100);
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 100,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height -100)];
    NSLog(@"%f",self.mapView.frame.size.height);
    
    
    
    [self.view addSubview:self.mapView];
    
    
    _NearByTableView.hidden=YES;
    
    [self.view bringSubviewToFront:_exploreBtn];
    
    [self.view bringSubviewToFront:_NearByTableView];
    
    [self.view bringSubviewToFront:setCunt];
    //    [self loadLocation];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    
    
    _exploreBtn.frame= CGRectMake((self.mapView.frame.size.width/2)-30 , (self.mapView.frame.size.height/2)+60,60,60);
    
    
    
}
-(void)loadLocation
{
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate=self;
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        
        if([currSysVer integerValue] >=8)
        {
            if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [locationManager requestWhenInUseAuthorization];
            }
            
        }
        locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
        [locationManager startUpdatingLocation];
        
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Location Services Not Available!" message:@"Please switch on your Location Services in Device Settings & Restart the bizChat application." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //NSLog(@"%@", [locations lastObject]);
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    
    NSLog(@"%@",[standardUserDefaults objectForKey:@"latitude"]);
   
        
        locationFromLM = [locations objectAtIndex:0];
        NSLog(@"%@",[locations objectAtIndex:0]);
        
        
        latitude = locationFromLM.coordinate.latitude;
        longitude = locationFromLM.coordinate.longitude;
        
        
        
        
        
        

        
        
        NSString  *lat=[NSString stringWithFormat:@"%.8f", latitude];
        NSString  *log=[NSString stringWithFormat:@"%.8f", longitude];
        
        
        
        
        [standardUserDefaults setObject:lat forKey:@"lat"];
        [standardUserDefaults setObject:log forKey:@"log"];
        
        
        NSLog(@"%f%f",latitude,longitude);
        if(locationFromLM != nil)
        {
            [locationManager stopUpdatingLocation];
            locationManager =nil;
            
            // @autoreleasepool
            {
                //  _mapView.frame = CGRectMake(0, 103,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height -103);
                MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(locationFromLM.coordinate, 10000,10000);
                MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
                [_mapView setRegion:adjustedRegion animated:YES];
                _mapView.showsUserLocation = YES;
                
                NSLog(@"Begin");
                __block   NSString *returnAddress = @"";
                
                
                
                CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
                
                
                
                
                [geocoder reverseGeocodeLocation:[[CLLocation alloc]  initWithLatitude:latitude longitude:longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
                    if(error){
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    
                    CLPlacemark *placemark = [placemarks lastObject];
                    
                    
                    returnAddress = [NSString stringWithFormat:@"%@,%@ ",
                                     
                                     placemark.administrativeArea,
                                     placemark.country];
                    //[self.view setUserInteractionEnabled:YES];
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
                    if ([returnAddress isEqualToString:@"(null),(null) "])
                    {
                        returnAddress =@"Unspecified";
                    }
                    
                    
                    [standardUserDefaults setObject:returnAddress forKey:@"location"];
                    
                    NSLog(@"%@",returnAddress);
                    
                    
                    
                    
                    
                    
                    //            appDelegate.location =  returnAddress;
                    //            appDelegate.latitude = [NSString stringWithFormat:@"%f", centre.latitude];
                    //            appDelegate.longitude = [NSString stringWithFormat:@"%f", centre.longitude];
                    //       _mapView.mapType = MKMapTypeHybrid;
                    //       [_mapView removeFromSuperview];
                    //       _mapView = nil;
                    
                    if(locationManager)
                    {
                        locationManager=nil;
                        locationManager.delegate=nil;
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    
                    
                }];
                
                
            }
        }
        
    
    
    
    
    
    
    
    
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // This is for a bug in MKMapView for iOS6
    
    if(isBack)
    {
        [self applyMapViewMemoryHotFix];
    }
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)addAnnotation:(id<MKAnnotation>)annotation
{
    
    
}



- (void)applyMapViewMemoryHotFix{
    
    switch (self.mapView.mapType) {
        case MKMapTypeHybrid:
        {
            self.mapView.mapType = MKMapTypeStandard;
        }
            
            break;
        case MKMapTypeStandard:
        {
            self.mapView.mapType = MKMapTypeHybrid;
        }
            
            break;
        default:
            break;
    }
    self.mapView.showsUserLocation = NO;
    self.mapView.delegate = nil;
    [self.mapView removeFromSuperview];
    self.mapView = nil;
}






#pragma mark- Current Location Delegates





-(void)setUpLocationManager:(id)sender{
    
    //location tracking
    [locationManager startUpdatingLocation];
    
}






-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    //show alert for failed gps
    
    if (error.code == kCLErrorDenied) {
        
        [locationManager stopUpdatingLocation];
        
    }else if(error.code == kCLErrorLocationUnknown){
        
        //retry
        
    }else{
        
        
        
    }
    
    //[self.locationManager stopUpdatingLocation];
    
    
    
    
    
    NSLog(@"%@",error);
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Location Services Not Available!" message:@"Location not found..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alert show];
    
    
    
}










/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)done_fn:(id)sender {
    
    [address resignFirstResponder];
    //    if(appDelegate.isMap_Rg)
    //    {
    
    CLLocationCoordinate2D centre = [_mapView centerCoordinate];
    
    NSLog(@"centre latitude and longitude  %f, %f",centre.latitude,centre.longitude);
    
    latitude=centre.latitude;
    longitude=centre.longitude;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    NSString  *lat=[NSString stringWithFormat:@"%.8f", latitude];
    NSString  *log=[NSString stringWithFormat:@"%.8f", longitude];
    if (address.text.length>3) {
        
        
        
    }
    
    
    
    [standardUserDefaults setObject:lat forKey:@"lat"];
    [standardUserDefaults setObject:log forKey:@"log"];
    
    
    
    
    
    
    
    
    
    
    
    [standardUserDefaults synchronize];
    
    NSLog(@"Begin");
    __block   NSString *returnAddress = @"";
    
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    
    
    
    
    [geocoder reverseGeocodeLocation:[[CLLocation alloc]  initWithLatitude:centre.latitude longitude:centre.longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error){
            NSLog(@"%@", [error localizedDescription]);
        }
        
        CLPlacemark *placemark = [placemarks lastObject];
        
        
        returnAddress = [NSString stringWithFormat:@"%@,%@ ",
                         
                         placemark.administrativeArea,
                         placemark.country];
        //[self.view setUserInteractionEnabled:YES];
       
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        if ([returnAddress isEqualToString:@"(null),(null) "])
        {
            returnAddress =@"Unspecified";
        }
        
        
        [standardUserDefaults setObject:returnAddress forKey:@"location"];
        
        NSLog(@"%@",returnAddress);
        
        
        
        //            appDelegate.location =  returnAddress;
        //            appDelegate.latitude = [NSString stringWithFormat:@"%f", centre.latitude];
        //            appDelegate.longitude = [NSString stringWithFormat:@"%f", centre.longitude];
        //       _mapView.mapType = MKMapTypeHybrid;
        //       [_mapView removeFromSuperview];
        //       _mapView = nil;
        
        if(locationManager)
        {
            locationManager=nil;
            locationManager.delegate=nil;
        }
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }];
    
    //    }
    //    else
    //    {
    //
    //        [self loadLocation];
    //    }
    //
    
    
}


- (IBAction)Cununt_location_fn:(id)sender {
    
    [self loadLocation];
    
    
    
}




- (IBAction)address_typing_fn:(id)sender {
    
    if (address.text.length >4) {
        
        
        CLLocationCoordinate2D coordinates;
        
        
        
        
        latitude = locationFromLM.coordinate.latitude;
        longitude = locationFromLM.coordinate.longitude;
        
        
        
        
        
        
        //            [standardUserDefaults setFloat:latitude forKey:@"lat"];
        //            [standardUserDefaults setFloat:longitude forKey:@"lng"];
        
        
        
        
        //coordinates = [self getLocationFromAddressString:address.text];
        // NSLog(@"new cor :   %f ,  %f",coordinates.latitude,coordinates.longitude);
        // @autoreleasepool
        {
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinates, 1000,1000);
            MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
            [_mapView setRegion:adjustedRegion animated:YES];
            _mapView.showsUserLocation = YES;
        }
        
        
        
    }
    
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"The method was called");
    
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (placeArray.count==0) {
        _NearByTableView.hidden=YES;
    }else{   _NearByTableView.hidden=NO;}
    return  YES;}
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    
    [textField resignFirstResponder];
    
    
    
    if (textField.text.length ==0) {
        // @autoreleasepool
        {
            
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate, 1000,1000);
            MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
            [_mapView setRegion:adjustedRegion animated:YES];
            _mapView.showsUserLocation = YES;
        }
        
    }
    else
    {
        
        [self getLocationFromAddressString:textField.text];
    }
    _NearByTableView.hidden=NO;
    return  YES;
}





- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)stringt
{
    
    
    
    [self performSelector:@selector(searchPlace) withObject:nil afterDelay:.2];
    
    return YES;
    
    
    
    
}
-(void)searchPlace{
    
    [placeArray removeAllObjects];
    
    
    NSLog(@"string --- %@",address.text);
    
    
    NSString *string = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&sensor=true&key=AIzaSyApIbUZMWDLSeTIWD61M17elaisFUKh9P0",address.text];
    
    
    
    
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    NSLog(@"string--%@",string);
    
    NSURL *googleURL = [NSURL URLWithString:string];
    NSURLResponse *response;
    NSData *data;
    NSError    *error;
    
    data = [NSURLConnection sendSynchronousRequest: [NSURLRequest
                                                     requestWithURL: googleURL] returningResponse: &response error: &error];
    
    
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
    
    
    NSData *newdata=[jsonString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSError *er;
    
    placeDict =[NSJSONSerialization JSONObjectWithData:newdata options:NSJSONReadingMutableContainers error:&er];
    
    
    
    
    
    
    
    NSLog(@"placeArray --- %@",placeDict);
    
    
    
    
    placeArray = [placeDict objectForKey:@"predictions"];
    
    
    
    
    if (placeArray.count==0) {
        
        
        
        _NearByTableView.hidden = YES;
    }
    
    else{
        
        
        _NearByTableView.hidden = NO;
        
    }
    
    
    
    
    NSLog(@"string==>%@",string);
    
    NSLog(@"jsonString==>%@",jsonString);
    
    [_NearByTableView reloadData];
    
}



-(void) getLocationFromAddressString:(NSString*) addressStr {
    
    
    double latitude1 , longitude1 ;
    //@autoreleasepool
    {
        
        NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
        NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
        if (result) {
            
            
            NSArray *jsonArry =[[result JSONValue]objectForKey:@"results"];
            
            /* NSScanner *scanner = [NSScanner scannerWithString:result];
             if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
             [scanner scanDouble:&latitude1];
             if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
             [scanner scanDouble:&longitude1];
             }
             } */
            NSDictionary *jsonDct =[jsonArry objectAtIndex:0];
            
            //  NSLog(@"asdasd %@",[jsonDct valueForKeyPath:@"geometry.location.lat"]);
            //    NSLog(@"asdasd %@",[jsonDct valueForKeyPath:@"geometry.location.lng"]);
            
            latitude1 = [[jsonDct valueForKeyPath:@"geometry.location.lat"] doubleValue];
            longitude1 = [[jsonDct valueForKeyPath:@"geometry.location.lng"] doubleValue];
            
        }
        
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude1;
    center.longitude = longitude1;
    
    latitude = latitude1;
    longitude = longitude1;
    // testCntr =center;
    
    [self performSelector:@selector(loadMap:) withObject:nil afterDelay:0.1];
    
    //return center;
    
}


-(void)loadMap:( CLLocationCoordinate2D)center
{
    
    //  NSLog(@"latitude  -> %f",latitude);
    //  NSLog(@"longitude -> %f",longitude);
    
    //_mapView.frame = CGRectMake(0, 103,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height -103);
    /* CLLocationCoordinate2D theCoordinate;
     
     theCoordinate.latitude = latitude;
     theCoordinate.longitude = longitude;*/
    
    CLLocationCoordinate2D coord = {.latitude =  latitude, .longitude =  longitude};
    MKCoordinateSpan span = {.latitudeDelta = 0.5, .longitudeDelta =  0.5};
    MKCoordinateRegion region = {coord, span};
    
    
    // MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:MKCoordinateRegionMakeWithDistance(theCoordinate, 1000, 1000)];
    [_mapView setRegion:region animated:YES];
    
    /* MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(testCntr, 1000,1000);
     MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
     [_mapView setRegion:adjustedRegion animated:YES];
     //_mapView.showsUserLocation = YES;
     
     
     
     */
}
- (IBAction)loadLocation_fn:(id)sender {
    
    
    //NSLog(@"%@", [locations lastObject]);
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    
    NSLog(@"%@",[standardUserDefaults objectForKey:@"latitude"]);
    
    
    
    
    
    [self loadLocation];
    
    
}




- (IBAction)back_fn:(id)sender {
    
    [address resignFirstResponder];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%lu",(unsigned long)placeArray.count);
    
    if (placeArray.count==0) {
        _NearByTableView.hidden=YES;
    }
    return [placeArray count];
    
    
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"BikeProfileCell";
    BikeProfileCell *cell = (BikeProfileCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BikeProfileCell" owner:self options:Nil];
        cell = [nib objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    
    cell.backgroundColor=[UIColor greenColor];
    
    NSLog(@"%@",[[self.placeArray objectAtIndex:indexPath.row] objectForKey:@"description"]);
    cell.nameLbl.text = [[self.placeArray objectAtIndex:indexPath.row] objectForKey:@"description"];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [address resignFirstResponder];
    
    
    address.text=[[self.placeArray objectAtIndex:indexPath.row] objectForKey:@"description"];
    [self getLocationFromAddressString:address.text];
    
    
    
    
    
    
    _NearByTableView.hidden=YES;
    
}






















@end

