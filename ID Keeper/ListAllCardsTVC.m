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
        NSLog(@"Cannot fetch fetchedResultsController. Error = %@", error);
    }
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellExistingCard" forIndexPath:indexPath];
    
    // Configure the cell...
    Card *card = [[self fetchedResultsController]objectAtIndexPath:indexPath];
    cell.textLabel.text = card.card_name;
    
    return cell;
}

// FIX THIS ISSUE LATER
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    Card *card = [[self.fetchedResultsController sections]objectAtIndex:section];
//    NSString *header = card.card_name;
//    return header;
//}

@end



















































