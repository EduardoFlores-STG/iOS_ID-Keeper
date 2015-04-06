//
//  AlertDialogsHelper.h
//  ID Keeper
//
//  Created by Eduardo Flores on 4/6/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertDialogsHelper : NSObject

+ (void)showAlertDialogWithTitle:(NSString *)title
                         message:(NSString *)message
                    buttonCancel:(NSString *)buttonCancel
                        buttonOK:(NSString *)buttonOK;

@end
