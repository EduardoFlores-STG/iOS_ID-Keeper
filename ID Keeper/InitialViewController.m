//
//  InitialViewController.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "InitialViewController.h"
#import "MacrosHelper.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    defaultQueue = [SKPaymentQueue defaultQueue];
    [defaultQueue addTransactionObserver:self];
    
    // begin check and communication with iTunesConnect for in-app options
    // might want to call it when pushing to the purchasing view instead
    [self checkInAppPurchases];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button_startNewID:(id)sender
{
    [self performSegueWithIdentifier:@"segueStartNewID" sender:nil];
}

- (IBAction)button_showCurrentIDs:(id)sender
{
    if ([defaults boolForKey:KEY_IS_TOUCH_ID_PURCHASED] == YES)
    {
        NSLog(@"touch has been purchased!");
        [self authenticateWithTouchID]; // attempt to authenticate, and trigger seque from challenge
    }
    else    // they haven't purchased the in-app option!
    {
        [self performSegueWithIdentifier:@"segueShowCurrentIDs" sender:nil];
    }
}

- (IBAction)button_purchaseOptions:(id)sender
{
    [self performSegueWithIdentifier:@"seguePurchaseOptions" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"segueStartNewID"])
    {
        
    }
    else if ([[segue identifier]isEqualToString:@"segueShowCurrentIDs"])
    {
        
    }
    else if ([[segue identifier]isEqualToString:@"seguePurchaseOptions"])
    {
        PurchaseOptionsVC *povc = (PurchaseOptionsVC *)[segue destinationViewController];
        
        povc.delegate = self;
        povc.arrayOfInAppProducts = arrayOfInAppProducts;
    }
}

#pragma mark - TouchID methods
- (void) authenticateWithTouchID
{
    LAContext *context = [[LAContext alloc]init];
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        // authenticate user
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"Please authenticate" reply:^(BOOL success, NSError *error)
                {
                    if (error)
                        NSLog(@"Error authenticating with TouchID");
                    if (success)
                    {
                        NSLog(@"Succesfully authenticated with TouchID!");
                        // perform segue in main thread
                        dispatch_async(dispatch_get_main_queue(),
                            ^{
                                [self performSegueWithIdentifier:@"segueShowCurrentIDs" sender:nil];
                            });
                    }
                    else
                        NSLog(@"Something bad happened when attempting to authenticate with TouchID");
                }];
    }
    else
    {
        NSLog(@"cannot authenticate with TouchID");
    }
}

#pragma mark - In-App methods
// *** I KEEP THINKING THIS IS IN THE WRONG CLASS ***
// this begins a check of what products exists in the server
- (void) checkInAppPurchases
{
    if ([SKPaymentQueue canMakePayments])
    {
        // Touch ID in-app purchase
        NSSet *product_touchID = [NSSet setWithObject:IN_APP_PURCHASE_IDENTIFIER_TOUCH_ID];
        SKProductsRequest *request_touchID = [[SKProductsRequest alloc]initWithProductIdentifiers:product_touchID];
        request_touchID.delegate = self;
        [request_touchID start];
    }
    else
    {
        NSLog(@"Can't make payments");
    }
}

// delegate method coming from the "purchase options" view
- (void)purchaseItem:(SKProduct *)productToPurchase
{
    if (productToPurchase)    // make sure product is not null
    {
        SKPayment *payment = [SKPayment paymentWithProduct:productToPurchase];
        [defaultQueue addPayment:payment];
    }
    else
        NSLog(@"product is null!");
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        NSLog(@"description = %@", transaction.description);
        NSLog(@"transactionIdentifier = %@", transaction.transactionIdentifier);
        
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"in SKPaymentTransactionStatePurchased");
                [self checkWhatItemWasPurchased];
                [defaultQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"in SKPaymentTransactionStateFailed");
                [defaultQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"in SKPaymentTransactionStateRestored");
                [self checkWhatItemWasPurchased];
                [defaultQueue restoreCompletedTransactions];
                break;
            default:
                break;
        }
    }
    [defaults synchronize];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    arrayOfInAppProducts = response.products;
    if ([arrayOfInAppProducts count] != 0)
    {
        product = [arrayOfInAppProducts objectAtIndex:0];   // for now...
        NSLog(@"product Title = %@", product.localizedTitle);
        NSLog(@"product Description = %@", product.localizedDescription);
    }
}

- (void) checkWhatItemWasPurchased
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"received restored transactions: %lu", (unsigned long)queue.transactions.count);
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        NSString *productID = transaction.payment.productIdentifier;
        if ([productID isEqualToString:@"com.eduardoflores.IDKeeper.enableTouchID"])
        {
            // verified that the purchase was for the touch ID option
            [defaults setBool:YES forKey:KEY_IS_TOUCH_ID_PURCHASED];
        }
    }
}
@end



















































