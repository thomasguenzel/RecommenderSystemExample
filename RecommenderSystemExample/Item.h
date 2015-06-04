//
//  Item.h
//  RecSys
//
//  Created by Thomas Günzel on 28/05/15.
//  Copyright (c) 2015 Thomas Günzel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rating;
@class Similarity;

@interface Item : NSObject
@property(strong) NSString *name;
@property(strong) NSMutableSet *similarities;
@property(strong) NSMutableSet *ratings;


+(Item*)itemWithName:(NSString*)name;
-(instancetype)initWithName:(NSString*)name;

-(void)calculateSimilarities:(NSSet*)otherItems;
-(double)similarityTo:(Item*)item;

-(void)addRating:(Rating*)rating;



@end
