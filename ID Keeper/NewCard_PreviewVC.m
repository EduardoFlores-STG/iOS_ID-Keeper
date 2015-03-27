//
//  NewCard_PreviewVC.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "NewCard_PreviewVC.h"

@implementation NewCard_PreviewVC
@synthesize imageTaken, imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageView.image = imageTaken;
}

@end
