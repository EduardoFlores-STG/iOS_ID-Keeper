//
//  NewCard_StartVC.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCard_StartVC : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>


@property (weak, nonatomic) IBOutlet UILabel *label_cardName;
@property (weak, nonatomic) IBOutlet UILabel *label_cardIssuer;
@property (weak, nonatomic) IBOutlet UILabel *label_cardType;

@property (weak, nonatomic) IBOutlet UITextField *textField_cardName;
@property (weak, nonatomic) IBOutlet UITextField *textField_cardIssuer;

@property (weak, nonatomic) IBOutlet UIPickerView *picker_cardType;

@property (strong, nonatomic) NSArray *arrayOfCardTypes;

@end
