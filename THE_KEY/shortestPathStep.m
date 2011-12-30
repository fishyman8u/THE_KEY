//
//  shortestPathStep.m
//  THE_KEY
//
//  Created by Nathan Jones on 12/27/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "shortestPathStep.h"

@implementation shortestPathStep
@synthesize position;
@synthesize gScore;
@synthesize hScore;
@synthesize parent;

- (id)initWithPosition:(CGPoint)pos
{
	if ((self = [super init])) {
		position = pos;
		gScore = 0;
		hScore = 0;
		parent = nil;
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@  pos=[%.0f;%.0f]  g=%d  h=%d  f=%d", [super description], self.position.x, self.position.y, self.gScore, self.hScore, [self fScore]];
}

- (BOOL)isEqual:(shortestPathStep *)other
{
	return CGPointEqualToPoint(self.position, other.position);
}

- (int)fScore
{
	return self.gScore + self.hScore;
}
@end
