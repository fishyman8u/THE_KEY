//
//  StarNode.m
//  THE_KEY
//
//  Created by Nathan Jones on 1/18/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "StarNode.h"

@implementation StarNode
@synthesize aBody, position, Active, neighbors, cost_multiplier;


-(id) init
{
    self = [super init];
    if(self)
    {
        Active = YES;
        neighbors = [[NSMutableArray alloc] init];
        cost_multiplier = 1.0f;
    }
    return self;
}
+(bool)isNode:(StarNode *)a inList:(NSArray *)list
{
    for(int i=0; i<list.count; i++){
		StarNode *b = [list objectAtIndex:i];
		if(a.position.x == b.position.x && a.position.y == b.position.y){
			return YES;
		}
	}
	return NO;
}
-(float) CostToNode:(StarNode *)starNode
{
    CCLOG(@"Not implemented!! Returning 0");
    return 0.0f;
    
}
@end
