//
//  SellBookViewController.h
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellBookViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIActionSheetDelegate>
{
    IBOutlet UITextField *nameOfBook;
    IBOutlet UITextField *isbn;
    IBOutlet UITextView *description;
    IBOutlet UITextField *price;
    IBOutlet UITextField *category;
}

@end
