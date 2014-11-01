//
//  RegistrationViewController.h
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "RegistrationViewController.h"
#import "RootNavigationController.h"

@implementation RegistrationViewController


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad
{
    name.delegate = self;
    email.delegate = self;
    password.delegate = self;
    phone.delegate = self;
    university.delegate = self;
    bankAccountNumber.delegate = self;
    
    [self setNeedsStatusBarAppearanceUpdate];
    [super viewDidLoad];
}

-(IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)submit:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://172.26.5.205:3000/register"];
    NSData *responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *bodydata = [NSString stringWithFormat:@"name=%@&email=%@&password=%@&phone=%@&university=%@&account=%@", name.text, email.text, password.text, phone.text, university.text, bankAccountNumber.text];
    
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
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == name)
    {
        [name resignFirstResponder];
        [email becomeFirstResponder];
    }
    else if(textField == email)
    {
        [password becomeFirstResponder];
    }
    else if(textField == password)
    {
        [phone becomeFirstResponder];
    }
    else if(textField == phone)
    {
        [university becomeFirstResponder];
    }
    else if(textField == university)
    {
        [bankAccountNumber becomeFirstResponder];
    }
    else
    {
        [bankAccountNumber resignFirstResponder];
    }
    return YES;
}

@end
