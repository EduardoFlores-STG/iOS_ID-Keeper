//
//  PurchaseOptionsVC.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "PurchaseOptionsVC.h"
#import "MacrosHelper.h"

@implementation PurchaseOptionsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (SKProduct *product in self.arrayOfInAppProducts)
    {
        self.label_purchaseTitle.text = product.localizedTitle;
        self.label_purchaseDescription.text = product.localizedDescription;
    }
}

- (IBAction)button_purchaseTouchID:(id)sender
{
    for (SKProduct *product in self.arrayOfInAppProducts)
    {
        if ([[product productIdentifier]isEqualToString:IN_APP_PURCHASE_IDENTIFIER_TOUCH_ID])
        {
            [self.delegate purchaseItem:product];
            
            // close the uiview that was opened modally
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
@end
