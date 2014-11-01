//
//  UploadPicture.h
//  UniversityBookstore
//
//  Created by Keyur Patel on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadPicture : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UIImageView *ImageView;
}

- (IBAction)takePhoto:(id)sender;

@end
