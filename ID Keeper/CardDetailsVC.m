//
//  CardDetailsVC.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/31/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "CardDetailsVC.h"

@interface CardDetailsVC ()

@end

@implementation CardDetailsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:self.card.card_image_location];
    if ( [fileManager fileExistsAtPath:filePath] )
    {
        UIImage *imageRotated = [self rotateUIImage:[UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]] clockwise:YES];
        self.imageView.image = imageRotated;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
