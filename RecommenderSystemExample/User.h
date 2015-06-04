//
//  User.h
//  RecSys
//
//  Created by Thomas Günzel on 28/05/15.
//  Copyright (c) 2015 Thomas Günzel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rating;
@class Item;

@interface User : NSObject
@property(strong) NSString *name;
@property(strong) NSMutableSet *ratings;

-(instancetype)initWithName:(NSString*)name;
+(User*)userWithName:(NSString*)name;

-(void)addRating:(Rating*)rating;
-(double)meanRating;

-(double)predictionForItem:(Item*)item;


@end
