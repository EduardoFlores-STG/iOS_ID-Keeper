//
//  ProgressDialogsHelper.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/30/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface ProgressDialogsHelper : NSObject

+ (void) removeAllProgressDialogsForView:(UIView *)view;
+ (void) showIndeterminateDialogForView:(UIView *)view withText:(NSString *)text;
+ (void) showSuccessDialogForView:(UIView *)view withText:(NSString *)text;

@end
