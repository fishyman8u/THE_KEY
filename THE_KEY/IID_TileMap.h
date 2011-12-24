//
//  IID_TileMap.h
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "CommonProtocols.h"
#import "Constants.h"
#import "AFC.h"
#import "GameManager.h"
@interface IID_TileMap : CCLayer
{
    CCSpriteBatchNode *sceneSpriteBatchNode;
    CCTMXTiledMap *tileMap;
    id <GameplayLayerDelegate> delegate;
}
@property (nonatomic,assign) id <GameplayLayerDelegate> delegate;
-(void)initializeWithTilemap:(NSString*)tmxFile;
@end
