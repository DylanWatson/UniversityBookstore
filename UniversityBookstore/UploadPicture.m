//
//  UploadPicture.m
//  UniversityBookstore
//
//  Created by Keyur Patel on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "UploadPicture.h"

@interface UploadPicture ()
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) UIImage *image;
@end

@implementation UploadPicture
@synthesize picker, image;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)takePhoto:(id)sender
{
    picker =  [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:(UIImagePickerControllerSourceTypeCamera)];
    [self presentViewController:picker animated:YES completion:NULL ];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [ImageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *) picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
