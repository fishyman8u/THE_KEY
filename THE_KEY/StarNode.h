//
//  StarNode.h
//  THE_KEY
//
//  Created by Nathan Jones on 1/18/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
@interface StarNode : NSObject
{
    b2Body * aBody;
    CGPoint position;
    NSMutableArray *neighbors;
    bool Active;
    float cost_multiplier;
}
@property(readwrite, assign) CGPoint position;
@property(readwrite, assign) NSMutableArray * neighbors;
@property(readwrite, assign) bool Active;
@property(readwrite, assign) float cost_multiplier;
@property(readwrite, assign) b2Body *aBody;

+(bool)isNode:(StarNode *)ae inList:(NSArray*)list;
-(float)CostToNode:(StarNode *)starNode;


@end
