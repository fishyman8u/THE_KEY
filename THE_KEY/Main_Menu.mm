//
//  Main_Menu.m
//  The_KEY
//
//  Created by Nathan Jones on 10/23/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "Main_Menu.h"
#import "MainMenuScene.h"

@implementation Main_Menu

- (id)init
{
    self = [super init];
    if (self) {
        CCLOG(@"Adding layers to scene");
        // Initialization code here.
       MainMenuScene * mainMenuLayer = [MainMenuScene node];
        [self addChild:mainMenuLayer];
    }
    
    return self;
}

@end
