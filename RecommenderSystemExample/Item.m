//
//  Item.m
//  RecSys
//
//  Created by Thomas Günzel on 28/05/15.
//  Copyright (c) 2015 Thomas Günzel. All rights reserved.
//

#import "Item.h"
#import "Similarity.h"

@implementation Item


- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self) {
		_name = name;
		_ratings = [[NSMutableSet alloc] init];
		_similarities = [[NSMutableSet alloc] init];
	}
	return self;
}

+(Item *)itemWithName:(NSString *)name {
	return [[Item alloc] initWithName:name];
}

-(void)calculateSimilarities:(NSSet *)otherItems {
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	for (Item *i in otherItems) {
		if(i == self) {
			continue;
		}
		
		if([self hasSimilarityTo:i]) {
			[dict setValue:@([self similarityTo:i]) forKey:i.name];
			continue;
		}
		
		Similarity *sim = [[Similarity alloc] initWithSimilarityBetween:self and:i];
		[_similarities addObject:sim];
		
		[dict setValue:@(sim.similarity) forKey:i.name];
		
		if([i hasSimilarityTo:self]) {
			continue;
		} else {
			[i.similarities addObject:sim];
		}
	}
	
	NSLog(@"%@: %@",self.name,dict);
	
}

-(BOOL)isEqual:(id)object {
	if(![object isKindOfClass:[Item class]]) return NO;
	
	Item *otherItem = (Item*)object;
	return ([_name isEqualToString:otherItem.name]) && ([_ratings isEqualToSet:otherItem.ratings]) && ([_similarities isEqualToSet:otherItem.similarities]);
}

-(NSUInteger)hash {
	return _name.hash;
}

-(NSString *)description {
	return [NSString stringWithFormat:@"Item '%@', %lu ratings",_name,(unsigned long)_ratings.count];
}


-(void)addRating:(Rating *)rating {
	[_ratings addObject:[NSValue valueWithNonretainedObject:rating]];
}

-(BOOL)hasSimilarityTo:(Item*)otherItem {
	for (Similarity *sim in _similarities) {
		if([sim otherItem:self] == otherItem) {
			return YES;
		}
	}
	return NO;
}

-(double)similarityTo:(Item *)item {
	for (Similarity *sim in _similarities) {
		if([sim otherItem:self] == item) {
			return sim.similarity;
		}
	}
	NSLog(@"No similarity between %@ %@",self,item);
	return NAN;
}

@end
