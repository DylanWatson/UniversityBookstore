//
//  PaymentViewController.m
//  UniversityBookstore
//
//  Created by Dylan Watson on 11/2/14.
//  Copyright (c) 2014 Keyur Patel. All rights reserved.
//

#import "Stripe.h"
#import "MBProgressHUD.h"
#import "PaymentViewController.h"
#import "PTKView.h"
#import <Parse/Parse.h>
#import "Constants.h"

@interface PaymentViewController ()<PTKViewDelegate>
@property(weak, nonatomic) PTKView *paymentView;
@end


@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Checkout";
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // Setup save button
    NSString *title = [NSString stringWithFormat:@"Pay"];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    saveButton.enabled = NO;
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // Setup checkout
    PTKView *paymentView = [[PTKView alloc] initWithFrame:CGRectMake(15, 20, 290, 55)];
    paymentView.delegate = self;
    self.paymentView = paymentView;
    [self.view addSubview:paymentView];
}

- (void)paymentView:(PTKView *)paymentView withCard:(PTKCard *)card isValid:(BOOL)valid {
    // Enable save button if the Checkout is valid
    self.navigationItem.rightBarButtonItem.enabled = valid;
}

- (void)cancel:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    if (![self.paymentView isValid]) {
        return;
    }
    if (![Stripe defaultPublishableKey]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Publishable Key"
                                                          message:@"Please specify a Stripe Publishable Key in Constants.m"
                                                         delegate:nil
                                                cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                                otherButtonTitles:nil];
        [message show];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    STPCard *card = [[STPCard alloc] init];
    card.number = self.paymentView.card.number;
    card.expMonth = self.paymentView.card.expMonth;
    card.expYear = self.paymentView.card.expYear;
    card.cvc = self.paymentView.card.cvc;
    [Stripe createTokenWithCard:card
                     completion:^(STPToken *token, NSError *error) {
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         if (error) {
                             [self hasError:error];
                         } else {
                             [self hasToken:token];
                         }
                     }];
}

- (void)hasError:(NSError *)error {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                      message:[error localizedDescription]
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                            otherButtonTitles:nil];
    [message show];
}

- (void)hasToken:(STPToken *)token {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *chargeParams = @{
                                   @"token": token.tokenId,
                                   @"currency": @"usd",
                                   @"amount": @"1000", // this is in cents (i.e. $10)
                                   };
    
    if (!ParseApplicationId || !ParseClientKey) {
        UIAlertView *message =
        [[UIAlertView alloc] initWithTitle:@"Congratulations on your purchase!  Here is the buyer's contract information: \n"
                                   message:[NSString stringWithFormat:@"Name: Keyur Patel \nPhone Number: 304-849-4423 \nEmail: patel48@marshall.edu"]
                                            // for another daytoken.tokenId]
                                  delegate:nil
                         cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                         otherButtonTitles:nil];
        
        [message show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    // This passes the token off to our payment backend, which will then actually complete charging the card using your account's
    [PFCloud callFunctionInBackground:@"charge"
                       withParameters:chargeParams
                                block:^(id object, NSError *error) {
                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                    if (error) {
                                        [self hasError:error];
                                        return;
                                    }
                                    [self.presentingViewController dismissViewControllerAnimated:YES
                                                                                      completion:^{
                                                                                          [[[UIAlertView alloc] initWithTitle:@"Payment Succeeded"
                                                                                                                      message:nil
                                                                                                                     delegate:nil
                                                                                                            cancelButtonTitle:nil
                                                                                                            otherButtonTitles:@"OK", nil] show];
                                                                                      }];
                                }];
}

@end
