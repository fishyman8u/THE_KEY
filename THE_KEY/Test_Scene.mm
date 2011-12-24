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
        Gameplay_Layer *test = [Gameplay_Layer node];
        [self addChild:test z:0];
        IID_Control_Layer *control_layer = [IID_Control_Layer node];
        [self addChild:control_layer z:5];
        
    }
    return self;
}
@end
