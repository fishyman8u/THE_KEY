//
//  IID_Gameplay.m
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "IID_Gameplay.h"

@implementation IID_Gameplay
//@synthesize world;
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
-(void) connectControlsWithRightJoystick:(SneakyJoystick*) rightJoystick 
                         andLeftJoystick:(SneakyJoystick*)leftJoystick
                          andProneButton:(SneakyButton*)proneButton
                         andCrouchButton:(SneakyButton*)crouchButton
{
    //tie the controls to the appropriate unit
}
-(void) createBodyAtLocation:(CGPoint)location 
                   forSprite:(IID_Game_Character *)sprite friction:(float32)friction      
                 restitution:(float32)restitution density:(float32)density 
                       isBox:(BOOL)isBox
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = b2Vec2(location.x/PTM_RATIO, 
                              location.y/PTM_RATIO);
    bodyDef.allowSleep = false;
    b2Body *body = world->CreateBody(&bodyDef);
    body->SetUserData(sprite);
    sprite.body = body;
    
    b2FixtureDef fixtureDef;
    
    if (isBox) {
        b2PolygonShape shape;
        shape.SetAsBox(sprite.contentSize.width/2/PTM_RATIO, 
                       sprite.contentSize.height/2/PTM_RATIO);    
        fixtureDef.shape = &shape;
    } else {
        b2CircleShape shape;        
        shape.m_radius = sprite.contentSize.width/2/PTM_RATIO;
        fixtureDef.shape = &shape;
    }    
    
    fixtureDef.density = density;
    fixtureDef.friction = friction;
    fixtureDef.restitution = restitution;
    
    body->CreateFixture(&fixtureDef);   
}
-(void) initializeTileMap:(NSString *) tmxFile
{
    tileMap = [CCTMXTiledMap tiledMapWithTMXFile:tmxFile];
    //NSMutableArray *object_layers = [[NSMutableArray alloc]init];
    NSMutableArray * object_layers = [[NSMutableArray alloc] initWithArray:[tileMap objectGroups]];
    
    for(CCTMXObjectGroup *object_layer in object_layers)
    {
    
        NSMutableArray *objects = [object_layer objects]; 
        for (NSMutableDictionary * units in objects)
        {
            NSString *name;
            NSString *type;
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
                    [self createObjectOfType:kAFC withHealth:100 atLocation:location withZValue:kAFC_Player_Z_Value andTag:kAFC_Player_TagValue];
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

        }
    }
    [self addChild:tileMap];
}
-(void) setupWorld{
    //init the physics world
    b2Vec2 gravity = b2Vec2(0, 0);
    bool doSleep = FALSE;
    world = new b2World(gravity, doSleep);
}


-(id) init
{
    self = [super init];
    if(self)
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Standins Sheet_default.plist"];
        sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"Standins Sheet_default.png"];
        [self setupWorld];
        [self addChild:sceneSpriteBatchNode];
        
    }
    return self;
}
-(void)createObjectOfType:(GameObjectType)objectType withHealth:(int)initialHealth atLocation:(CGPoint)spawnLocation withZValue:(int)Zvalue andTag:(int)tag
{
    if(tag == kAFC_Player_TagValue)
    {
        if(objectType == kAFC)
        {
            AFC *player = [[AFC alloc] initWithSpriteFrameName:@"AFC1.png"];
            [player setHealth:initialHealth];
            [player setPosition:spawnLocation];
            [self createBodyAtLocation:spawnLocation forSprite:player friction:1.0 restitution:1.0 density:1.0 isBox:YES];
            //player.gameObjectType = kAFC;
            //[player setTag:kAFC_Player_TagValue];
            
            //set weapons, ammo, etc
            
            
            [sceneSpriteBatchNode addChild:player z:kAFC_Player_Z_Value tag:kAFC_Player_TagValue];
            [player release];
        }
    }
}

-(void)update:(ccTime)deltaTime
{
    CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
    for(IID_Game_Character *character in listOfGameObjects)
    {
        [character updateStateWithDeltaTime:deltaTime andListofGameObjects:listOfGameObjects];
    }
    int32 velocityIterations = 3;
    int32 positionIterations = 2;
    world->Step(deltaTime, velocityIterations, positionIterations);
    for(b2Body *b = world->GetBodyList(); b != NULL; b = b->GetNext()) {    
        if (b->GetUserData() != NULL) {
            IID_Game_Character *sprite = (IID_Game_Character *) b->GetUserData();
            sprite.position = ccp(b->GetPosition().x * PTM_RATIO, 
                                  b->GetPosition().y * PTM_RATIO);
            sprite.rotation = CC_RADIANS_TO_DEGREES(b->GetAngle() * -1);
        }        
    }   

    
}
-(b2World*) getRefToWorld
{
    return nil;
}
@end
