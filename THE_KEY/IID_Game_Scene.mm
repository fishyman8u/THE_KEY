//
//  IID_Game_Scene.m
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "IID_Game_Scene.h"


@implementation IID_Game_Scene
@synthesize gamePlayLayer;
@synthesize control_layer;

-(id) init
{
    self.gamePlayLayer = [IID_Gameplay node];
    self.control_layer = [IID_Control_Layer node];
   
    return self;
}

-(BOOL) initializeSceneWithTileMapFile:(NSString*)tmxFile
{
    IID_TileMap *tileMapLayer = [IID_TileMap node];
    
    
    if(tileMapLayer != nil)
    {
    [tileMapLayer initializeWithTilemap:tmxFile];
        [self.gamePlayLayer connectControlsWithRightJoystick:control_layer.rightJoystick andLeftJoystick:control_layer.leftJoystick andProneButton:control_layer.proneButton andCrouchButton:control_layer.crouchButton];
        [self addChild:self.gamePlayLayer z:1];
        [self addChild:self.control_layer z:2];
     [self addChild:tileMapLayer z:0];  
        return TRUE;
        
    }
    return FALSE;//error!
}
@end
