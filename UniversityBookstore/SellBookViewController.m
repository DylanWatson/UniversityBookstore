//
//  SellBookViewController.m
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "SellBookViewController.h"

@interface SellBookViewController ()

@end

@implementation SellBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nameOfBook.delegate = self;
    isbn.delegate = self;
    description.delegate = self;
    price.delegate = self;
    category.delegate = self;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(textField == category)
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}


-(IBAction)submit:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://172.26.5.205:3000/sellbook"];
    NSData *responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    ///////////////////////////////////////////////////////////
    //Later we have to check to make sure these are not null///
    ///////////////////////////////////////////////////////////
    
    NSString *email = [defaults objectForKey:@"email"];
    NSString *password = [defaults objectForKey:@"password"];
    NSString *session = [defaults objectForKey:@"email"];
    NSString *bodydata = [NSString stringWithFormat:@"email=%@&password=%@&session_id=%@&title=%@&description=%@&category=%@&isbn=%@&price=%@", email, password, session, nameOfBook.text, isbn.text, description.text, price.text, category.text];
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSURLResponse *response;
    NSError *error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"DATA: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    //NSString* result = [[NSString alloc] initWithData:req encoding:NSUTF8StringEncoding];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
