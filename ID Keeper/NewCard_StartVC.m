//
//  NewCard_StartVC.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "NewCard_StartVC.h"

@implementation NewCard_StartVC
@synthesize label_cardIssuer, label_cardName, label_cardType;
@synthesize textField_cardIssuer, textField_cardName, picker_cardType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setValuesForUILabels];
    [self setValuesForArrayOfCardTypes];
}

- (void) setValuesForUILabels
{
    label_cardName.text = @"Card Name";
    label_cardIssuer.text = @"Who issued this card?";
    label_cardType.text = @"Card Type";
}

- (void) setValuesForArrayOfCardTypes
{
    self.arrayOfCardTypes = [NSArray arrayWithObjects:@"Government", @"Gym", @"Grocery Store", @"Movies", @"Other", nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arrayOfCardTypes.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self arrayOfCardTypes]objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"Selected = %@", [[self arrayOfCardTypes]objectAtIndex:row]);
}

- (IBAction)button_takePicture:(id)sender
{
}
@end













































