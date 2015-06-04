//
//  Recommender.h
//  RecSys
//
//  Created by Thomas Günzel on 28/05/15.
//  Copyright (c) 2015 Thomas Günzel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"
#import "Item.h"

@interface Recommender : NSObject
@property(strong) NSMutableSet *items;
@property(strong) NSMutableSet *users;
@property(strong) NSMutableSet *ratings;

-(instancetype)initFromJSON:(NSData*)json;

-(void)calculateSimilarities;

-(User*)userWithName:(NSString*)name;
-(Item*)itemWithName:(NSString*)name;

@end
