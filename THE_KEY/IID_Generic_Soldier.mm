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
@synthesize decision_needed;
@synthesize move;
@synthesize moving;
@synthesize isUnderRecoil;
@synthesize isOutofAmmo;
@synthesize delegate;
//apply movement joystick
//apply shooting joystick
-(void) applyMovementJoystick:(SneakyJoystick*)aJoysick forTimeDelta:(float) deltaTime
{
    //CCLOG(@"Applying joystick!");
    velocity.x = aJoysick.velocity.x *kJoystick_velocity_scale;
    velocity.y = aJoysick.velocity.y *kJoystick_velocity_scale;
    //CCLOG(@"Setting velocity: x: %f y:%f", velocity.x, velocity.y);
    //CGPoint scaledVelocity;
    //scaledVelocity.x = aJoysick.velocity.x *velocity.x;
    //scaledVelocity.y = aJoysick.velocity.y * velocity.y;
    //scaledVelocity.x = ccpMult(aJoysick.velocity.x, velocity.x); 
    body->SetLinearVelocity(velocity);
    //this needs to be updated to be handled by the physics engine
   // CGPoint oldPosition = [self position];
    //CGPoint newPosition = ccp(oldPosition.x +scaledVelocity.x *deltaTime, oldPosition.y+ scaledVelocity.y * deltaTime);
   // [self setPosition:newPosition];
    

}
-(void) handleShootingJoystick
{
    
}
-(void) setRotationByShooting
{
    float rotation_factor;
    // CCLOG(@"%f", aJoysick.degrees);
    if((right_Joystick.degrees <360) && (right_Joystick.degrees >90))
    {
        rotation_factor = 450;
        rotation_factor = rotation_factor -  right_Joystick.degrees ;
        
    }
    if ((right_Joystick.degrees > 0) && (right_Joystick.degrees < 90))
    {
        rotation_factor = 90;
        rotation_factor = rotation_factor - right_Joystick.degrees;
    }
    float rotation_factor1 = (PI / 180) *rotation_factor;
    //CCLOG(@"Rotation factor: %f", rotation_factor1);
    const b2Vec2 position = body->GetPosition();
    body->SetTransform(position, rotation_factor1);
   // [self setRotation:rotation_factor ];
}
-(void) setRotationByMovement
{
    float rotation_factor;
    // CCLOG(@"%f", aJoysick.degrees);
    if((left_Joystick.degrees <360) && (left_Joystick.degrees >90))
    {
        rotation_factor = 450;
        rotation_factor = rotation_factor -  left_Joystick.degrees ;
        
    }
    if ((left_Joystick.degrees > 0) && (left_Joystick.degrees < 90))
    {
        rotation_factor = 90;
        rotation_factor = rotation_factor - left_Joystick.degrees;
    }
    float rotation_factor1 = (PI / 180) *rotation_factor;
   // CCLOG(@"Rotation factor: %f", rotation_factor1);
    const b2Vec2 position = body->GetPosition();
    body->SetTransform(position, rotation_factor1);
    
  //  [self setRotation:rotation_factor ];
}
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
   // CCLOG(@"Updating soldier!");
   //check if dead
    if(self.characterState == kStateDead)
    {
        if(isPlayerControlled)
        {
            //game over
        }
        else
        {
            return;
        }
    }
    //[self applyMovementJoystick:left_Joystick forTimeDelta:deltaTime];
    //Check collisions? (at this point, no, will be done in physics sim update)
    
    //check if AI decision tree should run (should be set to YES, when under attack, or enemies are sighted, etc in physics sim)
    if(isPlayerControlled)
    {
        //stop AI from kicking in
        self.decision_needed = false;
        self.move = false;
        [self handleShootingJoystick];
        if((left_Joystick.velocity.x != 0) || (left_Joystick.velocity.y != 0)){
           // CCLOG(@"PLayer should move");
            self.moving = TRUE; 
        }
    }
    if(decision_needed)
    {
        //decision tree here
    }
    
    //check message vars
    if(fireIfAble)
    {
        if(isOutofAmmo || isUnderRecoil)
        {
            self.canShoot = false; 
        }
        if(canShoot)
        {
            if(isPlayerControlled)
            {
                [self setRotationByShooting];
                
            }
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
    if(fireIfAble)
    {
        //if moving, need to determine what type of movement
        if(moving)
        {
            if(isProne || isCrouched)
            {
                if(isProne)
                {
                    //can't shoot and move while prone (stop movement)
                    self.moving = FALSE;
                    velocity.x = 0.0f;//may need to be pointer!!
                    velocity.y = 0.0f;
                    //[self setRotationByShooting];
                    
                }
                if(isCrouched)
                {
                    //is crouched (can't move while crouched and shooting)
                    self.moving = FALSE;
                    velocity.x = 0.0f;//may need to be pointer!!
                    velocity.y = 0.0f;
                    //[self setRotationByShooting];
                }
            }
            else if(isRunning)
            {
                                //is running and gunning standing up
            }
            else
            {
                //is Walking and firing standing up
            }
        }
        else
        {
            //not moving
        }
    }
    else if (moving)
    {
      if(isRunning)
      {
          //set running anim if needed
      }
      else
      {
          //isWalking
      }
    }
    else if (isCrouched)
    {
        
    }
    else if (isProne)
    {
        
    }
    else
    {
        
    }
    //position updates will be handled by BOX2D, ai and player initiated movement is handled by velocity adjustments
    if(moving && isPlayerControlled)
    {
        //CCLOG(@"Appying Joystick!");
        [self applyMovementJoystick:left_Joystick forTimeDelta:deltaTime];
        if(!fireIfAble) 
        {
            //CCLOG(@"Setting rotation via left joystick!");
            [self setRotationByMovement];
            
        }
    }
    
    
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
        isCrawling = FALSE;
        isProne = FALSE;
        isCrouched = FALSE;
        moving = FALSE;
        move = FALSE;
        isPlayerControlled = FALSE;
        isRunning = FALSE;
        canShoot = TRUE;
        isOutofAmmo = FALSE;
        decision_needed = TRUE;
        fireIfAble =FALSE;
        [self initAnimations];
        //need to set default values
        //need to create dealloc method to cleanup
        
    }
    return self;
    
}
@end
