//
//  SellBookViewController.m
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "SellBookViewController.h"

@interface SellBookViewController ()
@property (strong, nonatomic) NSArray *array;

@end

@implementation SellBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *data = [[NSArray alloc] initWithObjects:@"Computer Science", @"Mathematics", @"Chemistry", @"Physics", @"Biology", nil];
    
    category.delegate = self;
    
    self.array = data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(textField == category)
    {
        [textField resignFirstResponder];
        [self showPicker:nil];
        return NO;
    }
    return YES;
}

- (void) showPicker:(id)sender {

    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [price becomeFirstResponder];
}

#pragma mark Picker Data Source Methods

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_array count];
}

#pragma mark Picker Delegate Methods

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_array objectAtIndex:row];
}

@end
