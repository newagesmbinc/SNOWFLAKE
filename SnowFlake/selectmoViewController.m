//
//  selectmoViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 10/8/15.
//  Copyright (c) 2015 NewAgeSMB. All rights reserved.
//

#import "selectmoViewController.h"
#import "SelectMountainTableViewCell.h"

@interface selectmoViewController ()

@end

@implementation selectmoViewController

#pragma mark - System Method


- (void)viewDidLoad {
    [super viewDidLoad];
    appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    _MonutainTable.separatorColor = [UIColor clearColor];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

-(IBAction)back:(id)sender{[self.navigationController popViewControllerAnimated:YES];}

-(void)getTodoList{[self.navigationController popViewControllerAnimated:YES];}






#pragma mark - TableView

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return 1;
    
}





-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    
    
    return [_dataMount count];
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    
    static NSString *myCellIdentifier = @"SelectMountainTableViewCell";
    
    
    
    SelectMountainTableViewCell *cell = (SelectMountainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
    
    
    
    if (cell == nil) {
        
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"SelectMountainTableViewCell" owner:self options:nil];
        
        cell = [array objectAtIndex:0];
        
    }
    
    
    
    cell.MountName.text=[[_dataMount objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    
    cell.selectImage.hidden=YES;
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
 
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;

cell.layer.anchorPoint = CGPointMake(0.5, 0.0);

    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    
    [UIView commitAnimations];
    
    
    
    
    
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    SelectMountainTableViewCell *cell = (SelectMountainTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectImage.hidden = NO;
    
    
    NSMutableDictionary *article = [[NSMutableDictionary alloc] init];
    
    
    [ article setObject:[[_dataMount objectAtIndex:indexPath.row] objectForKey:@"name"] forKey:@"name"];
    
    [ article setObject:[[_dataMount objectAtIndex:indexPath.row] objectForKey:@"id"] forKey:@"id"];
    
    [appD.ProfileData setObject:article forKey:@"Mountain"];
    
    [self performSelector:@selector(getTodoList) withObject:nil afterDelay:.25];
    
    
    
}









@end
