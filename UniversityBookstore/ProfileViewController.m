//
//  ProfileViewController.m
//  UniversityBookstore
//
//  Created by Keyur Patel on 11/2/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "ProfileViewController.h"
#import "HomeViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)signout:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://172.26.5.205:3000/logout"];
    NSData *responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *bodydata = [NSString stringWithFormat:@"email=%@&password=%@&session_id=%@", [defaults objectForKey:@"email"], [defaults objectForKey:@"password"], [defaults objectForKey:@"session_id"]];
    
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSURLResponse *response;
    NSError *error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if([result isEqualToString:@"Success"])
    {
        [defaults removeObjectForKey:@"email"];
        [defaults removeObjectForKey:@"password"];
        [defaults removeObjectForKey:@"session_id"];

        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        
        HomeViewController *controller = (HomeViewController*)[mainStoryboard
                                                                       instantiateViewControllerWithIdentifier: @"HomeViewController"];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Session" message:@"There is an issue with your session. Try restarting the application" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *close = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:close];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
