//
//  PurchaseOptionsVC.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@protocol PurchaseOptionsDelegate

- (void) purchaseItem:(SKProduct *)product;

@end

@interface PurchaseOptionsVC : UIViewController

@property (nonatomic, weak) NSArray *arrayOfInAppProducts;
@property (nonatomic, weak) id<PurchaseOptionsDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *label_purchaseDescription;
@property (weak, nonatomic) IBOutlet UILabel *label_purchaseTitle;

- (IBAction)button_purchaseTouchID:(id)sender;

@end
