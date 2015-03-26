//
//  InitialViewController.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "InitialViewController.h"
#import "MacrosHelper.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

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
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"in SKPaymentTransactionStatePurchased");
                [defaults setBool:YES forKey:KEY_IS_TOUCH_ID_PURCHASED];
                [defaultQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"in SKPaymentTransactionStateFailed");
                [defaultQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"in SKPaymentTransactionStateRestored");
                [defaults setBool:YES forKey:KEY_IS_TOUCH_ID_PURCHASED];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    defaultQueue = [SKPaymentQueue defaultQueue];
    [defaultQueue addTransactionObserver:self];
    [self checkInAppPurchases];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
}

- (IBAction)button_startNewID:(id)sender
{
    [self performSegueWithIdentifier:@"segueStartNewID" sender:nil];
}

- (IBAction)button_showCurrentIDs:(id)sender
{
    [self performSegueWithIdentifier:@"segueShowCurrentIDs" sender:nil];
    
    if ([defaults boolForKey:KEY_IS_TOUCH_ID_PURCHASED] == YES)
    {
        NSLog(@"touch has been purchased!");
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
@end



















































