//
//  LoginViewController.h
//  UniversityBookstore
//
//  Created by Keyur Patel on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *email;
    IBOutlet UITextField *password;
    
}
- (IBAction)dismiss:(id)sender;
- (IBAction)submit:(id)sender;

@end
