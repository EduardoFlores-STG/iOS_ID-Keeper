//
//  NewCard_PreviewVC.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "NewCard_PreviewVC.h"
#import "CoreDataHelper.h"
#import "Card.h"
#import "ProgressDialogsHelper.h"

@implementation NewCard_PreviewVC
@synthesize imageTaken, imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageView.image = imageTaken;
    self.label_cardName.text = self.card_name;
    self.label_cardIssuer.text = self.card_issuer;
    self.label_barcodeValue.text = @""; // start it empty
    
    if (true)   // need to check for barcode in-app purchase. Ignore for now and assume it has been purchased
        [self displayPromptToUseBarcodeScanner];
}

- (void) displayPromptToUseBarcodeScanner
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Barcode Scanner"
                                                   message:@"Do you want to scan the barcode of this card?"
                                                  delegate:self
                                         cancelButtonTitle:@"No"
                                         otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 0 = No
    // 1 = Yes
    if (buttonIndex == 1)
    {
        // scan for barcode
        [self scanBarcode];
    }
}

#pragma mark - Barcode Methods
- (void) scanBarcode
{
    session = [[AVCaptureSession alloc] init];
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (input)
    {
        [session addInput:input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    
    output.metadataObjectTypes = [output availableMetadataObjectTypes];
    
    prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    prevLayer.frame = self.view.bounds;
    prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:prevLayer];
    
    [session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects)
    {
        for (NSString *type in barCodeTypes)
        {
            if ([metadata.type isEqualToString:type])
            {
                barcode_type = type;
                
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        if (detectionString != nil)
        {
            barcode_value = detectionString;
            self.label_barcodeValue.text = barcode_value;
            [session stopRunning];
            
            // remove video layer
            NSMutableArray *subLayers = [NSMutableArray arrayWithArray:[self.view.layer sublayers]];
            for (id eachLayer in subLayers)
            {
                if ([eachLayer isKindOfClass:[AVCaptureVideoPreviewLayer class]])
                    [subLayers removeObject:eachLayer];
            }
            self.view.layer.sublayers = subLayers;
            break;
        }
        else
            NSLog(@"no text read!");
    }
}

#pragma mark - Save method
- (NSString *) saveFileToLocalFilePath
{
    card_FileName = [NSString stringWithFormat:@"%@_%@_%@.png",
                     self.card_name,
                     self.card_issuer,
                     [NSDate date]];
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    path = [path stringByAppendingString:@"/"];
    path = [path stringByAppendingString:card_FileName];
    
    [UIImagePNGRepresentation(imageTaken) writeToFile:path atomically:YES];
    
    return path;
}

#pragma mark - Core data methods
- (void) generateNewCoreDataCardWithFilePath:(NSString *)filePath
{
    Card *card = (Card *) [NSEntityDescription insertNewObjectForEntityForName:@"Card"
                                                        inManagedObjectContext:[CoreDataHelper getManagedObjectContext]];
    card.card_name = self.card_name;
    card.card_issuer = self.card_issuer;
    card.card_type = self.card_type;
    card.card_image_location = card_FileName;
    card.card_barcode_type = barcode_type;
    card.card_barcode_value = barcode_value;
}

- (IBAction)button_saveCard:(id)sender
{
    // display "waiting" Progress dialog
    [ProgressDialogsHelper showIndeterminateDialogForView:self.view withText:@"Saving card..."];
    
    //dispatch_queue_t saveQueue = dispatch_queue_create("SaveQueue", NULL);
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0),
        ^{
            // Save image file locally and get the URL of where the file image gets saved
            NSString *filePath = [self saveFileToLocalFilePath];
            
            // Create a new core data card
            [self generateNewCoreDataCardWithFilePath:filePath];
            
            // save core data managedObjectContext
            [CoreDataHelper saveManagedObjectContext];
            
            dispatch_async(dispatch_get_main_queue(),
                ^{
                    [ProgressDialogsHelper removeAllProgressDialogsForView:self.view];
                    
                    // display success dialog
                    [self displaySuccessDialog];
                    // remove all progress dialogs
                    // return to InitialViewController
                });
        });
}

#pragma mark - Success methods
- (void) displaySuccessDialog
{
    float amountOfSecondsDisplayingSuccessDialog = 3.0f;
    
    [ProgressDialogsHelper showSuccessDialogForView:self.view withText:@"Card Saved!"];
    
    // keep the view active for x amount of seconds
    [self performSelector:@selector(returnToInitialView)
               withObject:nil
               afterDelay:amountOfSecondsDisplayingSuccessDialog];
}

- (void) returnToInitialView
{
    [ProgressDialogsHelper removeAllProgressDialogsForView:self.view];
    [self performSegueWithIdentifier:@"segueUnwindToInitialViewController" sender:nil];

}
@end
















































