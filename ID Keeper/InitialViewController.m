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

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                IS_TOUCH_ID_PURCHASED = YES;
                [defaultQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [defaultQueue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [defaultQueue restoreCompletedTransactions];
                break;
            default:
                break;
        }
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    if ([products count] != 0)
    {
        product = [products objectAtIndex:0];   // for now...
        NSLog(@"product Title = %@", product.localizedTitle);
        NSLog(@"product Description = %@", product.localizedDescription);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
}

- (IBAction)button_purchaseOptions:(id)sender
{
    [self performSegueWithIdentifier:@"seguePurchaseOptions" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}
@end
