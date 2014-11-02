//
//  InventoryTableViewController.m
//  UniversityBookstore
//
//  Created by Keyur Patel on 11/2/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "InventoryTableViewController.h"
#import "BooksDetailViewController.h"

@interface InventoryTableViewController ()
@property(nonatomic, strong) NSMutableArray *items;
@end

@implementation InventoryTableViewController
@synthesize items;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL *url = [NSURL URLWithString:@"http://10.160.4.209:3000/inventory"];
    NSData *responseData = [NSMutableData data];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *bodydata = [NSString stringWithFormat:@"email=%@&password=%@&session_id=%@", [defaults objectForKey:@"email"], [defaults objectForKey:@"password"], [defaults objectForKey:@"session_id"]];
    
    [request setHTTPMethod:@"POST"];
    NSData *req=[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]];
    [request setHTTPBody:req];
    NSHTTPURLResponse *response;
    NSError *error = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    if([result containsString:@"200"] && [json count] > 0)
    {
        items = [[NSMutableArray alloc] initWithArray:json];
    }
    else
    {
        NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"No items available in inventory", @"title", nil];
        items = [[NSMutableArray alloc] initWithObjects:dictionary, nil];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDictionary *tempDictionary = [self.items objectAtIndex:indexPath.row];
    
    NSLog(@"%@", [tempDictionary objectForKey:@"title"]);
    
    cell.textLabel.text = [tempDictionary objectForKey:@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Price: %@", [tempDictionary objectForKey:@"prize"]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"bookDetails" sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"bookDetails"]) {
        BooksDetailViewController *destination = [segue destinationViewController];
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        
        NSDictionary *dictionary = [items objectAtIndex:indexPath.row];
        destination.dictionary = dictionary;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
