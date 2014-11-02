//
//  LoginViewController.m
//  UniversityBookstore
//
//  Created by Keyur Patel on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "LoginViewController.h"
#import "RootNavigationController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

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

-(IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)submit:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://172.26.5.205:3000/login"];
    NSData *responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *bodydata = [NSString stringWithFormat:@"email=%@&password=%@", email.text, password.text];
    
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSURLResponse *response;
    NSError *error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"DATA: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    NSString *session = [json objectForKey:@"session_id"];
    if(session != nil)
    {
        NSLog(@"Session: %@", session);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:email.text forKey:@"email"];
        [defaults setObject:password.text forKey:@"password"];
        [defaults setObject:session forKey:@"session_id"];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        
        UINavigationController *controller = (UINavigationController*)[mainStoryboard
                                                                       instantiateViewControllerWithIdentifier: @"RootNavigationController"];
        
        RootNavigationController *navController = (RootNavigationController *)controller;
        [self presentViewController:navController animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Credentials" message:@"Check your credentials and try again" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *close = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:close];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == email)
    {
        [email resignFirstResponder];
        [password becomeFirstResponder];
    }
    else
    {
        [password resignFirstResponder];
    }
    return YES;
}

@end
