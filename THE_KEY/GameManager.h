//
//  GameManager.h
//  The_KEY
//
//  Created by Nathan Jones on 10/23/11.
//  Copyright 2011 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "CommonProtocols.h"
//#import "Box2D_Test.h"
#import "IID_Game_Scene.h"

@interface GameManager : NSObject
{
    BOOL isMusicOn;
    BOOL isSoundEffectsOn;
    BOOL hasPlayerDied;
    SceneTypes currentScene;
}

@property(readwrite) BOOL isMusicOn;
@property(readwrite) BOOL isSoundEffectsOn;
@property(readwrite) BOOL hasPlayerDied;

+(GameManager *)sharedGameManager;

-(void)runSceneWithID:(SceneTypes) sceneID;
-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen;

-(CGSize)getDimensionsOfCurrentScene;
@end
