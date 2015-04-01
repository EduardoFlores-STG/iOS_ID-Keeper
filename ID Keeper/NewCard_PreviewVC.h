//
//  NewCard_PreviewVC.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"

@interface NewCard_PreviewVC : UIViewController <UIAlertViewDelegate, AVCaptureMetadataOutputObjectsDelegate>
{
    MBProgressHUD *hud;
    NSString *card_FileName;
    
    // barcode variables
    AVCaptureSession *session;
    AVCaptureDevice *device;
    AVCaptureDeviceInput *input;
    AVCaptureMetadataOutput *output;
    AVCaptureVideoPreviewLayer *prevLayer;
    NSString *barcode_type;
    NSString *barcode_value;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label_cardName;
@property (weak, nonatomic) IBOutlet UILabel *label_cardIssuer;
@property (weak, nonatomic) IBOutlet UILabel *label_barcodeValue;

- (IBAction)button_saveCard:(id)sender;

@property (nonatomic, retain) UIImage *imageTaken;
@property (nonatomic, copy) NSString *card_name;
@property (nonatomic, copy) NSString *card_issuer;
@property (nonatomic, copy) NSString *card_type;

@end
