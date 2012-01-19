//
//  StarNodePath.m
//  THE_KEY
//
//  Created by Nathan Jones on 1/19/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "StarNodePath.h"

@implementation StarNodePath
@synthesize cost, previous,node;

-(id) init
{
    self = [super init];
    if(self)
    {
        cost = 0.0f;
        
    }
    return  self;
}
+(id)createWithStarNode:(StarNode *)node
{
    if(!node)
    {
        return nil; //can't create without a node
    }
    StarNodePath *pathNode = [[StarNodePath alloc] init];
    pathNode.node = node;
    return pathNode;
}
+(NSMutableArray *) findPathFrom:(StarNode *)fromNode to:(StarNode *)toNode
{
    CCLOG(@"Finding path!");
    NSMutableArray *foundPath = [[NSMutableArray alloc] init];
    if(fromNode.position.x == toNode.position.x && fromNode.position.y == toNode.position.y){
		return nil;
    }
    NSMutableArray *openList =[[[NSMutableArray alloc] init] autorelease];
    NSMutableArray *closedList =[[[NSMutableArray alloc] init] autorelease];
    StarNodePath *currentNode = nil;
    StarNodePath *aNode = nil;
    
    StarNodePath *startNode = [StarNodePath createWithStarNode:fromNode];
    StarNodePath *endNode = [StarNodePath createWithStarNode:toNode];
    [openList addObject:startNode];
    while(openList.count > 0)
    {
        currentNode = [StarNodePath lowestCostNodeInArray:openList];
        if( currentNode.node.position.x == endNode.node.position.x &&
           currentNode.node.position.y == endNode.node.position.y){
            aNode = currentNode;
            while(aNode.previous != nil)
            {
                //mark path
                [foundPath addObject:[NSValue valueWithCGPoint:CGPointMake(aNode.node.position.x, aNode.node.position.y)]];
                aNode = aNode.previous;
            }
            [foundPath addObject:[NSValue valueWithCGPoint: CGPointMake(aNode.node.position.x, aNode.node.position.y)]];
            CCLOG(@"Path found!");
			return foundPath;
        }
        else
        {
            //still searching
            [closedList addObject:currentNode];
            [openList removeObject:currentNode];
            for(int i=0; i<currentNode.node.neighbors.count; i++){
                StarNodePath *aNode = [StarNodePath createWithStarNode:[currentNode.node.neighbors objectAtIndex:i]];
                aNode.cost = currentNode.cost + [currentNode.node CostToNode:aNode.node] + [aNode.node CostToNode:endNode.node];
                if(aNode.node.Active && ![StarNodePath isPathNode:aNode inList:openList] && ![StarNodePath isPathNode:aNode inList:closedList])
                {
                    [openList addObject:aNode];
                }
            }
        }
            
    }
    return nil;//no path found
}
+(StarNodePath*)lowestCostNodeInArray:(NSMutableArray *)a
{
    StarNodePath *lowest = nil;
    for(int i=0; i<a.count; i++){
		StarNodePath *node = [a objectAtIndex:i];
		if(!lowest || node.cost < lowest.cost){
			lowest = node;
		}
	}
	return lowest;
}
+(bool) isPathNode:(StarNodePath *)a inList:(NSArray *)list
{
    for(int i=0; i<list.count; i++){
		StarNodePath *b = [list objectAtIndex:i];
		if(a.node.position.x == b.node.position.x && a.node.position.y == b.node.position.y){
			return YES;
		}
	}
	return NO;
}
@end
