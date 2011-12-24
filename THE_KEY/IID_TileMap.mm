//
//  IID_TileMap.m
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "IID_TileMap.h"

@implementation IID_TileMap
@synthesize delegate;
-(void) adjustLayer//relies on Gamemanager for level size!
{
    IID_Generic_Soldier *player = (IID_Generic_Soldier *)[sceneSpriteBatchNode getChildByTag:kAFC_Player_TagValue];
    float x_pos = player.position.x;
    float y_pos = player.position.y;
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    float halfOfTheScreen = screenSize.width/2.0f;
    CGSize levelSize = [[GameManager sharedGameManager] getDimensionsOfCurrentScene];
    if ((x_pos > halfOfTheScreen) && 
        (x_pos < (levelSize.width - halfOfTheScreen))) {
        // Background should scroll
        float newXPosition = halfOfTheScreen - x_pos; // 7
        [self setPosition:ccp(newXPosition,self.position.y)]; // 8
    }
    if ((y_pos > halfOfTheScreen) && 
        (y_pos < (levelSize.width - halfOfTheScreen))) {
        // Background should scroll
        float newXPosition = halfOfTheScreen - y_pos; // 7
        [self setPosition:ccp(self.position.x,newXPosition)]; // 8
    }

}
-(void)initializeWithTilemap:(NSString*)tmxFile
{
    tileMap = [CCTMXTiledMap tiledMapWithTMXFile:tmxFile];
   // CCTMXLayer *mapTiles = [tileMap layerNamed:@"Map"];
   // CCTMXLayer *passable = [tileMap layerNamed:@"Passible"];
    CCTMXObjectGroup *objects1 = [tileMap objectGroupNamed:@"Objects"];
    
    NSMutableArray *gameObjects = [objects1 objects];
    //  NSMutableDictionary * object = [objects1 objectNamed:@"Player"];
    
     for (NSMutableDictionary * units in gameObjects)
    {
        NSString *type;
        NSString *name;
        name = [units objectForKey:@"type"];
        type = [units objectForKey:@"name"];
       
        if([type isEqualToString:@"Player1"])
        {
            int x,y;
            x = [[units valueForKey:@"x"]intValue];
            y = [[units valueForKey:@"y"] intValue];
            
            CGPoint location;
            location.x = 5.0;
            location.y = 5.0;
            CCLOG(@"Creating Player!");
            if([name isEqualToString: @"AFC"]) 
            [delegate createObjectOfType:kAFC withHealth:100 atLocation:location withZValue:kAFC_Player_Z_Value andTag:kAFC_Player_TagValue];
            //create player object
            //check type then use a message to the gameplay layer to initialize the object and enable the controls
            continue;
        }
        if([name isEqualToString: @"AFC"])
        {
            CCLOG(@"Creating AFC");
            //create AI afc object
        }
        if(name == @"Dusan")
        {
            CCLOG(@"Creating Dusan");
            //create dusan object
        }
        //etc etc
        [self addChild:tileMap];
        //need to create a delegate method to create box2d geometry for impassible tiles and the sides of the screen.
    }
}
-(void) update:(ccTime)deltaTime
{
    [self adjustLayer];
}
-(id) init
{
    self = [super init];
    if(self)
    {
        CCLOG(@"Tilemap layer, basic init done!");
        
    }
    return self;
}
-(id) initWithFile:(NSString *)tileMapFile
{
    self = [super init];
    if(self)
    {
        [self initializeWithTilemap:tileMapFile];
        
    }
    return self;
    
}
@end
