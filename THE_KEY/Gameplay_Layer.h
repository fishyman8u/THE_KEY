//
//  Tilemap_test.h
//  THE_KEY
//
//  Created by Nathan Jones on 12/23/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "Box2D.h"
#import "CommonProtocols.h"
#import "Constants.h"
#import "AFC.h"
#import "IID_Game_Character.h"
#import "GameManager.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "GLES-Render.h"

@interface Gameplay_Layer : CCLayer
{
    CCSpriteBatchNode *sceneSpriteBatchNode;
    b2World *world;
    GLESDebugDraw *debugDraw;
}
-(void) connectControlsWithRightJoystick:(SneakyJoystick*) rightJoystick 
                         andLeftJoystick:(SneakyJoystick*)leftJoystick
                          andProneButton:(SneakyButton*)proneButton
                         andCrouchButton:(SneakyButton*)crouchButton;
-(void) initializeTileMap:(NSString *) tmxFile;
@end
