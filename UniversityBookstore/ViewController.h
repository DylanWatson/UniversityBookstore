//
//  ViewController.h
//  UniversityBookstore
//
//  Created by Keyur Patel on 10/31/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    IBOutlet UIImageView *ImageView; 
    UIImagePickerController *picker;
    UIImage *image;
    
}

- (IBAction)TakePhoto:(id)sender;


@end

