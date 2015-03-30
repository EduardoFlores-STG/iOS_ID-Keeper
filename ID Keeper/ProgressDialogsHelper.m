//
//  ProgressDialogsHelper.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/30/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "ProgressDialogsHelper.h"

@implementation ProgressDialogsHelper

+ (void)removeAllProgressDialogsForView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

+ (void)showIndeterminateDialogForView:(UIView *)view withText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
}

+ (void)showSuccessDialogForView:(UIView *)view withText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark.png"]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
}

@end
