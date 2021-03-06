//
//  CardDetailsVC.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/31/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardDetailsVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonOutlet_showBarcode;

- (IBAction)button_showBarcode:(id)sender;

@property (nonatomic, weak) Card *card;

@end
