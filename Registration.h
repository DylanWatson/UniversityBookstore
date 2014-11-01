//
//  Registration.h
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Registration : UIViewController
{
    IBOutlet UITextField *name;
    IBOutlet UITextField *email;
    IBOutlet UITextField *password;
    IBOutlet UITextField *university;
    IBOutlet UITextField *bankAccountNumber;
    
}
- (IBAction)buttonPressed:(id)sender;

@end
