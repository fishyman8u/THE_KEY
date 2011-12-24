//
//  IID_Game_Character.m
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "IID_Game_Character.h"
//DONE!!!////////////////////
@implementation IID_Game_Character
@synthesize health;
@synthesize body;
@synthesize characterState;
@synthesize velocity;
@synthesize destination;
@synthesize Target_point;
@synthesize isPlayerControlled;

-(id) init
{
    
    if(self = [super init])
    {
        CCLOG(@"Character init!");
       // [self changeState:kStateSpawning];
        self.body = NULL;
        //self.velocity = b2Vec2(0.0f, 0.0f);
        self.destination = ccp(0.0f, 0.0f);
        self.Target_point = ccp(0.0f, 0.0f);
        self.health = 100;
        self.isPlayerControlled = FALSE;
        
    }
    return self;
}
-(void) changeState:(CharacterStates)newState
{
    self.characterState = newState;
}
-(void) updateStateWithDeltaTime:(ccTime)deltaTime andListofGameObjects:(CCArray *)listOfGameObjects
{
    CCLOG(@"ERROR, override update state with delta time in Game Character!");
}
@end
