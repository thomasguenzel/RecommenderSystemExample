//
//  Similarity.h
//  RecSys
//
//  Created by Thomas Günzel on 28/05/15.
//  Copyright (c) 2015 Thomas Günzel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Item.h"

@interface Similarity : NSObject
@property(readonly) double similarity;
@property(weak) Item *itemA;
@property(weak) Item *itemB;

-(instancetype)initWithSimilarityBetween:(Item*)itemA and:(Item*)itemB;

-(Item*)otherItem:(Item*)sender;

@end
