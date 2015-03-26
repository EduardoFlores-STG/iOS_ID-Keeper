//
//  CoreDataHelper.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/26/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

+ (NSManagedObjectContext *)getManagedObjectContext;
+ (NSError *) saveManagedObjectContext;
+ (NSArray *) fetchForEntityName:(NSString *)entityName;

@end
