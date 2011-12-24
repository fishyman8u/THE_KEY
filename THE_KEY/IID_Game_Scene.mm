//
//  IID_Game_Scene.m
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "IID_Game_Scene.h"


@implementation IID_Game_Scene
//@synthesize gamePlayLayer;
@synthesize control_layer;

-(id) init
{
   gameplay = [IID_Gameplay node];
    self.control_layer = [IID_Control_Layer node];
   
    return self;
}

-(void) initializeSceneWithTileMapFile:(NSString*)tmxFile
{
        
    [gameplay initializeTileMap:tmxFile];    
   
    
}
@end
