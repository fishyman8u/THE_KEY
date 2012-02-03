//
//  Tilemap_test.m
//  THE_KEY
//
//  Created by Nathan Jones on 12/23/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "Gameplay_Layer.h"

@implementation Gameplay_Layer
-(void) connectControlsWithRightJoystick:(SneakyJoystick*) rightJoystick 
                         andLeftJoystick:(SneakyJoystick*)leftJoystick
                          andProneButton:(SneakyButton*)proneButton
                         andCrouchButton:(SneakyButton*)crouchButton
{
    
    AFC * player = (AFC*) [sceneSpriteBatchNode getChildByTag:kAFC_Player_TagValue];
    if(player !=nil){
    [player setLeft_Joystick:leftJoystick];
    [player setRight_Joystick:rightJoystick];
    [player setProne:proneButton];
    [player setCrouch:crouchButton];
        CCLOG(@"Connecting joystick and buttons to player!");
    }
    else
    {
        CCLOG(@"NO PLAYER CONTROLLED UNIT OR ERROR CONNECTING JOYSTICKS!");
    }
    //tie the controls to the appropriate unit
}
-(CGPoint) convertCGPOINTToTileMapCoord:(CGPoint)coord
{
    CGPoint tilemap_coord;
    tilemap_coord.x = roundf(coord.x/tile_size);
    tilemap_coord.y = roundf(coord.y/tile_size);
    CCLOG(@"Coverted x: %f, y: %f to tilemap coords x: %f, y:%f", coord.x, coord.y, tilemap_coord.x, tilemap_coord.y);
    return tilemap_coord;
}
-(CGPoint) covertTilemapCoordToCGPoint:(CGPoint)tilemap_coord
{
    CGPoint coord;
    coord.x = tilemap_coord.x * tile_size;
    coord.y = tilemap_coord.y * tile_size;
    CCLOG(@"Coverted x: %f, y: %f from tilemap coords x: %f, y:%f", coord.x, coord.y, tilemap_coord.x, tilemap_coord.y);
    return coord;
}
-(BOOL)isValidTileCoord:(CGPoint)coord
{
    if((coord.x > 0) && (coord.x < map_size_x))
    return TRUE;
    else
    {
        return false;
    }
}
//checks if tile is passable
-(BOOL)isWallAtTileCoord:(CGPoint)coord
{
   // CCSprite *sprite = [tiles tileAt:coord];
   int tileGID =  [tiles tileGIDAt:coord]; 
    //test GID against passable/impassible tiles
    return FALSE;
}
-(void) adjustLayer//relies on Gamemanager for level size!
{
    
    
    
    IID_Generic_Soldier *player = (IID_Generic_Soldier *)[sceneSpriteBatchNode getChildByTag:kAFC_Player_TagValue];
    float x_pos = player.position.x;
    float y_pos = player.position.y;
     CGSize screenSize = [CCDirector sharedDirector].winSize;
    float halfOfTheScreenX = screenSize.width/2.0f;
    float halfOfTheScreenY =screenSize.height/2.0f;
    
    if(player.position.x != player.old_pos.x)
    {
      //  CCLOG(@"Setting X!");
        float newXPosition = halfOfTheScreenX - x_pos; // 7
        [self setPosition:ccp(newXPosition,self.position.y)];
    }
    if(player.position.y != player.old_pos.y)
    {
       // CCLOG(@"Setting Y!");
        float newXPosition = halfOfTheScreenY - y_pos; // 7
        [self setPosition:ccp(self.position.x,newXPosition)];
    }
   // CGSize screenSize = [CCDirector sharedDirector].winSize;
   // float halfOfTheScreenX = screenSize.width/2.0f;
    //float halfOfTheScreenY =screenSize.height/2.0f;
   /* CGSize levelSize = [[GameManager sharedGameManager] getDimensionsOfCurrentScene];
    CCLOG(@"Scrolling vars, x_pos: %f, y_pos: %f, screenSize.width: %f, screenSize.height: %f, halfOfScreen: %f, HS.width: %f, HS.height: %f", x_pos, y_pos, screenSize.height, screenSize.width, halfOfTheScreenX, levelSize.width, levelSize.height);
    if ((x_pos > halfOfTheScreenX) && 
        (x_pos < (levelSize.width - halfOfTheScreenX))) {
        // Background should scroll
        CCLOG(@"Setting X!");
        float newXPosition = halfOfTheScreenX - x_pos; // 7
        [tile_map_scroll_node setPosition:ccp(newXPosition,self.position.y)]; // 8
    }
    if ((y_pos > halfOfTheScreenY) && 
        (y_pos < (levelSize.width - halfOfTheScreenY))) {
        // Background should scroll
        CCLOG(@"Setting Y!");
        float newXPosition = halfOfTheScreenY - y_pos; // 7
        [tile_map_scroll_node setPosition:ccp(self.position.x,newXPosition)]; // 8
    }
    */
}

-(void) setupWorld{
    //init the physics world
    b2Vec2 gravity = b2Vec2(0, 0);
    
    bool doSleep = FALSE;
    world = new b2World(gravity, doSleep);
    
   // collision_listener = new b2ContactListener;
   // world->SetContactListener(collision_listener);
   // collision_listener->
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
    body->SetLinearDamping(0.1f);
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
-(void)createObjectOfType:(GameObjectType)objectType withHealth:(int)initialHealth atLocation:(CGPoint)spawnLocation withZValue:(int)Zvalue andTag:(int)tag andRotation:(float)rotation andTeam:(int)team
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
           
            [player setDelegate:self];
            [player setTeam:team];
            [sceneSpriteBatchNode addChild:player z:kAFC_Player_Z_Value tag:kAFC_Player_TagValue];
            [player release];
            return;
        }
    }
    switch (objectType) {
        case kAFC:
        {
            AFC *player = [[AFC alloc] initWithSpriteFrameName:@"AFC1.png"];
            [player setHealth:initialHealth];
            [player setPosition:spawnLocation];
            [self createBodyAtLocation:spawnLocation forSprite:player friction:1.0 restitution:1.0 density:1.0 isBox:YES];
            [player setDelegate:self];
            [player setTeam:team];
            [sceneSpriteBatchNode addChild:player];
            break;
        }
        case kBullet:
        {
            bullet *bullet1 = [[bullet alloc] initWithSpriteFrameName:@"bullet1.png"];
            [bullet1 setHealth:initialHealth];
            [self createBodyAtLocation:spawnLocation forSprite:bullet1 friction:1.0 restitution:1.0 density:1.0 isBox:YES];
            const float rotation_factor1 = rotation * RadianConvert;
            [bullet1 setRotation:rotation];
            b2Vec2 vel;
            const b2Vec2 pos = bullet1.body->GetPosition();
            
            vel.x = kBulletSpeed * sinf(rotation *RadianConvert);
            vel.y = kBulletSpeed * cosf(rotation *RadianConvert);
            bullet1.body->SetLinearVelocity(vel);
            bullet1.body->SetTransform(pos, rotation_factor1);
            //bullet1.body->SetTransform(pos, rotation_factor1);
            //[bullet1 setRotationTransform:rotation_factor1 andPosition:pos];
            [sceneSpriteBatchNode addChild:bullet1];
            return;
            break;
            
        }
        default:
            break;
    }
}
-(void) initializeTileMap:(NSString *)tmxFile
{
    map = [CCTMXTiledMap tiledMapWithTMXFile:tmxFile];
    tiles = [map layerNamed:@"map"];
    NSMutableDictionary *map_properties = [[NSMutableDictionary alloc] initWithDictionary:[map properties]];
    map_size_x = [[map_properties valueForKey:@"width"] intValue];
    map_size_y = [[map_properties valueForKey:@"height"] intValue];
    tile_size =  [[map_properties valueForKey:@"tilewidth"] intValue];
    NSMutableArray * object_layers = [[NSMutableArray alloc] initWithArray:[map objectGroups]];
    
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
                int team = [[units valueForKey:@"Team"] intValue];
                CGPoint location;
                location.x = x;
                location.y = y;
                CCLOG(@"Creating Player!");
                if([name isEqualToString: @"AFC"]) {
                    [self createObjectOfType:kAFC withHealth:100 atLocation:location withZValue:kAFC_Player_Z_Value andTag:kAFC_Player_TagValue andRotation:0.0f andTeam:team];
                    CCLOG(@"AFC Player created at x: %f and y: %f", location.x, location.y);
                    AFC * player = (AFC*)[sceneSpriteBatchNode getChildByTag:kAFC_Player_TagValue];
                    [player setIsPlayerControlled:YES];
                    
                    //player.rotation = 90.0f;
                    [player setRotation:90.0f];
                  
                    Player_Exists = TRUE;
                    //CCLOG(@"testing");
                }
                //create player object
                //check type then use a message to the gameplay layer to initialize the object and enable the controls
                continue;
            }
            if([name isEqualToString: @"AFC"])
            {
                CCLOG(@"Creating AFC");
                int x,y;
                x = [[units valueForKey:@"x"]intValue];
                y = [[units valueForKey:@"y"] intValue];
                int team = [[units valueForKey:@"Team"] intValue];
                CGPoint location;
                location.x = x;
                location.y = y;
                [self createObjectOfType:kAFC withHealth:100 atLocation:location withZValue:kAFC_Player_Z_Value andTag:100 andRotation:0.0f andTeam:team];
                CCLOG(@"AFC Player created at x: %f and y: %f", location.x, location.y);
               // AFC * player = (AFC*)[sceneSpriteBatchNode getChildByTag:kAFC_Player_TagValue];
                //[player setIsPlayerControlled:YES];
            }
            if(name == @"Dusan")
            {
                CCLOG(@"Creating Dusan");
                //create dusan object
            }
            
        }
    }
    
    [tile_map_scroll_node addChild:map];
   
}
-(id) init
{
    self = [super init];
    if(self)
    {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Standins Sheet_default.plist"];
        sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"Standins Sheet_default.png"];
        [self setupWorld];
        [self addChild:sceneSpriteBatchNode z:100];
        tile_map_scroll_node = [CCNode node];
        [self addChild:tile_map_scroll_node];
        if([GameManager sharedGameManager].currentScene == kGameLevel1){ 
            [self initializeTileMap:@"test_level.tmx"];}
        else if([GameManager sharedGameManager].currentScene == kGameLevel2)
        {
            
        }
        else
        {
            CCLOG(@"ERROR, no tilemap for scene!");
        }
       // CGSize screen = [CCDirector sharedDirector].winSize;
        [self schedule:@selector(update:)];
        tile_size = 64;
        map_size_x = 0;
        map_size_y = 0;
    }
    return self;
}
//void BeginContact
-(void)update:(ccTime)deltaTime
{
   // CCLOG(@"Updating!");
    CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
    
     int32 velocityIterations = 3;
     int32 positionIterations = 2;
     world->Step(deltaTime, velocityIterations, positionIterations);
     for(b2Body *b = world->GetBodyList(); b != NULL; b = b->GetNext()) {    
     if (b->GetUserData() != NULL) {
     IID_Game_Character *sprite = (IID_Game_Character *) b->GetUserData();
     sprite.position = ccp(b->GetPosition().x * PTM_RATIO, 
     b->GetPosition().y * PTM_RATIO);
         [sprite setRotation:CC_RADIANS_TO_DEGREES(b->GetAngle())];
         
    // sprite.rotation = CC_RADIANS_TO_DEGREES(b->GetAngle());
       // CCLOG(@"Sprite Rotation: %f", sprite.rotation);
     }        
     }
    for(IID_Game_Character *character in listOfGameObjects)
    {
        [character updateStateWithDeltaTime:deltaTime andListofGameObjects:listOfGameObjects];
    }
     if(Player_Exists)
     {
         //CCLOG(@"Adjusting layer!");
         [self adjustLayer];
     }
    
}
-(CGPoint) tileCoordForPosition:(CGPoint)position
{
    return position;
}
- (NSArray *)walkableAdjacentTilesCoordForTileCoord:(CGPoint)tileCoord
{
	NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:4];
    
	// Top
	CGPoint p = CGPointMake(tileCoord.x, tileCoord.y - 1);
	if ([self isValidTileCoord:p] && ![self isWallAtTileCoord:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
	}
    
	// Left
	p = CGPointMake(tileCoord.x - 1, tileCoord.y);
	if ([self isValidTileCoord:p] && ![self isWallAtTileCoord:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
	}
    
	// Bottom
	p = CGPointMake(tileCoord.x, tileCoord.y + 1);
	if ([self isValidTileCoord:p] && ![self isWallAtTileCoord:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
	}
    
	// Right
	p = CGPointMake(tileCoord.x + 1, tileCoord.y);
	if ([self isValidTileCoord:p] && ![self isWallAtTileCoord:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
	}
    
	return [NSArray arrayWithArray:tmp];
}

@end
