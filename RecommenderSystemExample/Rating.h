//
//  Rating.h
//  RecSys
//
//  Created by Thomas Günzel on 28/05/15.
//  Copyright (c) 2015 Thomas Günzel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Item.h"
#import "User.h"

@interface Rating : NSObject
@property() double rating;
@property(weak) Item *item;
@property(weak) User *user;

-(instancetype)initWithRating:(double)rating user:(User*)user item:(Item*)item;

+(Rating*)ratingWithRating:(double)rating fromUser:(User*)user onItem:(Item*)item;

@end
