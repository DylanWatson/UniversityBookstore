//
//  BooksDetailViewController.m
//  UniversityBookstore
//
//  Created by Keyur Patel on 11/1/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "BooksDetailViewController.h"

@interface BooksDetailViewController ()

@end

@implementation BooksDetailViewController
@synthesize imageView = _imageView, book_title = _book_title, price = _price, description = _description, category = _category, isbn = _isbn;
@synthesize dictionary = _dictionary;

- (void)viewDidLoad {
    _book_title.text = [_dictionary objectForKey:@"title"];
    _price.text = [_dictionary objectForKey:@"price"];
    _description.text = [_dictionary objectForKey:@"description"];
    _category.text = [_dictionary objectForKey:@"category"];
    _isbn.text = [_dictionary objectForKey:@"isbn"];
    
    NSURL *url = [NSURL URLWithString:[_dictionary objectForKey:@"image"]];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *ret = [UIImage imageWithData:imageData];
    
    if(ret != nil)
    {
        _imageView = [[UIImageView alloc] initWithImage:ret];
    }
    else
    {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    
    [super viewDidLoad];
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
