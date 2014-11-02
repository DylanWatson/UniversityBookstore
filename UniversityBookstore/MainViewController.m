//
//  MainViewController.m
//  UniversityBookstore
//
//  Created by Keyur Patel on 11/2/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "MainViewController.h"
#import "FAImageView.h"
#import "NSString+FontAwesome.h"
#import "BooksForSaleTableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize buyBook, sellBook, inventory, profile, searchBar;


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    
    searchBar.hidden = YES;
    
    [super viewDidLoad];
    
    buyBook.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:100];
    buyBook.titleLabel.shadowOffset = CGSizeMake(0, -1);
    [buyBook setTitle:[NSString fontAwesomeIconStringForEnum:FABook] forState:UIControlStateNormal];
    [buyBook setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    sellBook.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:100];
    sellBook.titleLabel.shadowOffset = CGSizeMake(0, -1);
    [sellBook setTitle:[NSString fontAwesomeIconStringForEnum:FAUsd] forState:UIControlStateNormal];
    [sellBook setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    inventory.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:100];
    inventory.titleLabel.shadowOffset = CGSizeMake(0, -1);
    [inventory setTitle:[NSString fontAwesomeIconStringForEnum:FAItalic] forState:UIControlStateNormal];
    [inventory setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    profile.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:100];
    profile.titleLabel.shadowOffset = CGSizeMake(0, -1);
    [profile setTitle:[NSString fontAwesomeIconStringForEnum:FAUser] forState:UIControlStateNormal];
    [profile setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated
{
    searchBar.hidden = YES;
    [searchBar resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    searchBar.hidden = YES;
    [searchBar resignFirstResponder];
}

-(IBAction)extendSearch:(id)sender
{
    searchBar.hidden = NO;
    [searchBar becomeFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)sb
{
    [sb resignFirstResponder];
    
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
    if([json count] > 0)
    {
        [self performSegueWithIdentifier:@"searchBooks" sender:json];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Matches Found" message:@"We could not find any items meeting your searched criteria." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *close = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:close];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"searchBooks"]) {
        BooksForSaleTableViewController *destination = [segue destinationViewController];
        destination.booksForSell = [[NSMutableArray alloc] initWithArray:(NSArray*)sender];
    }
}


@end
