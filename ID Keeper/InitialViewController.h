//
//  InitialViewController.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface InitialViewController : UIViewController <SKPaymentTransactionObserver, SKProductsRequestDelegate>
{
    SKPaymentQueue *defaultQueue;
    SKProduct *product;
    BOOL IS_TOUCH_ID_PURCHASED;
}

- (IBAction)button_startNewID:(id)sender;
- (IBAction)button_showCurrentIDs:(id)sender;
- (IBAction)button_purchaseOptions:(id)sender;

@end
