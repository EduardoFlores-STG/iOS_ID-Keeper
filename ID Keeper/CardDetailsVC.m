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
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
        //self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
