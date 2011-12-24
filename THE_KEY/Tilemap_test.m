//
//  Tilemap_test.m
//  THE_KEY
//
//  Created by Nathan Jones on 12/23/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "Tilemap_test.h"

@implementation Tilemap_test
-(id) init
{
    self = [super init];
    if(self)
    {
        CCTMXTiledMap *map = [CCTMXTiledMap tiledMapWithTMXFile:@"test_level.tmx"];
        [self addChild:map];
    }
    return self;
}
@end
