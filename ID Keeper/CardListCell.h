//
//  CardListCell.h
//  ID Keeper
//
//  Created by Eduardo Flores on 3/31/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label_cardName;
@property (weak, nonatomic) IBOutlet UILabel *label_cardIssuer;
@end
