//
//  BooksDetailViewController.h
//  UniversityBookstore
//
//  Created by Keyur Patel on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksDetailViewController : UIViewController
@property(nonatomic, strong) IBOutlet UIImageView *imageView;
@property(nonatomic, strong) IBOutlet UILabel *book_title;
@property(nonatomic, strong) IBOutlet UITextView *description;
@property(nonatomic, strong) IBOutlet UILabel *price;
@property(nonatomic, strong) IBOutlet UILabel *category;
@property(nonatomic, strong) IBOutlet UILabel *isbn;
@property(nonatomic, strong) NSDictionary *dictionary;
@end
