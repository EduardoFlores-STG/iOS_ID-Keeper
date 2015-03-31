//
//  NewCard_PreviewVC.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NewCard_PreviewVC : UIViewController
{
    MBProgressHUD *hud;
    NSString *card_FileName;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label_cardName;
@property (weak, nonatomic) IBOutlet UILabel *label_cardIssuer;

- (IBAction)button_saveCard:(id)sender;

@property (nonatomic, retain) UIImage *imageTaken;
@property (nonatomic, copy) NSString *card_name;
@property (nonatomic, copy) NSString *card_issuer;
@property (nonatomic, copy) NSString *card_type;

@end
