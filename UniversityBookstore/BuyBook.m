//
//  BuyBook.m
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "BuyBook.h"
@interface BuyBook ()
@property (strong, nonatomic) NSArray *array;
@end

@implementation BuyBook

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *data = [[NSArray alloc] initWithObjects:@"Computer Science", @"Mathematics", @"Chemistry", @"Physics", @"Biology", nil];
    
    self.array = data;
}

-(IBAction)buttonPressed:(id)sender
{
    NSString *select = [_array objectAtIndex:[_picker selectedRowInComponent:0]];
    
    NSString *title = [[NSString alloc] initWithFormat:@"You selected %@!", select];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"YAY!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
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
