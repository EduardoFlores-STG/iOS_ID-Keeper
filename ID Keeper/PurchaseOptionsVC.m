//
//  PurchaseOptionsVC.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "PurchaseOptionsVC.h"
#import "MacrosHelper.h"
#import "ProgressDialogsHelper.h"

@implementation PurchaseOptionsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [ProgressDialogsHelper showIndeterminateDialogForView:self.view withText:@"Downloading data..."];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    defaultQueue = [SKPaymentQueue defaultQueue];
    [defaultQueue addTransactionObserver:self];
    
    // begin check and communication with iTunesConnect for in-app options
    // might want to call it when pushing to the purchasing view instead
    [self checkInAppPurchases];
}

- (IBAction)button_purchaseTouchID:(id)sender
{
    for (SKProduct *product in arrayOfInAppProducts)
    {
        if ([[product productIdentifier]isEqualToString:IN_APP_PURCHASE_IDENTIFIER_TOUCH_ID])
        {
            // close the uiview that was opened modally
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void) setValuesForLabels
{
    for (SKProduct *product in arrayOfInAppProducts)
    {
        self.label_purchaseTitle.text = product.localizedTitle;
        self.label_purchaseDescription.text = product.localizedDescription;
    }
}

#pragma mark - In-App methods
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
        inAppProduct = [arrayOfInAppProducts objectAtIndex:0];   // for now...
        NSLog(@"product Title = %@", inAppProduct.localizedTitle);
        NSLog(@"product Description = %@", inAppProduct.localizedDescription);
    }
    [self setValuesForLabels];
    [ProgressDialogsHelper removeAllProgressDialogsForView:self.view];
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


















































