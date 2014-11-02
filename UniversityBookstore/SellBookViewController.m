//
//  SellBookViewController.m
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "SellBookViewController.h"
#import "FAImageView.h"
#import "NSString+FontAwesome.h"

@interface SellBookViewController ()
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) UIImage *image;
@end

@implementation SellBookViewController
@synthesize image;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nameOfBook.delegate = self;
    isbn.delegate = self;
    description.delegate = self;
    price.delegate = self;
    category.delegate = self;
    cameraButton.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:35];
    cameraButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    [cameraButton setTitle:[NSString fontAwesomeIconStringForEnum:FACamera] forState:UIControlStateNormal];
    [cameraButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSArray *data = [[NSArray alloc] initWithObjects:@"Computer Science", @"Mathematics", @"Chemistry", @"Physics", @"Biology", nil];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(textField == category)
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}


-(IBAction)submit:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://172.26.5.205:3000/sellbook"];
    NSData *responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    ///////////////////////////////////////////////////////////
    //Later we have to check to make sure these are not null///
    ///////////////////////////////////////////////////////////
    
    NSString *email = [defaults objectForKey:@"email"];
    NSString *password = [defaults objectForKey:@"password"];
    NSString *session = [defaults objectForKey:@"session_id"];
    NSString *img64 = @"";
    if(image != nil)
    {
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        img64 = [data base64Encoding];
    }
    NSString *bodydata = [NSString stringWithFormat:@"email=%@&password=%@&session_id=%@&title=%@&description=%@&category=%@&isbn=%@&price=%@&image=%@", email, password, session, nameOfBook.text, description.text, category.text, isbn.text, price.text, img64];
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSURLResponse *response;
    NSError *error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"DATA: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    if(json != nil && [json objectForKey:@"id"] != nil)
    {
        
    }
    //NSString* result = [[NSString alloc] initWithData:req encoding:NSUTF8StringEncoding];
}

- (IBAction)camera:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Camera" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:nil];
    
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Library", @"Photo Library")
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        self.picker =  [[UIImagePickerController alloc]init];
                                        self.picker.delegate = self;
                                        [self.picker setSourceType:(UIImagePickerControllerSourceTypePhotoLibrary)];
                                        [self presentViewController:self.picker animated:YES completion:NULL ];
                                    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Camera", @"Camera")
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        self.picker =  [[UIImagePickerController alloc]init];
                                        self.picker.delegate = self;
                                        [self.picker setSourceType:(UIImagePickerControllerSourceTypeCamera)];
                                        [self presentViewController:self.picker animated:YES completion:NULL ];
                                    }];
    [alertController addAction:cancelAction];
    [alertController addAction:libraryAction];
    [alertController addAction:cameraAction];
    
     [self presentViewController:alertController animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    CGRect rect = CGRectMake(0,0,image.size.width*.3,image.size.height*.3);
    UIGraphicsBeginImageContext( rect.size );
    [image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    image = [UIImage imageWithData:imageData];
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


@end
