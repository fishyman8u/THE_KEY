//
//  StarNodePath.h
//  THE_KEY
//
//  Created by Nathan Jones on 1/19/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "StarNode.h"
#import "Box2D.h"

@interface StarNodePath : NSObject
{
    StarNode *node;//actual node this path is pointing to
    StarNodePath *previous; //previous node on path
    float cost;
}
@property (readwrite, assign) StarNode *node;
@property (readwrite, assign) StarNodePath *previous;
@property (readwrite, assign) float cost;
+(id) createWithStarNode:(StarNode*)node;
+(NSMutableArray*)findPathFrom:(StarNode*)fromNode to:(StarNode*) toNode;
+(bool)isPathNode:(StarNodePath*)a inList:(NSArray*)list;
+(StarNodePath*) lowestCostNodeInArray:(NSMutableArray*)a;
@end
