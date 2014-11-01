//
//  ViewController.m
//  UniversityBookstore
//
//  Created by Keyur Patel on 10/31/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)TakePhoto:(id)sender
{
    picker =  [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:(UIImagePickerControllerSourceTypeCamera)];
    [self presentViewController:picker animated:YES completion:NULL ];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image = [info objectForKey@"UIImagePickerControllerOriginalImage"];
    [ImageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *) picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
