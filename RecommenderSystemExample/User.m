//
//  User.m
//  RecSys
//
//  Created by Thomas Günzel on 28/05/15.
//  Copyright (c) 2015 Thomas Günzel. All rights reserved.
//

#import "User.h"
#import "Rating.h"

@implementation User

- (instancetype)initWithName:(NSString *)name
{
	self = [super init];
	if (self) {
		_name = name;
		_ratings = [[NSMutableSet alloc] init];
	}
	return self;
}

+(User *)userWithName:(NSString *)name {
	return [[User alloc] initWithName:name];
}

-(NSString *)description {
	return [NSString stringWithFormat:@"User '%@', %lu ratings",_name,(unsigned long)_ratings.count];
}

-(void)addRating:(Rating *)rating {
	[_ratings addObject:[NSValue valueWithNonretainedObject:rating]];
}

-(double)meanRating {
	double sum = 0.0;
	for (NSValue *weak_r in _ratings) {
		Rating *r = [weak_r nonretainedObjectValue];
		sum += r.rating;
	}
	return (sum/(double)_ratings.count);
}

-(NSUInteger)hash {
	return _name.hash;
}

-(BOOL)isEqual:(id)object {
	if(![object isKindOfClass:[User class]]) return NO;
	
	User *otherUser = (User*)object;
	return [otherUser.name isEqualToString:_name] && [_ratings isEqualToSet:otherUser.ratings];
}


-(double)predictionForItem:(Item *)item {
	// check if item is already rated
	for (NSValue *weak_r in _ratings) {
		Rating *r = [weak_r nonretainedObjectValue];
		if(r.item == item) {
			NSLog(@"WARNING - predictionForItem: called with rated item");
			return r.rating;
		}
	}
	
	double sumMul = 0.0;
	double sumSim = 0.0;
	
	for (NSValue *weak_r in _ratings) {
		Rating *r = [weak_r nonretainedObjectValue];
		double sim = [r.item similarityTo:item];
		if(isnan(sim)) {
			continue;
		}
		
		NSLog(@"Similarity between %@ and %@: %f * %f = %f",r.item.name,item.name,r.rating,sim,(r.rating*sim));
		
		sumMul += r.rating*sim;
		sumSim += fabs(sim);
	}
	
	return (sumMul/sumSim);
}


@end
