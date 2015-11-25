//
//  webDetailViewController.m
//  SnowFlake
//
//  Created by NewAgeSMB on 11/10/15.
//  Copyright © 2015 NewAgeSMB. All rights reserved.
//

#import "webDetailViewController.h"

@interface webDetailViewController ()
@end

@implementation webDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    webLbl.text=_webData;
    
    NSString *urlsString;
    
    if ([_webData isEqualToString:@"Terms & Conditions"]) {
    urlsString = [NSString stringWithFormat:@"%@client/terms_of_use",appDelegate.ServerURL];}
    
    else{urlsString = @"https://www.iubenda.com/privacy-policy/469600";}
    
    NSURL *url = [NSURL URLWithString:urlsString];
    NSURLRequest *rqst = [NSURLRequest requestWithURL:url];
    [webView loadRequest:rqst];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(IBAction)back:(id)sender{[self.navigationController popViewControllerAnimated:YES];}


@end
