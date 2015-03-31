//
//  ListAllCardsTVC.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/30/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ListAllCardsTVC : UITableViewController
{
    NSFileManager *fileManager;
}

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
