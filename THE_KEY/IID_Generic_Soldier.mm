//
//  IID_Generic_Soldier.m
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "IID_Generic_Soldier.h"

@implementation IID_Generic_Soldier
@synthesize standing;
@synthesize Standing_to_crouching;
@synthesize crouching;
@synthesize crouching_to_standing;
@synthesize crouching_to_prone;
@synthesize prone_to_crouching;
@synthesize prone_anim;
@synthesize crawling;
@synthesize dive_to_prone;
@synthesize cover_behind_wall;
@synthesize leave_wall;
@synthesize walking;
@synthesize running;
@synthesize firing_running;
@synthesize firing_walking;
@synthesize firing_crouched;
@synthesize firing_prone;
@synthesize lean_from_wall_and_fire;
@synthesize fire_over_low_wall;
@synthesize get_hit;
@synthesize dying;
@synthesize wounded;
@synthesize crouch;
@synthesize prone;
@synthesize  cover;
@synthesize left_Joystick;
@synthesize right_Joystick;
@synthesize canShoot;
@synthesize weapon;
//apply movement joystick
//apply shooting joystick

-(void) initAnimations
{
    [self setWalking:[self loadPlistForAnimationWithName:@"Walking_Anim" andClassName:NSStringFromClass([self class])]];
    [self setStanding:[self loadPlistForAnimationWithName:@"Standing_Anim" andClassName:NSStringFromClass([self class])]];
    [self setStanding_to_crouching:[self loadPlistForAnimationWithName:@"Crouching_Anim" andClassName:NSStringFromClass([self class])]];
    [self setCrouching_to_prone:[self loadPlistForAnimationWithName:@"Prone_Anim" andClassName:NSStringFromClass([self class])]];
    [self setCrouching_to_standing:[self loadPlistForAnimationWithName:@"Crouching_to_Standing" andClassName:NSStringFromClass([self class])]];
    [self setProne_to_crouching:[self loadPlistForAnimationWithName:@"Prone_to_Standing" andClassName:NSStringFromClass([self class])]];
    //dying animations
}

-(void) updateStateWithDeltaTime:(ccTime)deltaTime
            andListofGameObjects:(CCArray*)listOfGameObjects
{
   //check if dead
    if(!self.isActive) return;
    //Check collisions? (at this point, no, will be done in physics sim update)
    
    //check if AI decision tree should run (should be set to YES, when under attack, or enemies are sighted, etc in physics sim)
    if(decision_needed)
    {
        //decision tree here
    }
    
    //check message vars
    if(fireIfAble)
    {
        if(canShoot)
        {
            //get a targeting solution
            //create a bullet using the targeting solution
        }
        else
        {
            //find out what is blocking shooting and change state using a mini-decision tree
        }
            
        
    }
    //BOOL value set by pathfinder from results of decision tree when movement is requires
    if(move)
    {
        //set velocity to move to next point in array of points, if moving, check current position versus destination position, check to see if it was passed up as well
    }
    //Change animation and character state according to the results of the update
    
    //position updates will be handled by BOX2D, ai and player initiated movement is handled by velocity adjustments
    
    
    
}

-(void) changeState:(CharacterStates)newState
{
    CCLOG(@"NEED TO OVERRIDE FUNCTION, ******* IN IID_GAME_OBJECT CHANGE STATE");
}
-(id) init
{
    self = [super init];
    if(self)
    {
        [self initAnimations];
        //need to set default values
        //need to create dealloc method to cleanup
        
    }
    return self;
    
}
@end
