//
//  CardBarcodeVC.h
//  ID Keeper
//
//  Created by Eduardo Flores on 4/1/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Card.h"

@interface CardBarcodeVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, weak) Card *card;
@property (nonatomic, copy) NSString *barcodeType;
@property (nonatomic, copy) NSString *barcodeValue;

@end
