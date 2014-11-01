//
//  RegistrationViewController.h
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "RegistrationViewController.h"

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
