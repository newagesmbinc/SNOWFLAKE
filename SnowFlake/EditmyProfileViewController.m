//
//  EditmyProfileViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/7/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "EditmyProfileViewController.h"
#import "UIImageView+WebCache.h"
#import "SelectMountainViewController.h"
#import "SCLAlertView.h"


@interface EditmyProfileViewController ()

@end

@implementation EditmyProfileViewController


#pragma mark - System Method


- (void)viewDidLoad {
    [super viewDidLoad];
     [self serverCallFunction];
    
    
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
   
    [appD.ProfileData removeAllObjects];
   serverCall=@"";
    [UserImage sd_setImageWithURL:[NSURL URLWithString:[appD.ServerData objectForKey:@"image"]] placeholderImage:nil];

    SelectLbl.text=[[appD.ServerData objectForKey:@"profile"]objectForKey:@"mountains_name"];
    NSMutableDictionary *article3 = [[NSMutableDictionary alloc] init];
    [ article3 setObject:[[appD.ServerData objectForKey:@"profile"]objectForKey:@"mountains_name"]  forKey:@"name"];
    
    [ article3 setObject:[appD.ServerData objectForKey:@"mountain_id"]  forKey:@"id"];
    
    [appD.ProfileData setObject:article3 forKey:@"Mountain"];
    
    NameLbl.text=[NSString stringWithFormat:@"%@, %@",[appD.ServerData objectForKey:@"first_name"],[appD.ServerData objectForKey:@"age"]];
    HeadLbl.text=[appD.ServerData objectForKey:@"location"];
    skivalue=[[appD.ServerData objectForKey:@"profile"]objectForKey:@"skiing_name"];
    
    svalue=[[appD.ServerData objectForKey:@"profile"]objectForKey:@"snowboarding_name"];
    
    if ([skivalue isEqualToString:@"Noob"]) {
        skiradioPic1.image=[UIImage imageNamed:@"radiograyactive.png"];
        skiradioPic2.image=[UIImage imageNamed:@"radiograynorm.png"];
        skiradioPic3.image=[UIImage imageNamed:@"radiograynorm.png"];
        skivalue=@"Noob";
    }else if ([skivalue isEqualToString:@"Pro"])
    
    
    {
        skivalue=@"Pro";
        
        skiradioPic1.image=[UIImage imageNamed:@"radiograynorm.png"];
        skiradioPic2.image=[UIImage imageNamed:@"radiograynorm.png"];
        skiradioPic3.image=[UIImage imageNamed:@"radiograyactive.png"];
        
        
    }
    else{
        
        skivalue=@"Intermediate";
        
        skiradioPic1.image=[UIImage imageNamed:@"radiograynorm.png"];
        skiradioPic2.image=[UIImage imageNamed:@"radiograyactive.png"];
        skiradioPic3.image=[UIImage imageNamed:@"radiograynorm.png"];
        
        
    }
    if ([svalue isEqualToString:@"Noob"]) {
        sradioPic1.image=[UIImage imageNamed:@"radiograyactive.png"];
        sradioPic2.image=[UIImage imageNamed:@"radiograynorm.png"];
        sradioPic3.image=[UIImage imageNamed:@"radiograynorm.png"];
        svalue=@"Noob";
    }else if ([svalue isEqualToString:@"Pro"])
        
        
    {
        svalue=@"Pro";
        
        sradioPic1.image=[UIImage imageNamed:@"radiograynorm.png"];
        sradioPic2.image=[UIImage imageNamed:@"radiograynorm.png"];
        sradioPic3.image=[UIImage imageNamed:@"radiograyactive.png"];
        
        
    }
    else{
        
        svalue=@"Intermediate";
        
        sradioPic1.image=[UIImage imageNamed:@"radiograynorm.png"];
        sradioPic2.image=[UIImage imageNamed:@"radiograyactive.png"];
        sradioPic3.image=[UIImage imageNamed:@"radiograynorm.png"];
        
        
    }
    
    NSMutableDictionary *article = [[NSMutableDictionary alloc] init];
    
    
    [ article setObject:svalue forKey:@"name"];
    if ([svalue isEqualToString:@"Noob"]) {
        [ article setObject:@"1" forKey:@"id"];    }
    
    
    else if ([svalue isEqualToString:@"Pro"]) {
        [ article setObject:@"3"  forKey:@"id"];}
    else{
        [ article setObject:@"2"  forKey:@"id"];
    }
    
    [appD.ProfileData setObject:article forKey:@"snowboarding_values"];
    
    NSMutableDictionary *article1 = [[NSMutableDictionary alloc] init];
    
    
    [ article1 setObject:skivalue forKey:@"name"];
    if ([skivalue isEqualToString:@"Noob"]) {
        [ article1 setObject:@"1" forKey:@"id"];    }
    
    
    else if ([skivalue isEqualToString:@"Pro"]) {
        [ article1 setObject:@"3"  forKey:@"id"];}
    else{
        [ article1 setObject:@"2"  forKey:@"id"];
    }
    
    [appD.ProfileData setObject:article1 forKey:@"skiing_values"];
    
    
    
    
    
    
    
    
    
    focusArry=[[appD.ServerData objectForKey:@"profile"] objectForKey:@"focus_on_name_array"];
     areaArry=[[appD.ServerData objectForKey:@"profile"] objectForKey:@"area_to_improve_name_array"];
    MuntValue1=[[NSMutableArray alloc]init];
    
    
    for (int i=0; i<[focusArry count]; i++) {
    
    
    if ([[[focusArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"1"]) {
        fvalue1=@"1";
        [ MuntValue1  addObject:@"1"];
    
    
    }
    else if ([[[focusArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"2"]) {
        fvalue2=@"1";
         [ MuntValue1  addObject:@"2"];    }
    else if ([[[focusArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"3"]) {
        fvalue3=@"1";
        
         [ MuntValue1  addObject:@"3"];
        
    }else if ([[[focusArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"4"]) {
        fvalue4=@"1";
         [ MuntValue1  addObject:@"4"];
        
        
    }else if ([[[focusArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"5"]) {
        fvalue5=@"1";
        
         [ MuntValue1  addObject:@"5"];
        
    }else if ([[[focusArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"6"]) {
        fvalue6=@"1";
        
         [ MuntValue1  addObject:@"6"];
        
    }
    }
    if([fvalue1 isEqualToString:@"1"]){
        
         fradioPic1.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        fradioPic1.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
    if([fvalue2 isEqualToString:@"1"]){
        
        fradioPic2.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        fradioPic2.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
    if([fvalue3 isEqualToString:@"1"]){
        
        fradioPic3.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        fradioPic3.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
    if([fvalue4 isEqualToString:@"1"]){
        
        fradioPic4.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        fradioPic4.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
    if([fvalue5 isEqualToString:@"1"]){
        
        fradioPic5.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        fradioPic5.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
    if([fvalue6 isEqualToString:@"1"]){
        
        fradioPic6.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        fradioPic6.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
     MuntValue=[[NSMutableArray alloc]init];
    
    for (int i=0; i<[areaArry count]; i++) {
        
        
        if ([[[areaArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"1"]) {
            value1=@"1";
             [ MuntValue  addObject:@"1"];
            
            
        }
        else if ([[[areaArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"2"]) {
            value2=@"1";
            
             [ MuntValue  addObject:@"2"];
            
        }
        else if ([[[areaArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"3"]) {
            value3=@"1";
             [ MuntValue  addObject:@"3"];
            
            
        }else if ([[[areaArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"4"]) {
            value4=@"1";
             [ MuntValue  addObject:@"4"];
            
            
        }else if ([[[areaArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"5"]) {
            value5=@"1";
             [ MuntValue  addObject:@"5"];
            
            
        }else if ([[[areaArry objectAtIndex:i]objectForKey:@"id"] isEqualToString:@"6"]) {
            value6=@"1";
            
             [ MuntValue  addObject:@"6"];
            
        }
    }
    if([value1 isEqualToString:@"1"]){
        
        radioPic1.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        radioPic1.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
    if([value2 isEqualToString:@"1"]){
        
        radioPic2.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        radioPic2.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
    if([value3 isEqualToString:@"1"]){
        
        radioPic3.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        radioPic3.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
    if([value4 isEqualToString:@"1"]){
        
        radioPic4.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        radioPic4.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
    if([value5 isEqualToString:@"1"]){
        
        radioPic5.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        radioPic5.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
    if([value6 isEqualToString:@"1"]){
        
        radioPic6.image=[UIImage imageNamed:@"graycheckactive.png"];
    }else{
        radioPic6.image=[UIImage imageNamed:@"graychecknorm.png"];    }
    
    
    
    [appD.ProfileData setObject:MuntValue forKey:@"focus_on_values"];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
   
    [MainSroll setContentSize:CGSizeMake(screenWidth, 930)];
   
}

-(void)viewWillAppear:(BOOL)animated{
   
    if ([[appD.ProfileData objectForKey:@"Mountain"] count]>0) {
        SelectLbl.text=[[appD.ProfileData objectForKey:@"Mountain"]objectForKey:@"name"];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }

#pragma mark - Server Call




-(void)serverCallFunction{
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];    
    
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
   
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"get_editing_info\", \"parameters\": {\"user_id\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"]];
    NSLog(@"post------%@",postData);
    //
    [server sendServerRequests:postData];
    
    
}


#pragma mark - Server Response



-(void)ServerRequestProcessFinish:(NSString *)serverResponse
{
    
    if ([serverResponse isEqualToString:@"ERROR"]) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showInfo:self title:@"Connection error"
                subTitle:@"Cannot connect with server. Please try again later."
        closeButtonTitle:@"OK" duration:0.0f];
        
        }else{
        NSData *data=[serverResponse dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSError *er;
        
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&er];
       
        
        
        if (![ serverCall isEqualToString:@""]) {
            
            appD.ServerData=[dict mutableCopy];
            
        }else{
        
      
     serverCalldata=[dict mutableCopy];
        
        }
        
        serverDataLbl1.text=[[[serverCalldata objectForKey:@"area_to_improve_values"] objectAtIndex:0]objectForKey:@"name"];
            serverDataLbl2.text=[[[serverCalldata objectForKey:@"area_to_improve_values"] objectAtIndex:1]objectForKey:@"name"];
            serverDataLbl3.text=[[[serverCalldata objectForKey:@"area_to_improve_values"] objectAtIndex:2]objectForKey:@"name"];
            serverDataLbl4.text=[[[serverCalldata objectForKey:@"area_to_improve_values"] objectAtIndex:3]objectForKey:@"name"];
        
            serverDataLbl5.text=[[[serverCalldata objectForKey:@"area_to_improve_values"] objectAtIndex:4]objectForKey:@"name"];
            serverDataLbl6.text=[[[serverCalldata objectForKey:@"area_to_improve_values"] objectAtIndex:5]objectForKey:@"name"];
        
       
        fserverDataLbl1.text=[[[serverCalldata objectForKey:@"focus_on_values"] objectAtIndex:0]objectForKey:@"name"];
        fserverDataLbl2.text=[[[serverCalldata objectForKey:@"focus_on_values"] objectAtIndex:1]objectForKey:@"name"];
        fserverDataLbl3.text=[[[serverCalldata objectForKey:@"focus_on_values"] objectAtIndex:2]objectForKey:@"name"];
        fserverDataLbl4.text=[[[serverCalldata objectForKey:@"focus_on_values"] objectAtIndex:3]objectForKey:@"name"];
        
        fserverDataLbl5.text=[[[serverCalldata objectForKey:@"focus_on_values"] objectAtIndex:4]objectForKey:@"name"];
        fserverDataLbl6.text=[[[serverCalldata objectForKey:@"focus_on_values"] objectAtIndex:5]objectForKey:@"name"];
   
    }
}


#pragma mark - Navigation

-(IBAction)selectMoun:(id)sender{
    
    
    SelectMountainViewController *reveal =(SelectMountainViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SelectMountainViewController"];
    
        reveal.dataMount=[serverCalldata objectForKey:@"mountains_list"];
    [self.navigationController pushViewController:reveal animated:YES];
    
}

 -(IBAction)back:(id)sender{
 
 [self.navigationController popViewControllerAnimated:YES];
 
 }


#pragma mark - Button Action


-(IBAction)skiRadioOne:(id)sender{
    skiradioPic1.image=[UIImage imageNamed:@"radiograyactive.png"];
    skiradioPic2.image=[UIImage imageNamed:@"radiograynorm.png"];
    skiradioPic3.image=[UIImage imageNamed:@"radiograynorm.png"];
    skivalue=@"Noob";
    
    
}
-(IBAction)skiRadiotwo:(id)sender{
    
    
    skivalue=@"Intermediate";
    
    skiradioPic1.image=[UIImage imageNamed:@"radiograynorm.png"];
    skiradioPic2.image=[UIImage imageNamed:@"radiograyactive.png"];
    skiradioPic3.image=[UIImage imageNamed:@"radiograynorm.png"];
    
}
-(IBAction)skiRadioThree:(id)sender{
    
    
    skivalue=@"Pro";
    
    skiradioPic1.image=[UIImage imageNamed:@"radiograynorm.png"];
    skiradioPic2.image=[UIImage imageNamed:@"radiograynorm.png"];
    skiradioPic3.image=[UIImage imageNamed:@"radiograyactive.png"];
    
    
}


-(IBAction)sRadioOne:(id)sender{
    sradioPic1.image=[UIImage imageNamed:@"radiograyactive.png"];
    sradioPic2.image=[UIImage imageNamed:@"radiograynorm.png"];
    sradioPic3.image=[UIImage imageNamed:@"radiograynorm.png"];
    svalue=@"Noob";
    
    
}
-(IBAction)sRadiotwo:(id)sender{
    
    
    svalue=@"Intermediate";
    
    sradioPic1.image=[UIImage imageNamed:@"radiograynorm.png"];
    sradioPic2.image=[UIImage imageNamed:@"radiograyactive.png"];
    sradioPic3.image=[UIImage imageNamed:@"radiograynorm.png"];
    
}
-(IBAction)sRadioThree:(id)sender{
    
    
    skivalue=@"Pro";
    
    sradioPic1.image=[UIImage imageNamed:@"radiograynorm.png"];
    sradioPic2.image=[UIImage imageNamed:@"radiograynorm.png"];
    sradioPic3.image=[UIImage imageNamed:@"radiograyactive.png"];
    
    
}
-(IBAction)fRadioOne:(id)sender{
    if ([fvalue1 isEqualToString:@"1"]) {
        
        fvalue1=@"0";
        fradioPic1.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        fvalue1=@"1";
        fradioPic1.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
}
-(IBAction)fRadiotwo:(id)sender{
    
    
    if ([fvalue2 isEqualToString:@"1"]) {
        
        fvalue2=@"0";
        fradioPic2.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        fvalue2=@"1";
        fradioPic2.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
    
}
-(IBAction)fRadioThree:(id)sender{
    
    
    if ([fvalue3 isEqualToString:@"1"]) {
        
        fvalue3=@"0";
        fradioPic3.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        fvalue3=@"1";
        fradioPic3.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
}

-(IBAction)fRadiofour:(id)sender{
    if ([fvalue4 isEqualToString:@"1"]) {
        
        fvalue4=@"0";
        fradioPic4.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        fvalue4=@"1";
        fradioPic4.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
}
-(IBAction)fRadiofive:(id)sender{
    
    
    if ([fvalue5 isEqualToString:@"1"]) {
        
        fvalue5=@"0";
        fradioPic5.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        fvalue5=@"1";
        fradioPic5.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
    
}
-(IBAction)fRadiosix:(id)sender{
    
    
    if ([fvalue6 isEqualToString:@"1"]) {
        
        
        fvalue6=@"0";
        fradioPic6.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        fvalue6=@"1";
        fradioPic6.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
}






-(IBAction)RadioOne:(id)sender{
    if ([value1 isEqualToString:@"1"]) {
        
        value1=@"0";
        radioPic1.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value1=@"1";
        radioPic1.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
}
-(IBAction)Radiotwo:(id)sender{
    
    
    if ([value2 isEqualToString:@"1"]) {
        
        value2=@"0";
        radioPic2.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value2=@"1";
        radioPic2.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
    
}
-(IBAction)RadioThree:(id)sender{
    
    
    if ([value3 isEqualToString:@"1"]) {
        
        value3=@"0";
        radioPic3.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value3=@"1";
        radioPic3.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
}

-(IBAction)Radiofour:(id)sender{
    if ([value4 isEqualToString:@"1"]) {
        
        value4=@"0";
        radioPic4.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value4=@"1";
        radioPic4.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
}
-(IBAction)Radiofive:(id)sender{
    
    
    if ([value5 isEqualToString:@"1"]) {
        
        value5=@"0";
        radioPic5.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value5=@"1";
        radioPic5.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
    
}
-(IBAction)Radiosix:(id)sender{
    
    
    if ([value6 isEqualToString:@"1"]) {
        
        value6=@"0";
        radioPic6.image=[UIImage imageNamed:@"graychecknorm.png"];
    }else{
        value6=@"1";
        radioPic6.image=[UIImage imageNamed:@"graycheckactive.png"];
    }
    
    
    
}

#pragma mark - Button Action & Server Call
-(IBAction)save:(id)sender{

    NSMutableDictionary *article = [[NSMutableDictionary alloc] init];
    serverCall=@"Edit";
    [ article setObject:skivalue forKey:@"name"];
    if ([skivalue isEqualToString:@"Noob"]) {
        [ article setObject:@"1" forKey:@"id"];    }
    
    
    else if ([skivalue isEqualToString:@"Pro"]) {
        [ article setObject:@"3"  forKey:@"id"];}
    else{
        [ article setObject:@"2"  forKey:@"id"];
    }
    
    NSMutableDictionary *article1 = [[NSMutableDictionary alloc] init];
    
    
    [ article1 setObject:svalue forKey:@"name"];
    if ([svalue isEqualToString:@"Noob"]) {
        [ article1 setObject:@"1" forKey:@"id"];    }
    
    
    else if ([svalue isEqualToString:@"Pro"]) {
        [ article1 setObject:@"3"  forKey:@"id"];}
    else{
        [ article1 setObject:@"2"  forKey:@"id"];
    }
    [appD.ProfileData setObject:article1 forKey:@"snowboarding_values"];
    
    if ([value1 isEqualToString:@"1"]) {
        
           if (![MuntValue1 containsObject:@"1"]) {
        
        
               [ MuntValue1  addObject:@"1"];}
    }else{
        [MuntValue1 removeObject:@"1"];
    
    
    }
    
    if ([value2 isEqualToString:@"1"]) {
        
        if (![MuntValue1 containsObject:@"2"]) {
            
            
            [ MuntValue1  addObject:@"2"];}
    }else{
        [MuntValue1 removeObject:@"2"];
        
        
    }
    
    if ([value3 isEqualToString:@"1"]) {
        
        if (![MuntValue1 containsObject:@"3"]) {
            
            
            [ MuntValue1  addObject:@"3"];}
    }else{
        [MuntValue1 removeObject:@"3"];
        
        
    }
    if ([value4 isEqualToString:@"1"]) {
        
        
        
        
        if (![MuntValue1 containsObject:@"4"]) {
            
            
            [ MuntValue1  addObject:@"4"];}
    }else{
        [MuntValue1 removeObject:@"4"];
        
        
    }
    if ([value5 isEqualToString:@"1"]) {
        
        
        
        
        if (![MuntValue1 containsObject:@"5"]) {
            
            
            [ MuntValue1  addObject:@"5"];}
    }else{
        [MuntValue1 removeObject:@"5"];
        
        
    }
    if ([value6 isEqualToString:@"1"]) {
        
        
        
        if (![MuntValue1 containsObject:@"6"]) {
            
            
            [ MuntValue1  addObject:@"6"];}
    }else{
        [MuntValue1 removeObject:@"6"];
        
        
    }
    if ([fvalue1 isEqualToString:@"1"]) {
        
        
        if (![MuntValue containsObject:@"1"]) {
            
            
            [ MuntValue  addObject:@"1"];}
    }else{
        [MuntValue removeObject:@"1"];
        
        
    }
    
    if ([fvalue2 isEqualToString:@"1"]) {
        
        
        if (![MuntValue containsObject:@"2"]) {
            
            
            [ MuntValue  addObject:@"2"];}
    }else{
        [MuntValue removeObject:@"2"];
        
        
    }
    
    
    if ([fvalue3 isEqualToString:@"1"]) {
        
        
        
        if (![MuntValue containsObject:@"3"]) {
            
            
            [ MuntValue  addObject:@"3"];}
    }else{
        [MuntValue removeObject:@"3"];
        
        
    }
    
    
    if ([fvalue4 isEqualToString:@"1"]) {
        
        
        
        if (![MuntValue containsObject:@"4"]) {
            
            
            [ MuntValue  addObject:@"4"];}
    }else{
        [MuntValue removeObject:@"4"];
        
        
    }
    
    if ([fvalue5 isEqualToString:@"1"]) {
        
        
        if (![MuntValue containsObject:@"5"]) {
            
            
            [ MuntValue  addObject:@"5"];}
    }else{
        [MuntValue removeObject:@"5"];
        
        
    }
    
    if ([fvalue6 isEqualToString:@"1"]) {
        
        
        
        if (![MuntValue containsObject:@"6"]) {
            
            
            [ MuntValue  addObject:@"6"];}
    }else{
        [MuntValue removeObject:@"6"];
        
        
    }
    
    
    
    [appD.ProfileData setObject:article forKey:@"skiing_values"];
    
    NSString *joinedComponents = [MuntValue componentsJoinedByString:@","];
    
    NSString *joinedComponents1 = [MuntValue1 componentsJoinedByString:@","];
    
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    ServerRequests *server=[[ServerRequests alloc]init];
    server.server_req_proces=self;
    
    
    NSString *postData =[[NSString alloc] initWithFormat:@"{\"function\":\"complete_profile\", \"parameters\": {\"user_id\": \"%@\",\"mountain_id\": \"%@\",\"skiing_id\": \"%@\",\"snowboarding_id\": \"%@\",\"focus_on\": \"%@\",\"area_to_improve\": \"%@\"},\"token\":\"\"}",[standardUserDefaults objectForKey:@"user_id"],[[appD.ProfileData objectForKey:@"Mountain"] objectForKey:@"id"],[[appD.ProfileData objectForKey:@"skiing_values"] objectForKey:@"id"],[[appD.ProfileData objectForKey:@"snowboarding_values"] objectForKey:@"id"],joinedComponents1,joinedComponents];
    NSLog(@"post------%@",postData);

    [server sendServerRequests:postData];
    
    
    
}














@end
