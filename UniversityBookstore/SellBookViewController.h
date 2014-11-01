//
//  SellBookViewController.h
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

<<<<<<< HEAD
@interface SellBookViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIActionSheetDelegate>
=======
@interface SellBookViewController : UIViewController <UITextFieldDelegate, NSURLConnectionDelegate>
>>>>>>> 6699ca8804f9b2f425bc25d9bccf30d83ece8862
{
    IBOutlet UITextField *nameOfBook;
    IBOutlet UITextField *isbn;
    IBOutlet UITextView *description;
    IBOutlet UITextField *price;
    IBOutlet UITextField *category;
<<<<<<< HEAD
=======
    
>>>>>>> 6699ca8804f9b2f425bc25d9bccf30d83ece8862
}
- (IBAction)submit:(id)sender;


<<<<<<< HEAD
=======

>>>>>>> 6699ca8804f9b2f425bc25d9bccf30d83ece8862
@end
