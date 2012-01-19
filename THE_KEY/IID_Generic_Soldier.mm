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
@synthesize old_pos;
@synthesize isProne;
@synthesize isCrouched;
@synthesize isRunning;
@synthesize timeSinceLastShot;
@synthesize firing;
@synthesize fireIfAble;
@synthesize enemies_sighted;
//apply movement joystick
//apply shooting joystick

bool isBodyCollidingWithObjectType(b2Body *body, GameObjectType objectType)
{
    
    b2ContactEdge *edge = body->GetContactList();
    while(edge)
    {
        
        b2Contact *contact = edge->contact;
        
        if(contact->IsTouching())
        {
            CCLOG(@"testing for collision!");
            b2Fixture *fixtureA = contact->GetFixtureA();
            b2Fixture *fixtureB = contact->GetFixtureB();
            b2Body *bodyA = fixtureA->GetBody();
            b2Body *bodyB = fixtureB->GetBody();
            IID_Game_Character * spriteA = (IID_Game_Character *) bodyA->GetUserData();
            IID_Game_Character * spriteB = (IID_Game_Character *) bodyB->GetUserData();
            if ((spriteA != NULL && 
                 spriteA.gameObjectType == objectType) ||
                (spriteB != NULL && 
                 spriteB.gameObjectType == objectType)) {
                    if(spriteA.gameObjectType == kBullet)
                    {
                        [spriteA changeState:kStateDead];
                    }
                    if(spriteB.gameObjectType == kBullet)
                    {
                        [spriteB changeState:kStateDead];
                    }
                       
                    
                    return true;
                }
            
        }
        edge = edge->next;
    }
    return false;
}
-(void) updateAIControlled:(ccTime)deltaTime andListOfGameObjects:(CCArray *)gameObjects
{
    //check if hit (and thus under attack)
    isHit = isBodyCollidingWithObjectType(body, kBullet);
   // enemySighted = 
    if(isHit)
    {
        if(!isUnderAttack){
        isUnderAttack = YES;
        decision_needed = YES;
        }
        self.Health = self.Health - 10.0f;
        //play hit anim
        //play hit sound
        if(self.Health <= 0.0f)
        {
            [self changeState:kStateDead];
            return;
        }
    }
    if(!move)
    {
        decision_needed = YES;
    }
    if(move && !isUnderAttack && !enemySighted)
    {
        decision_needed = NO; //just continue moving
    }
    
    
    if(decision_needed)
    {
        if(isUnderAttack || enemySighted)
        {
            //find attacker(s)
            int enemy_count = 0;
            for (IID_Game_Character *character in gameObjects)
            {
                //develop a calculation comparing position differences to sight distance, filter for team
                //also check for allied units/formation/etc
                
            }
            
            ////check for open squares with cover in a given range
            
            //check relative strength and decide whether to move to cover and return fire or run away
            //IDEA, have a process that develops and array of numbers that records relative strength known for each team, divide it up so it only does a small part of the calc each frame, and fully runs every 10sec or so (maybe use a buffer like system that swaps??); also could do something similar for cover (have integer array constructed at map load)
            
        /////^^units could then update based on the persistent array info 
            
        //select a destination and set the unit to move, call the pathfinder method to fill a waypoints array
        }
        //if no threat then a behavior needs to be selected, maybe using the help of the relative strength array and an AI commander that sets priorities based on a map variable that selects the AI strategy, or calculates it based on goals and relative strength map. Maybe map "triggers" could be used to adjust AI strategy.
        
      //determine a behavoir 
        //autonomous behavoirs:
            //patrol
            //wander
            //guard
            //hunt
            //flee
            //hide
       //coordinated behavoirs
            //attack
            //defend
            //protect/guard
            //ambush
            //patrol
            //retreat
        //main decision tree
    }
    
    
    
    
    
}
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
-(void) handleShootingJoystick:(ccTime)deltaTime
{
    
    //[self setRotationByShooting];
     self.firing = YES; //used to override movement rotation
    ccTime fireRate = 1.0f;
    if(timeSinceLastShot > fireRate)
    {
        canShoot = YES;
        //CCLOG(@"Can fire!");
    }
    else
    {
        canShoot = NO;
    }
    if(canShoot){
        if((right_Joystick.velocity.x != 0) || (right_Joystick.velocity.y != 0))
        {
            
          
            CCLOG(@"Rotation: %f", self.rotation); 
                float X_factor = sinf(self.rotation * RadianConvert);
            CCLOG(@"X_factor = %f", X_factor);
            
                float Y_factor = cosf(self.rotation * RadianConvert);
             CCLOG(@"Y_factor = %f", Y_factor);
                float x_plus = X_factor * 50.0f;
                float y_plus = Y_factor * 50.0f;
                CGPoint pos = ccp(self.position.x + x_plus, self.position.y + y_plus);
                CCLOG(@"Creating bullet with rotation: %f!", self.rotation);
                
            [delegate createObjectOfType:kBullet withHealth:1.0f atLocation:pos withZValue:1000 andTag:15 andRotation:self.rotation andTeam:1];
        //create bullet here
        timeSinceLastShot = 0.0f;
            
        }
    }
   
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
-(void) updatePlayerControlled:(ccTime)deltaTime
{
    step = step + 1;
    velocity.x = 0.0f;
    velocity.y = 0.0f;
    button_lock = button_lock + deltaTime;
    timeSinceLastShot = deltaTime + timeSinceLastShot;
    if((right_Joystick.velocity.x != 0) || (right_Joystick.velocity.y != 0))
    {
        [self setRotationByShooting];
       // [self handleShootingJoystick:deltaTime];
        
    }
    else
    {
         if((left_Joystick.velocity.x != 0) || (left_Joystick.velocity.y != 0))
        [self setRotationByMovement];
    }
    if((left_Joystick.velocity.x != 0) || (left_Joystick.velocity.y != 0))
    {
    [self applyMovementJoystick:left_Joystick forTimeDelta:deltaTime];
        self.moving =YES;
    }
    else
    {
        velocity.x = 0.0f;
        velocity.y = 0.0f;
        body->SetLinearVelocity(velocity);
        self.moving = NO;
    }
    //////////////////////////
    if(prone.active)
    {
            if(!prone_but)
            {
                prone_but = TRUE;
                if(!isProne)
                {
                [self changeState:kStateProne];
                isProne = YES;
                isCrouched = NO;
                    
                    
                }
                else
                {
                    [self changeState:kStateStanding];
                    isProne = NO;
                    isCrouched = NO;
                }
                
            }
    }
    else if(! prone.active)
    {
        if(prone_but)
        {
            prone_but = FALSE;
        }
    }
    
    if(crouch.active)
    {
        if(!crouch_but)
        {
            crouch_but = TRUE;
            if(!isCrouched)
            {
                [self changeState:kStateCrouching];
                isProne = NO;
                isCrouched = YES;
                
            }
            else
            {
                [self changeState:kStateStanding];
                isCrouched = NO;
                isProne = NO;
            }
        }
    }
    else if(!crouch.active)
    {
        if(crouch_but)
        {
            crouch_but = FALSE;
        }
    }
        
    //////////////////////////
    
    if(isCrouched)
    {
        velocity.x = 0.0f;
        velocity.y = 0.0f;
        body->SetLinearVelocity(velocity);
        self.moving = NO;
    }
    //////////////////////////
    
    if(isCrawling || isRunning)
    {
        self.canShoot = NO;
    }
    else
    {
        self.canShoot = YES;
        [self handleShootingJoystick:deltaTime];
    }
    ///////////////////////
    
    if(moving)
    {
        if(!isProne && !isCrouched)
        {
            if([self numberOfRunningActions] == 0){
            CCLOG(@"Changing state to Walking!");
                [self changeState:kStateWalking];}
        }
        //change to running state here as well
    }
    else
    {
        if(!isProne && !isCrouched)
        {
            if(self.characterState != kStateStanding){
            CCLOG(@"Changing state to Standing!");
            [self changeState:kStateStanding];
            }
        }

        
    }
}
-(void) initAnimations
{
    [self setWalking:[self loadPlistForAnimationWithName:@"Walking_Anim" andClassName:NSStringFromClass([self class])]];
    [self setStanding:[self loadPlistForAnimationWithName:@"Standing_Anim" andClassName:NSStringFromClass([self class])]];
    [self setStanding_to_crouching:[self loadPlistForAnimationWithName:@"Crouching_Anim" andClassName:NSStringFromClass([self class])]];
    [self setCrouching_to_prone:[self loadPlistForAnimationWithName:@"Prone_Anim" andClassName:NSStringFromClass([self class])]];
    [self setCrouching_to_standing:[self loadPlistForAnimationWithName:@"Crouching_to_Standing" andClassName:NSStringFromClass([self class])]];
    [self setProne_to_crouching:[self loadPlistForAnimationWithName:@"Prone_to_Standing" andClassName:NSStringFromClass([self class])]];
    
   // [self setCrouching_to_prone:[self loadPlistForAnimationWithName:@ andClassName:<#(NSString *)#>
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
            if([self numberOfRunningActions] == 0)
            {
                self.visible =NO;
                [self removeFromParentAndCleanup:YES];
            }
            return;
        }
    }
    
    body->SetAngularVelocity(0.0f);
    if(isPlayerControlled)
    [self updatePlayerControlled:deltaTime];
    else
    {
        [self updateAIControlled:deltaTime andListOfGameObjects:listOfGameObjects];
    }
    //[self applyMovementJoystick:left_Joystick forTimeDelta:deltaTime];
    //Check collisions? (at this point, no, will be done in physics sim update)
    
    //check if AI decision tree should run (should be set to YES, when under attack, or enemies are sighted, etc in physics sim)
    /*if(isPlayerControlled)
    {
        //stop AI from kicking in
        self.decision_needed = false;
        self.move = false;
        if((right_Joystick.velocity.x != 0) || (right_Joystick.velocity.y != 0)){
            [self handleShootingJoystick:deltaTime];
            self.fireIfAble = YES;
            
        }
        else
        {
            self.firing = NO;
            self.fireIfAble = NO;
        }
        [self handleShootingJoystick:deltaTime];
        if((left_Joystick.velocity.x != 0) || (left_Joystick.velocity.y != 0)){
           // CCLOG(@"PLayer should move");
            self.moving = TRUE; 
        }
        else
        {
            velocity.x = 0.0f;
            velocity.y = 0.0f;
            self.moving = NO;
        }
    }
    if(decision_needed)
    {
        //decision tree here
    }
    
    //check message vars
    if(fireIfAble || !isPlayerControlled)
    {
        if(isOutofAmmo || isUnderRecoil)
        {
            self.canShoot = false; 
        }
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
    if(move || !isPlayerControlled)
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
                    [self setRotationByShooting];
                    
                }
                if(isCrouched)
                {
                    //is crouched (can't move while crouched and shooting)
                    self.moving = FALSE;
                    velocity.x = 0.0f;//may need to be pointer!!
                    velocity.y = 0.0f;
                    [self setRotationByShooting];
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
       else if (isCrouched)
      {
        self.moving = false;
        [self changeState:kStateCrouching];
        
      }
        else if (isProne)
        {
         [self changeState:kStateCrawling];
        }
      else
      {
          [self changeState:kStateWalking];
      }
    }
    else if (isCrouched)
    {
        [self changeState:kStateCrouching];
    }
    else if (isProne)
    {
        [self changeState:kStateProne];
    }
    else
    {
       velocity.x = 0;
        velocity.y = 0;
        [self changeState:kStateStanding];
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
    
    */
}

-(void) changeState:(CharacterStates)newState
{
    
    [self stopAllActions];
    id action = nil;
   // id movementAction = nil;
    self.characterState = newState;
   // [self changeState:newState];
    switch(newState){
        case kStateWalking:
            if(isCrouched)
            {
                action = [CCSequence actions:[CCAnimate actionWithAnimation: crouching_to_standing restoreOriginalFrame:NO ], [CCAnimate actionWithAnimation:walking restoreOriginalFrame:NO], nil];
                self.isCrouched = NO;
            }
            else if(isProne)
            {
                 action = [CCSequence actions:[CCAnimate actionWithAnimation:prone_to_crouching restoreOriginalFrame:NO],[CCAnimate actionWithAnimation: crouching_to_standing restoreOriginalFrame:NO ], [CCAnimate actionWithAnimation:walking restoreOriginalFrame:NO], nil];
                self.isProne = NO;
            }
            else
            {
                action = [CCAnimate actionWithAnimation:walking restoreOriginalFrame:NO];
                self.isRunning = NO;
            }
            break;
        case kStateRunning:
            if(isCrouched)
            {
                action = [CCSequence actions:[CCAnimate actionWithAnimation: crouching_to_standing restoreOriginalFrame:NO ], [CCAnimate actionWithAnimation:running restoreOriginalFrame:NO], nil];
                self.isCrouched = NO;
            }
            else if(isProne)
            {
                action = [CCSequence actions:[CCAnimate actionWithAnimation:prone_to_crouching restoreOriginalFrame:NO],[CCAnimate actionWithAnimation: crouching_to_standing restoreOriginalFrame:NO ], [CCAnimate actionWithAnimation:running restoreOriginalFrame:NO], nil];
                self.isProne = NO;
            }
            else
            {
                action = [CCAnimate actionWithAnimation:running restoreOriginalFrame:NO];
                self.isRunning = YES;
            }

            break;
        case kStateStanding:
            if(isCrouched)
            {
                action = [CCSequence actions:[CCAnimate actionWithAnimation: crouching_to_standing restoreOriginalFrame:NO ], [CCAnimate actionWithAnimation:standing restoreOriginalFrame:NO], nil];
            }
            else if(isProne)
            {
                action = [CCSequence actions:[CCAnimate actionWithAnimation:prone_to_crouching restoreOriginalFrame:NO],[CCAnimate actionWithAnimation: crouching_to_standing restoreOriginalFrame:NO ], [CCAnimate actionWithAnimation:standing restoreOriginalFrame:NO], nil];
            }
            else
            {
                action = [CCAnimate actionWithAnimation:standing restoreOriginalFrame:NO];
            }

            break;
        case kStateProne:
            if(isCrouched)
            {
                action = [CCAnimate actionWithAnimation:crouching_to_prone restoreOriginalFrame:NO];
                self.isCrouched = NO;
                self.isProne = YES;
            }
            else if(isProne)
            {
                
               // action = [CCAnimate actionWithAnimation:prone_anim restoreOriginalFrame:NO];
                self.isCrouched = NO;
                self.isProne = YES;
            }
            else
            {
                action = [CCSequence actions:[CCAnimate actionWithAnimation:Standing_to_crouching restoreOriginalFrame:NO], [CCAnimate actionWithAnimation:crouching_to_prone restoreOriginalFrame:NO], nil];
                self.isCrouched = NO;
                self.isProne = YES;
            }
            
            break;
        case kStateCrouching:
            if(isCrouched)
            {
               // action = [CCAnimate actionWithAnimation:crouching restoreOriginalFrame:NO];
               // self.isCrouched = YES;
               // self.isProne = NO;
            }
            else if(isProne)
            {
                action = [CCAnimate actionWithAnimation:prone_to_crouching restoreOriginalFrame:NO];
             //   self.isCrouched = YES;
             //   self.isProne = NO;
            }
            else
            {
                action = [CCAnimate actionWithAnimation:Standing_to_crouching restoreOriginalFrame:NO];
              //  self.isCrouched = YES;
             //   self.isProne = NO;          
            }
            break;
        case kStateSpawning:
            action = [CCAnimate actionWithAnimation:standing restoreOriginalFrame:NO];
        case kStateDead:
            
            CCLOG(@"Need death anim!");
            
            break;
        default:
            CCLOG(@"State not found!");
            break;
            
    }
    if(action != nil)
    {
        [self runAction:action];
    }
    
}
-(id) init
{
    self = [super init];
    if(self)
    {
        characterState = kStateSpawning;
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
        self.old_pos = self.position;
        timeSinceLastShot = 0.0f;
        left_overtime = 0.0f;
        button_lock = 0.0f;
        enemies_sighted = [[CCArray alloc] initWithCapacity:20];
      //  sight_distance = 100.0f;
        //need to set default values
        //need to create dealloc method to cleanup
        
    }
    return self;
    
}
@end
