//
//  PurchaseOptionsVC.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface PurchaseOptionsVC : UIViewController <SKPaymentTransactionObserver, SKProductsRequestDelegate>
{
    NSUserDefaults *defaults;
    
    SKPaymentQueue *defaultQueue;
    SKProduct *inAppProduct;
    BOOL IS_TOUCH_ID_PURCHASED;
    NSArray *arrayOfInAppProducts;
}

@property (weak, nonatomic) IBOutlet UILabel *label_purchaseDescription;
@property (weak, nonatomic) IBOutlet UILabel *label_purchaseTitle;

- (IBAction)button_purchaseTouchID:(id)sender;

@end
