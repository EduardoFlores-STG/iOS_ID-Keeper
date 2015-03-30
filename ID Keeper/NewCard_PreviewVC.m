//
//  NewCard_PreviewVC.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "NewCard_PreviewVC.h"
#import "CoreDataHelper.h"
#import "Card.h"
#import "ProgressDialogsHelper.h"

@implementation NewCard_PreviewVC
@synthesize imageTaken, imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageView.image = imageTaken;
    self.label_cardName.text = self.card_name;
    self.label_cardIssuer.text = self.card_issuer;
}

- (NSString *) saveFileToLocalFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0]stringByAppendingString:
                          [NSString stringWithFormat:@"%@_%@.png",
                           self.card_name,
                           self.card_issuer]];
    
    [UIImagePNGRepresentation(imageTaken) writeToFile:filePath atomically:YES];
    
    return filePath;
}

- (void) generateNewCoreDataCardWithFilePath:(NSString *)filePath
{
    Card *card = (Card *) [NSEntityDescription insertNewObjectForEntityForName:@"Card"
                                                        inManagedObjectContext:[CoreDataHelper getManagedObjectContext]];
    card.card_name = self.card_name;
    card.card_issuer = self.card_issuer;
    card.card_type = self.card_type;
    card.card_image_location = filePath;
}

- (IBAction)button_saveCard:(id)sender
{
    // display "waiting" Progress dialog
    [ProgressDialogsHelper showIndeterminateDialogForView:self.view withText:@"Saving card..."];
    
    //dispatch_queue_t saveQueue = dispatch_queue_create("SaveQueue", NULL);
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0),
        ^{
            // Save image file locally and get the URL of where the file image gets saved
            NSString *filePath = [self saveFileToLocalFilePath];
            
            // Create a new core data card
            [self generateNewCoreDataCardWithFilePath:filePath];
            
            // save core data managedObjectContext
            [CoreDataHelper saveManagedObjectContext];
            
            dispatch_async(dispatch_get_main_queue(),
                ^{
                    [ProgressDialogsHelper removeAllProgressDialogsForView:self.view];
                    
                    // display success dialog
                    [self displaySuccessDialog];
                    // remove all progress dialogs
                    // return to InitialViewController
                });
        });
}

- (void) displaySuccessDialog
{
    float amountOfSecondsDisplayingSuccessDialog = 3.0f;
    
    [ProgressDialogsHelper showSuccessDialogForView:self.view withText:@"Card Saved!"];
    
    // keep the view active for x amount of seconds
    [self performSelector:@selector(returnToInitialView)
               withObject:nil
               afterDelay:amountOfSecondsDisplayingSuccessDialog];
}

- (void) removeAllProgressDialogs
{
    [ProgressDialogsHelper removeAllProgressDialogsForView:self.view];
}

- (void) returnToInitialView
{
    [ProgressDialogsHelper removeAllProgressDialogsForView:self.view];
}
@end
















































