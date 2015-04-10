//
//  InitialViewController.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <StoreKit/StoreKit.h>
#import "PurchaseOptionsVC.h"

@interface InitialViewController : UIViewController
{
    NSUserDefaults *defaults;
}

@property (weak, nonatomic) IBOutlet UIButton *buttonOutlet_purchaseOptions;

- (IBAction)button_startNewID:(id)sender;
- (IBAction)button_showCurrentIDs:(id)sender;
- (IBAction)button_purchaseOptions:(id)sender;

@end
