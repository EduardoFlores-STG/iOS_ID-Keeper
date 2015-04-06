//
//  NewCard_StartVC.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "NewCard_StartVC.h"
#import "NewCard_PreviewVC.h"
#import "AlertDialogsHelper.h"

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
    label_cardName.text = NSLocalizedString(@"CARD_NAME", nil);
    label_cardIssuer.text = NSLocalizedString(@"CARD_ISSUER_PROMPT", nil);
    label_cardType.text = NSLocalizedString(@"CARD_TYPE", nil);
}

- (void) setValuesForArrayOfCardTypes
{
    self.arrayOfCardTypes = [NSArray arrayWithObjects:NSLocalizedString(@"FOOD", nil),
                             NSLocalizedString(@"GOVERNMENT", nil),
                             NSLocalizedString(@"GROCERY_STORE", nil),
                             NSLocalizedString(@"GYM", nil),
                             NSLocalizedString(@"MOVIES", nil),
                             NSLocalizedString(@"OTHER", nil),
                             nil];
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
    
    [[self textField_cardIssuer]resignFirstResponder];
    [[self textField_cardName]resignFirstResponder];
}

- (BOOL) isAllTextFieldsEntered
{
    if ([self.textField_cardName.text isEqualToString:@""] || [self.textField_cardIssuer.text isEqualToString:@""])
        return NO;
    else
        return YES;
}

- (IBAction)button_takePicture:(id)sender
{
    if ([self isAllTextFieldsEntered])
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
            [AlertDialogsHelper showAlertDialogWithTitle:NSLocalizedString(@"NO_CAMERA", nil)
                                                 message:NSLocalizedString(@"NO_CAMERA_MESSAGE", nil)
                                            buttonCancel:NSLocalizedString(@"OK", nil)
                                                buttonOK:nil];        }
    }
    else
    {
        [AlertDialogsHelper showAlertDialogWithTitle:NSLocalizedString(@"MISSING_FIELDS", nil)
                                             message:NSLocalizedString(@"ENTER_CARD_NAME_CARD_ISSUER", nil)
                                        buttonCancel:NSLocalizedString(@"OK", nil)
                                            buttonOK:nil];
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













































