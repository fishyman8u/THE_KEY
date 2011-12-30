//
//  bullet.m
//  The_KEY
//
//  Created by Nathan Jones on 10/9/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "bullet.h"

@implementation bullet

@synthesize travellingAnim;
@synthesize firingAnim;

@synthesize live_time;
//@synthesize owner_tag;
-(void) dealloc
{
    [travellingAnim release];
    [firingAnim release];
    [super dealloc];
}
-(void)changeState:(CharacterStates)newState
{
    [self stopAllActions];
    id action = nil;
    characterState = newState;
    switch (newState) {
        case kStateSpawning:
            CCLOG(@"Bullet state changed to spawning");
            action = [CCAnimate actionWithAnimation:firingAnim restoreOriginalFrame:NO];
            break;
        case kStateTravelling:
            CCLOG(@"Bullet state changed to travelling");
            action = [CCRepeatForever actionWithAction:[ CCAnimate actionWithAnimation:travellingAnim restoreOriginalFrame:NO]];
           
            break;
        case kStateDead:
            CCLOG(@"Bullet state changed to dead");
            [self setVisible:NO];
            [self removeFromParentAndCleanup:YES];
            break;
        default:
            CCLOG(@"Bullet unhandled state");
            break;
    }
}

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListofGameObjects:(CCArray *)listOfGameObjects
{
    self.live_time = self.live_time + deltaTime;
   // CCLOG(@"Live time: %f", self.live_time);
   // CCLOG(@"Bullet Speed x: %f y:%f", self.xVelocity, self.yVelocity); 
        
      // CGPoint oldPosition = self.position;
   // CGPoint newPosition = ccp(oldPosition.x + velocity * deltaTime, oldPosition.y +yVelocity *deltaTime);
   // [self setPosition:newPosition];
    
    if([self numberOfRunningActions] == 0)
    {
      //  CCLOG(@"Actions for bullet equal 0.");
        if(characterState == kStateSpawning)
        {
            [self changeState:kStateTravelling];
            return;
        }
       /* else
        {
            CCLOG(@"Number of actions == 0, killing bullet");
            [self changeState:kStateDead];
            return;
        }*/
    }
    if(live_time >= kBulletTimeToLive)
    {
        CCLOG(@"Bullet timed out. Killing");
        [self changeState:kStateDead];
        return;
    }

    
}
-(CGRect) adjustedBoundingBox
{
    return self.boundingBox;
}
-(void) initAnimations
{
    CCLOG(@"initalizing anims!");
    [self setFiringAnim:[self loadPlistForAnimationWithName:@"firing_anim" andClassName:NSStringFromClass([self class])]];
     [self setTravellingAnim:[self loadPlistForAnimationWithName:@"travelling_anim" andClassName:NSStringFromClass([self class])]];
    
}
- (id)init
{
    self = [super init];
    if (self) {
        [self initAnimations];
        gameObjectType = kBullet;
        //[self createBodyAtLocation:self.position withDensity:3.0f withRestitution:0.2f withFriction:1.0f];
    }
    
    return self;
}
-(void) setRotationTransform:(float)rotation andPosition:(b2Vec2)pos
{
    body->SetTransform(pos, rotation);
}
@end
