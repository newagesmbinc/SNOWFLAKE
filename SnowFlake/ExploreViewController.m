//
//  ExploreViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/27/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "ExploreViewController.h"
#import "JSON.h"
#import "BikeProfileCell.h"
#import "ARKLoader.h"

@interface ExploreViewController ()
{
int adesconut;
ARKLoader *ark;
}
@end

@implementation ExploreViewController

@synthesize placeArray,placeDict;

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



- (void)viewDidLoad {
    [super viewDidLoad];
   
    appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    placeArray = [[NSMutableArray alloc]init];
    placeDict = [[NSMutableDictionary alloc]init];
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 100,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height -160)];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    
    CLLocationCoordinate2D location = self.mapView.userLocation.coordinate;
    MKCoordinateRegion region;
    MKCoordinateSpan span;
   
    location.latitude  = [[standardUserDefaults objectForKey:@"lat"]floatValue];
    location.longitude = [[standardUserDefaults objectForKey:@"log"]floatValue];
    
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    
    region.span = span;
    region.center = location;
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView regionThatFits:region];
    
    
    [self.view addSubview:self.mapView];
    

    if ([_frmMyacunt isEqualToString:@"Yes"] ) {
    
    }
    else{
        [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
        
        donehide.hidden=YES;
        donehideimage.hidden=YES;
    
    }
    _NearByTableView.hidden=YES;
  
    [self.view bringSubviewToFront:_exploreBtn];
    
    [self.view bringSubviewToFront:_NearByTableView];
    
    [self.view bringSubviewToFront:setCunt];
  
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
        adesconut=0;
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Location Services Not Available!" message:@"Please switch on your Location Services in Device Settings & Restart the bizChat application." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    
    NSLog(@"%@",[standardUserDefaults objectForKey:@"latitude"]);
    
        
        locationFromLM = [locations objectAtIndex:0];
        NSLog(@"%@",[locations objectAtIndex:0]);
        
        
        latitude = locationFromLM.coordinate.latitude;
        longitude = locationFromLM.coordinate.longitude;
        
        
        
        
    [self getlocationname];
    
    
        
        
        NSString  *lat=[NSString stringWithFormat:@"%.8f", latitude];
        NSString  *log=[NSString stringWithFormat:@"%.8f", longitude];
       
        
        
        if ([_frmMyacunt isEqualToString:@"Yes"] ) {
            
            
            
            [standardUserDefaults setObject:lat forKey:@"lat"];
            [standardUserDefaults setObject:log forKey:@"log"];
            
            
        }
        else{
            
            appDelegate.searchdata=@"current_location";
            
            [standardUserDefaults setObject:lat forKey:@"lat2nd"];
            [standardUserDefaults setObject:log forKey:@"log2nd"];
            
            
            
        }
     
        
        
        NSLog(@"%f%f",latitude,longitude);
        if(locationFromLM != nil)
        {
            [locationManager stopUpdatingLocation];
            locationManager =nil;
            
            // @autoreleasepool
            {
                
                MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(locationFromLM.coordinate, 1000,1000);
                MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
                [_mapView setRegion:adjustedRegion animated:YES];
                _mapView.showsUserLocation = YES;
                
              
                
            }
        }
        
    }
    
-(void)getlocationname{
    
   
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];    NSLog(@"Begin");
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
        
     
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        
       
            
            
            if ([returnAddress isEqualToString:@"(null),(null) "])
            {
                returnAddress =@"Unspecified";
                
            
               
               
            }
        
        
        if ([_frmMyacunt isEqualToString:@"Yes"] ) {
            [standardUserDefaults setObject:returnAddress forKey:@"location"];
            
        }else{
            [standardUserDefaults setObject:returnAddress forKey:@"location2nd"];          }
        
        
        
        NSLog(@"%@",returnAddress);
        
       
           _mapView = nil;
        
        if(locationManager)
        {
            locationManager=nil;
            locationManager.delegate=nil;
        }
        
        
        
        
    }];
    
    
     [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
    
}










- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
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
    
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Location Services Not Available!" message:@"Location not found..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alert show];
    
    
    
}












- (IBAction)done_fn:(id)sender {
    
    
    
    
    
    
    
    
    
    
    [address resignFirstResponder];
    
    
    CLLocationCoordinate2D centre = [_mapView centerCoordinate];
    
    NSLog(@"centre latitude and longitude  %f, %f",centre.latitude,centre.longitude);
    
    latitude=centre.latitude;
    longitude=centre.longitude;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    
    NSString  *lat=[NSString stringWithFormat:@"%.8f", latitude];
    NSString  *log=[NSString stringWithFormat:@"%.8f", longitude];
 
    

        
   
  
    [standardUserDefaults setObject:lat forKey:@"lat"];
    [standardUserDefaults setObject:log forKey:@"log"];
    
  
    
    
    
    
    
    
  
    
    [standardUserDefaults synchronize];
    
    NSLog(@"Begin");
    __block   NSString *returnAddress = @"";
    
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    
    
    
    
    [geocoder reverseGeocodeLocation:[[CLLocation alloc]  initWithLatitude:latitude longitude:longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
        
        
        
        if(error){
            NSLog(@"%@", [error localizedDescription]);
        }
        
        CLPlacemark *placemark = [placemarks lastObject];
        
        
        returnAddress = [NSString stringWithFormat:@"%@,%@",
                     
                         placemark.administrativeArea,
                         placemark.country];
        
        
        
        
        
        
      
        if ([returnAddress isEqualToString:@"(null),(null) "])
        {
            returnAddress =@"Unspecified";
        }
        
        
        
        if ([_frmMyacunt isEqualToString:@"Yes"] ) {
            [standardUserDefaults setObject:returnAddress forKey:@"location"];
            
        }else{
            [standardUserDefaults setObject:returnAddress forKey:@"location2nd"];          }
        
        
        
        
        
        if(locationManager)
        {
            locationManager=nil;
            locationManager.delegate=nil;
        }
        [self.navigationController popViewControllerAnimated:YES];
        
       
        
    }];
    
  
    
    
}


- (IBAction)Cununt_location_fn:(id)sender {
    
    if ([_frmMyacunt isEqualToString:@"Yes"] ) {
    
    [self loadLocation];    
    }else{
        [address resignFirstResponder];
        
        
        CLLocationCoordinate2D centre = [_mapView centerCoordinate];
        
        NSLog(@"centre latitude and longitude  %f, %f",centre.latitude,centre.longitude);
        
        latitude=centre.latitude;
        longitude=centre.longitude;
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString  *lat=[NSString stringWithFormat:@"%.8f", latitude];
        NSString  *log=[NSString stringWithFormat:@"%.8f", longitude];
        if (address.text.length>3) {
            
            
            
        }
        
        
       
        [self getmylocationname];
        adesconut=0;
            
        
            
            [standardUserDefaults setObject:lat forKey:@"lat2nd"];
            [standardUserDefaults setObject:log forKey:@"log2nd"];
        
       
        
        
        
        
        
        
        
        
        
        [standardUserDefaults synchronize];
        
        
        }
    
    
    
}





-(void)getmylocationname{
    
     NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"Begin");
    __block   NSString *returnAddress = @"";
    
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    adesconut++;
    
    
    
    [geocoder reverseGeocodeLocation:[[CLLocation alloc]  initWithLatitude:latitude longitude:longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error){
            NSLog(@"%@", [error localizedDescription]);
        }
        
        CLPlacemark *placemark = [placemarks lastObject];
        
        
        returnAddress = [NSString stringWithFormat:@"%@,%@",
                         
                         placemark.administrativeArea,
                         placemark.country];
        
        
        
        
        
        
       
     
            
            
            if ([returnAddress isEqualToString:@"(null),(null)"])
            {
                returnAddress =@"Unspecified";
                
           
               
              }
        
        appDelegate.ssearchdata=returnAddress;
        
        
        
        
        if ([_frmMyacunt isEqualToString:@"Yes"] ) {
            [standardUserDefaults setObject:returnAddress forKey:@"location"];
            
        }else{
            [standardUserDefaults setObject:returnAddress forKey:@"location3nd"];          }
        
        
        
        
        
        if(locationManager)
        {
            locationManager=nil;
            locationManager.delegate=nil;
        }
        
     [self performSelector:@selector(popup) withObject:nil afterDelay:.2];
        
        
    }];
    
    
    
}
-(void)popup{
    
           [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)address_typing_fn:(id)sender {
    
    if (address.text.length >4) {
        
        
        CLLocationCoordinate2D coordinates;
        
        
        
        
        latitude = locationFromLM.coordinate.latitude;
        longitude = locationFromLM.coordinate.longitude;
     
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
     hide=@"";
    
    
    if (placeArray.count==0) {
        _NearByTableView.hidden=YES;
    }
    
    
    
    else{
       
        _NearByTableView.hidden=NO;}
    return  YES;}
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    
     hide=@"";
    
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

    return  YES;
}





- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)stringt
{
    
    if ([hide isEqualToString:@""]) {
     
   
    
    
        [self performSelector:@selector(searchPlace) withObject:nil afterDelay:.2];}
    
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
            
         
            NSDictionary *jsonDct =[jsonArry objectAtIndex:0];
            
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
   
    
    CLLocationCoordinate2D coord = {.latitude =  latitude, .longitude =  longitude};
    MKCoordinateSpan span = {.latitudeDelta = 0.5, .longitudeDelta =  0.5};
    MKCoordinateRegion region = {coord, span};
    
    
       [_mapView setRegion:region animated:YES];
    
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
    _NearByTableView.hidden=YES;
    
    [address resignFirstResponder];
    hide=@"value";
    
    address.text=[[self.placeArray objectAtIndex:indexPath.row] objectForKey:@"description"];
    [self getLocationFromAddressString:address.text];
    
    
    
    
    
    
    
    
}






















@end

