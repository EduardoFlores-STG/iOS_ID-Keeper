//
//  Card.h
//  ID Keeper
//
//  Created by Eduardo Flores on 4/1/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * card_barcode_type;
@property (nonatomic, retain) NSString * card_barcode_value;
@property (nonatomic, retain) NSString * card_id;
@property (nonatomic, retain) NSString * card_image_location;
@property (nonatomic, retain) NSString * card_issuer;
@property (nonatomic, retain) NSString * card_name;
@property (nonatomic, retain) NSString * card_type;

@end
