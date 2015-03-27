//
//  NewCard_StartVC.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "NewCard_StartVC.h"
#import "NewCard_PreviewVC.h"

@implementation NewCard_StartVC
@synthesize label_cardIssuer, label_cardName, label_cardType;
@synthesize textField_cardIssuer, textField_cardName, picker_cardType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setValuesForUILabels];
    [self setValuesForArrayOfCardTypes];
    
    imagePicker = [[UIImagePickerController alloc]init];
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
    self.pickerItemSelected = [[self arrayOfCardTypes]objectAtIndex:row];
}

- (IBAction)button_takePicture:(id)sender
{
    // check if device has a camera
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES )
    {
        // make this class as the delegate
        imagePicker.delegate = self;
        
        // set the source to be the camera
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // limit this to only pictures, no video
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        
        // show the imagepicker
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        NSLog(@"This device does not have a camera!");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // dismiss pickerview
    [self dismissViewControllerAnimated:YES completion:
     ^{
         // push segue to new view
         [self performSegueWithIdentifier:@"segueNewCardPreview" sender:image];

    }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"segueNewCardPreview"])
    {
        UIImage *imageTaken = (UIImage *)sender;
        NewCard_PreviewVC *ncpvc = (NewCard_PreviewVC *)[segue destinationViewController];
        ncpvc.imageTaken = imageTaken;
        ncpvc.card_name = textField_cardName.text;
        ncpvc.card_issuer = textField_cardIssuer.text;
        
        if ( !self.pickerItemSelected)
            ncpvc.card_type = [[self arrayOfCardTypes]objectAtIndex:0];
        else
            ncpvc.card_type = self.pickerItemSelected;
    }
}
@end













































