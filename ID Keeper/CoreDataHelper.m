//
//  CoreDataHelper.m
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper

+ (NSManagedObjectContext *)getManagedObjectContext
{
    return [(AppDelegate *)[[UIApplication sharedApplication]delegate]managedObjectContext];
}

+ (NSError *)saveManagedObjectContext
{
    NSError *error = nil;
    
    if ( ![[self getManagedObjectContext]save:&error])
    {
        // error saving. return error
        return error;
    }
    return nil;
}

+ (NSArray *)fetchForEntityName:(NSString *)entityName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self getManagedObjectContext]];
    [fetchRequest setEntity:entity];

    NSError *error = nil;
    return [[self getManagedObjectContext] executeFetchRequest:fetchRequest error:&error];
}

+ (NSFetchedResultsController *)getFetchedResultsControllerWithEntityName:(NSString *)entityName sortKey:(NSString *)sortKey
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self getManagedObjectContext]];
    [fetchRequest setEntity:entity];
    
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey
    ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];

    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                                              managedObjectContext:[self getManagedObjectContext] sectionNameKeyPath:sortKey cacheName:nil];

    return fetchedResultsController;
}

@end

























