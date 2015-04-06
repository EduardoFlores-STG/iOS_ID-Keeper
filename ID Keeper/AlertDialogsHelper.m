//
//  AlertDialogsHelper.m
//  ID Keeper
//
//  Created by Eduardo Flores on 4/6/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "AlertDialogsHelper.h"

@implementation AlertDialogsHelper

+ (void)showAlertDialogWithTitle:(NSString *)title message:(NSString *)message buttonCancel:(NSString *)buttonCancel buttonOK:(NSString *)buttonOK
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:buttonCancel
                                         otherButtonTitles:buttonOK, nil];
    [alert show];
}
@end
