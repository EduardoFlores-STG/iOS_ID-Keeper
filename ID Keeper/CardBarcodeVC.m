//
//  CardBarcodeVC.m
//  ID Keeper
//
//  Created by Eduardo Flores on 4/1/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "CardBarcodeVC.h"
#import "NKDBarcodeFramework.h"

@interface CardBarcodeVC ()

@end

@implementation CardBarcodeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    id barcode = [self getBarcodeOfSpecificType:self.card.card_barcode_type];
    [barcode calculateWidth];
    
    UIImage *imageOfGeneratedBarcode = [UIImage imageFromBarcode:barcode];
    self.imageView.image = [self rotateUIImage:imageOfGeneratedBarcode clockwise:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id) getBarcodeOfSpecificType:(NSString *)type;
{
    
    if ([type isEqualToString:AVMetadataObjectTypeUPCECode])
    {
        return [[NKDUPCEBarcode alloc]initWithContent:type printsCaption:NO];
    }
    else if ([type isEqualToString:AVMetadataObjectTypeCode39Code])
    {
        return [[NKDCode39Barcode alloc]initWithContent:type printsCaption:NO];
    }
    else if ([type isEqualToString:AVMetadataObjectTypeCode39Mod43Code])
    {
        return [[NKDExtendedCode39Barcode alloc]initWithContent:type printsCaption:NO];
    }
    else if ([type isEqualToString:AVMetadataObjectTypeEAN13Code])
    {
        return [[NKDEAN13Barcode alloc]initWithContent:type printsCaption:NO];
    }
    else if ([type isEqualToString:AVMetadataObjectTypeEAN8Code])
    {
        return [[NKDEAN8Barcode alloc]initWithContent:type printsCaption:NO];
    }
    else if ([type isEqualToString:AVMetadataObjectTypeCode128Code])
    {
        return [[NKDCode128Barcode alloc]initWithContent:type printsCaption:NO];
    }
    else
        return nil; // not doing QR, PDF or other ones
}

- (UIImage*)rotateUIImage:(UIImage*)sourceImage clockwise:(BOOL)clockwise
{
    CGSize size = sourceImage.size;
    UIGraphicsBeginImageContext(CGSizeMake(size.height, size.width));
    [[UIImage imageWithCGImage:[sourceImage CGImage] scale:1.0 orientation:clockwise ? UIImageOrientationRight : UIImageOrientationLeft] drawInRect:CGRectMake(0,0,size.height ,size.width)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end














































