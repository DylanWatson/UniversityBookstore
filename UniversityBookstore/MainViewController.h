//
//  MainViewController.h
//  UniversityBookstore
//
//  Created by Keyur Patel on 11/2/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UISearchBarDelegate>
@property(nonatomic,strong) IBOutlet UIButton *buyBook;
@property(nonatomic,strong) IBOutlet UIButton *sellBook;
@property(nonatomic,strong) IBOutlet UIButton *inventory;
@property(nonatomic,strong) IBOutlet UIButton *profile;
@property(nonatomic,strong) IBOutlet UISearchBar *searchBar;
- (IBAction)extendSearch:(id)sender;
@end
