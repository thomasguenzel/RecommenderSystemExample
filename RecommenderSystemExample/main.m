//
//  main.m
//  RecommenderSystemExample
//
//  Created by Thomas Günzel on 29/05/15.
//  Copyright (c) 2015 Thomas Günzel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recommender.h"

int main(int argc, const char * argv[]) {
	@autoreleasepool {
#warning Update Path to JSON-File
		NSData *jsonData = [NSData dataWithContentsOfFile:@"<PATH-TO-JSON>/movies_small.json"];
		Recommender *recommender = [[Recommender alloc] initFromJSON:jsonData];
		NSLog(@"%@",recommender);
		
		[recommender calculateSimilarities];
		
		User *user = [recommender userWithName:@"Moritz"];
		Item *item = [recommender itemWithName:@"Inception"];
		double prediction = [user predictionForItem:item];
		NSLog(@"%@ will probably give %@ %f stars",user.name,item.name,prediction);
	}
    return 0;
}
