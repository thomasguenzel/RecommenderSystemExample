//
//  Similarity.m
//  RecSys
//
//  Created by Thomas Günzel on 28/05/15.
//  Copyright (c) 2015 Thomas Günzel. All rights reserved.
//

#import "Similarity.h"

#import "Rating.h"

@implementation Similarity

- (instancetype)initWithSimilarityBetween:(Item *)itemA and:(Item *)itemB
{
	self = [super init];
	if (self) {
		_itemA = itemA;
		_itemB = itemB;
		[self euclideanDistance];
	}
	return self;
}

-(void)adjustedCosineSimilarity {
	double sumMulDifs = 0.0;
	double sumADifSquare = 0.0;
	double sumBDifSquare = 0.0;
	
	for (NSValue *weak_rA in _itemA.ratings) {
		for (NSValue *weak_rB in _itemB.ratings) {
			Rating *rA = [weak_rA nonretainedObjectValue];
			Rating *rB = [weak_rB nonretainedObjectValue];
			// using == for performance reasons
			if (rA.user == rB.user) {
				User *u = rA.user;
				double userMean = u.meanRating;
				double aDif = fabs(rA.rating-userMean);
				double bDif = fabs(rB.rating-userMean);
				sumMulDifs += aDif*bDif;
				sumADifSquare += aDif*aDif;
				sumBDifSquare += bDif*bDif;
			}
		}
	}
	
	_similarity = sumMulDifs / ( sqrt(sumADifSquare) * sqrt(sumBDifSquare) );
}

-(void)euclideanDistance {
	double sum = 0.0;
	
	BOOL foundAtLeastOne = NO;
	for (NSValue *weak_rA in _itemA.ratings) {
		for (NSValue *weak_rB in _itemB.ratings) {
			Rating *rA = [weak_rA nonretainedObjectValue];
			Rating *rB = [weak_rB nonretainedObjectValue];
			// using == for performance reasons
			if (rA.user == rB.user) {
				double dif = rA.rating - rB.rating;
				sum += dif*dif;
				foundAtLeastOne = YES;
			}
		}
	}
	
	if(!foundAtLeastOne) {
		// not related
		_similarity = NAN;
		return;
	}
	
	_similarity = 1.0 / ( 1.0+ sqrt(sum) );
	
}


-(Item *)otherItem:(Item *)sender {
	if(sender == _itemA) {
		return _itemB;
	} else if(sender == _itemB) {
		return _itemA;
	}
	return nil;
}

-(BOOL)isEqual:(id)object {
	if(![object isKindOfClass:[Similarity class]]) {
		return NO;
	}
	
	Similarity *sim = (Similarity*)object;
	
	return (sim.similarity == _similarity) && (sim.itemA == _itemA) && (sim.itemB == _itemB);
}

-(NSString *)description {
	return [NSString stringWithFormat:@"Similarity %.4f between %@ and %@",_similarity,_itemA.name,_itemB.name];
}

-(NSUInteger)hash {
	return [self description].hash;
}


@end
