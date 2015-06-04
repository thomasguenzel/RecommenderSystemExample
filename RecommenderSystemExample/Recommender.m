//
//  Recommender.m
//  RecSys
//
//  Created by Thomas Günzel on 28/05/15.
//  Copyright (c) 2015 Thomas Günzel. All rights reserved.
//

#import "Recommender.h"

#import "Rating.h"

@implementation Recommender

- (instancetype)init
{
	self = [super init];
	if (self) {
		_items = [[NSMutableSet alloc] init];
		_users = [[NSMutableSet alloc] init];
		_ratings = [[NSMutableSet alloc] init];
	}
	return self;
}

-(instancetype)initFromJSON:(NSData *)json {
	self = [self init];
	if (self) {
		NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
		
		if(![dict isKindOfClass:[NSDictionary class]]) {
			return nil;
		}
		
		for (NSString *key in dict) {
			NSDictionary *ratingsDict = [dict valueForKey:key];
			
			if([ratingsDict isKindOfClass:[NSDictionary class]]) {
				[self addEntry:key dict:ratingsDict];
			}
		}
		
	}
	return self;
}


-(void)addEntry:(NSString*)key dict:(NSDictionary *)ratings {
	NSString *itemName = key;
	if(itemName.length == 0 || ratings == nil) {
		return;
	}
	
	// search for item and create if needed
	Item *item = [self itemWithName:itemName];
	if(item == nil) {
		item = [Item itemWithName:itemName];
		[_items addObject:item];
	}
	
	// iterate through the ratings from the dictionary
	for (NSString *ratingUser in ratings) {
		NSString *userName = ratingUser;
		NSNumber *ratingNumber = [ratings valueForKey:ratingUser];
		
		// skip corrupted ratings
		if(userName.length == 0 || ratingNumber == nil || [ratingNumber isKindOfClass:[NSNull class]]) {
			continue;
		}
		
		double ratingDouble = [ratingNumber doubleValue];
		
		// search for user and create if needed
		User *user = [self userWithName:userName];
		if(user == nil) {
			user = [User userWithName:userName];
			[_users addObject:user];
		}
		
		// create the rating
		Rating *rating = [Rating ratingWithRating:ratingDouble fromUser:user onItem:item];
		[_ratings addObject:rating];
		
	}
}

-(User *)userWithName:(NSString *)name {
	for (User *u in _users) {
		if([u.name isEqualToString:name]) {
			return u;
		}
	}
	return nil;
}


-(Item *)itemWithName:(NSString *)name {
	for (Item *i in _items) {
		if([i.name isEqualToString:name]) {
			return i;
		}
	}
	return nil;
}


-(void)calculateSimilarities {
	for (Item *i in _items) {
		[i calculateSimilarities:_items];
	}
}

-(NSString *)description {
	return [NSString stringWithFormat:@"Recommender with\n**** ITEMS ****\n%@\n**** USERS ****\n%@\n**** RATINGS ****\n%@",
			_items,_users,_ratings];
}


@end
