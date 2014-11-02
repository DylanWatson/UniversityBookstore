//
//  SearchBooksViewController.m
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "SearchBooksViewController.h"
#import "BooksForSaleTableViewController.h"

@interface SearchBooksViewController ()

@end

@implementation SearchBooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)search:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://172.26.5.205:3000/findbook"];
    NSData *responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *bodydata = [NSString stringWithFormat:@"query=%@", searchBar.text];
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSURLResponse *response;
    NSError *error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"DATA: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    NSArray *json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    ///////////////////////////////////////////////////////////
    ///////Doesn't check for null or if the item is sold///////
    ///////////////////////////////////////////////////////////
    //NSArray *bookTitle = [[json objectAtIndex:0] objectForKey:@"title"];
    //NSLog(@"%@", bookTitle);
    //NSString *description = [json objectForKey:@"description"];
    //NSString *category = [json objectForKey:@"category"];
   // NSString *price = [json objectForKey:@"price"];
    //NSLog(@"Title: %@ \nDescription: %@ \nCategory: %@ \nPrice: %@", bookTitle, description, category, price);
    //NSString* result = [[NSString alloc] initWithData:req encoding:NSUTF8StringEncoding];
    NSUserDefaults *arrayOfBooks = [NSUserDefaults standardUserDefaults];
    [arrayOfBooks setObject:json forKey:@"listOfBooks"];

    
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
