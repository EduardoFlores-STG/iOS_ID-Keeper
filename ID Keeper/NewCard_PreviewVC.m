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
    // Save image file locally and get the URL of where the file image gets saved
    NSString *filePath = [self saveFileToLocalFilePath];
    
    // Create a new core data card
    [self generateNewCoreDataCardWithFilePath:filePath];
    
    // save core data managedObjectContext
    [CoreDataHelper saveManagedObjectContext];
    
    // display success dialog
    // return to InitialViewController
}
@end
















































