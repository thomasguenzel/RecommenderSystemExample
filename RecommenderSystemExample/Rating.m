//
//  Rating.m
//  RecSys
//
//  Created by Thomas Günzel on 28/05/15.
//  Copyright (c) 2015 Thomas Günzel. All rights reserved.
//

#import "Rating.h"

@implementation Rating

- (instancetype)initWithRating:(double)rating user:(User *)user item:(Item *)item
{
	self = [super init];
	if (self) {
		_rating = rating;
		_user = user;
		_item = item;
		
		[_user addRating:self];
		[_item addRating:self];
	}
	return self;
}

+(Rating *)ratingWithRating:(double)rating fromUser:(User *)user onItem:(Item *)item {
	return [[Rating alloc] initWithRating:rating user:user item:item];
}

-(BOOL)isEqual:(id)object {
	if(![object isKindOfClass:[Rating class]]) return NO;
	
	Rating *otherRating = (Rating*)object;
	// using == instead of isEqual: to check if they point to the same user/item in memory
	// as with multiple recommenders there might be overlapping users or items
	return (_rating == otherRating.rating) && (_user == otherRating.user) && (_item == otherRating.item);
}

-(NSString *)description {
	return [NSString stringWithFormat:@"'%@' rated %.1f by '%@'",_item.name,_rating,_user.name];
}

@end
