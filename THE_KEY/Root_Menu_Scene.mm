//
//  Root_Menu_Scene.m
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "Root_Menu_Scene.h"
#import "Root_Menu.h"
@implementation Root_Menu_Scene
- (id)init
{
    self = [super init];
    if (self) {
        CCLOG(@"Adding layers to scene");
        // Initialization code here.
        Root_Menu * mainMenuLayer = [Root_Menu node];
        [self addChild:mainMenuLayer];
    }
    
    return self;
}
@end
