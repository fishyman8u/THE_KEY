//
//  IID_Game_Scene.h
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "cocos2d.h"
#import "IID_Control_Layer.h"
//#import "Gameplay.h"
//#import "IID_TileMap.h"
#import "Constants.h"
@interface IID_Game_Scene : CCScene
{
 
    
    IID_Control_Layer * control_layer;
  // Gameplay *gameplay;
}
-(void) initializeSceneWithTileMapFile:(NSString*)tmxFile;
//@property(nonatomic, readwrite, assign) IID_Gameplay *gamePlayLayer;
@property(nonatomic, readwrite, assign) IID_Control_Layer *control_layer;

@end
