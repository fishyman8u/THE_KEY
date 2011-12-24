//
//  Test_Scene.m
//  THE_KEY
//
//  Created by Nathan Jones on 12/23/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "Test_Scene.h"

@implementation Test_Scene
-(id) init
{
    self = [super init];
    if(self)
    {
        Tilemap_test *test = [Tilemap_test node];
        [self addChild:test];
    }
    return self;
}
@end
