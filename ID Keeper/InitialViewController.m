//
//  InitialViewController.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "InitialViewController.h"
#import "MacrosHelper.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "AlertDialogsHelper.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    defaults = [NSUserDefaults standardUserDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToInitialViewController:(UIStoryboardSegue *)sender
{
    
}

- (IBAction)button_startNewID:(id)sender
{
    [self performSegueWithIdentifier:@"segueStartNewID" sender:nil];
}

- (IBAction)button_showCurrentIDs:(id)sender
{
    if ([defaults boolForKey:KEY_IS_TOUCH_ID_PURCHASED] == YES)
    {
        NSLog(@"touch has been purchased!");
        [self authenticateWithTouchID]; // attempt to authenticate, and trigger seque from challenge
    }
    else    // they haven't purchased the in-app option!
    {
        [self performSegueWithIdentifier:@"segueShowCurrentIDs" sender:nil];
    }
}

- (IBAction)button_purchaseOptions:(id)sender
{
    [self performSegueWithIdentifier:@"seguePurchaseOptions" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"segueStartNewID"])
    {
        
    }
    else if ([[segue identifier]isEqualToString:@"segueShowCurrentIDs"])
    {
        
    }
    else if ([[segue identifier]isEqualToString:@"seguePurchaseOptions"])
    {
        
    }
}

#pragma mark - TouchID methods
- (void) authenticateWithTouchID
{
    LAContext *context = [[LAContext alloc]init];
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        // authenticate user
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:NSLocalizedString(@"PLEASE_AUTHENTICATE", nil)
                          reply:^(BOOL success, NSError *error)
                {
                    if (error)
                    {
                        [AlertDialogsHelper showAlertDialogWithTitle:NSLocalizedString(@"ERROR_AUTHENTICATION", nil)
                                                             message:NSLocalizedString(@"ERROR_AUTHENTICATING_TOUCHID", nil)
                                                        buttonCancel:NSLocalizedString(@"CANCEL", nil)
                                                            buttonOK:NSLocalizedString(@"TRY_AGAIN", nil)];
                    }
                    if (success)
                    {
                        // perform segue in main thread
                        dispatch_async(dispatch_get_main_queue(),
                            ^{
                                [self performSegueWithIdentifier:@"segueShowCurrentIDs" sender:nil];
                            });
                    }
                }];
    }
    else
    {
        NSLog(@"cannot authenticate with TouchID");
    }
}
@end



















































