//
//  IID_Gameplay.h
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "cocos2d.h"
#include "Box2D.h" 
#import "GLES-Render.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "IID_Game_Character.h"
//#import "IID_Static_Game_Object.h"
#import "AFC.h"

@interface IID_Gameplay : CCLayer <GameplayLayerDelegate>
{
    b2World *world;
    GLESDebugDraw *debugDraw;
    CCSpriteBatchNode *sceneSpriteBatchNode;
    
}
//@property(assign, readwrite) b2World *world;
-(void) connectControlsWithRightJoystick:(SneakyJoystick*) rightJoystick 
                         andLeftJoystick:(SneakyJoystick*)leftJoystick
                          andProneButton:(SneakyButton*)proneButton
                         andCrouchButton:(SneakyButton*)crouchButton;
@end
