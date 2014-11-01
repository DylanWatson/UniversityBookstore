//
//  SellBookViewController.h
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellBookViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet UITextField *nameOfBook;
    IBOutlet UITextField *isbn;
    IBOutlet UITextField *description;
    IBOutlet UITextField *price;
    
}

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)buttonPressed:(id)sender;

@end
