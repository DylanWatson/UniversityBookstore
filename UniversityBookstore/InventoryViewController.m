//
//  InventoryViewController.m
//  UniversityBookstore
//
//  Created by Keyur Patel on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "InventoryViewController.h"

@interface InventoryViewController ()
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *items;
@end

@implementation InventoryViewController
@synthesize tableView;

- (void)viewDidLoad
{
    self.tableView = [[UITableView alloc] init];
    self.items = [[NSMutableArray alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *url = [NSURL URLWithString:@"http://172.26.5.205:3000/inventory"];
    NSData *responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *bodydata = [NSString stringWithFormat:@"email=%@&password=%@&session_id=%@", [defaults objectForKey:@"email"], [defaults objectForKey:@"password"], [defaults objectForKey:@"session_id"]];
    
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSHTTPURLResponse *response;
    NSError *error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if([response statusCode] == 200)
    {
        NSLog(@"INVENTORY! %@", [NSString stringWithUTF8String:[req bytes]]);
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
