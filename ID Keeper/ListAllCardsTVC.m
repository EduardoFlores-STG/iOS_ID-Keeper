//
//  ListAllCardsTVC.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/30/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "ListAllCardsTVC.h"
#import "CoreDataHelper.h"
#import "Card.h"
#import "CardListCell.h"
#import "CardDetailsVC.h"
#import "AlertDialogsHelper.h"

@interface ListAllCardsTVC ()

@end

@implementation ListAllCardsTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fetchedResultsController = [CoreDataHelper getFetchedResultsControllerWithEntityName:@"Card" sortKey:@"card_type"];
    
    NSError *error = nil;
    if ( ![self.fetchedResultsController performFetch:&error])
    {
        [AlertDialogsHelper showAlertDialogWithTitle:nil
                                             message:NSLocalizedString(@"ERROR_FETCH", nil)
                                        buttonCancel:NSLocalizedString(@"OK", nil)
                                            buttonOK:nil];
    }
    
    NSUInteger numberOfSections = [[[self fetchedResultsController]sections]count];
    if (numberOfSections == 0)
    {
        // there are no cards in the DB yet
        [AlertDialogsHelper showAlertDialogWithTitle:NSLocalizedString(@"NO_CARDS", nil)
                                             message:NSLocalizedString(@"NO_CARDS_EXPLANATION", nil)
                                        buttonCancel:NSLocalizedString(@"OK", nil)
                                            buttonOK:nil];
        // return to previous view
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    fileManager = [NSFileManager defaultManager];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSUInteger numberOfSections = [[[self fetchedResultsController]sections]count];
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> secInfo = [[[self fetchedResultsController]sections]objectAtIndex:section];
    NSUInteger numberOfRows = [secInfo numberOfObjects];
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellExistingCard" forIndexPath:indexPath];
    
    // Configure the cell...
    Card *card = [[self fetchedResultsController]objectAtIndexPath:indexPath];
    cell.label_cardName.text = card.card_name;
    cell.label_cardIssuer.text = card.card_issuer;
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:card.card_image_location];
    if ( [fileManager fileExistsAtPath:filePath] )
    {
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Card *card = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    return card.card_type;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // there's currently only 1 segue from here
    CardDetailsVC *cdvc = [segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Card *card = [[self fetchedResultsController]objectAtIndexPath:indexPath];
    cdvc.navigationItem.title = card.card_name;
    cdvc.card = card;
}

@end



















































