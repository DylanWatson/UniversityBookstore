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

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize buyBook, sellBook, inventory, profile;


- (void)viewDidLoad {
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
