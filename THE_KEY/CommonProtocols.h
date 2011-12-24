//
//  CommonProtocols.h
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//
#include "Box2D.h"
//#import "IID_Game_Character.h"
#ifndef The_KEY_CommonProtocols_h
#define The_KEY_CommonProtocols_h
#define kMainMenuTagValue 10
#define kSceneMenuTagValue 20
typedef enum {
    kNoSceneUninitialized = 0,
    kMainMenuScene =1,
    kOptionsScene = 2,
    kCreditsScene = 3,
    kIntroScene = 4,
    kLevelCompleteScene = 5,
    kGameLevel1 = 101,
    kGameLevel2 = 102,
    kBoxTest = 103
    //other Levels
    
}SceneTypes;
typedef enum{
   kLinkTypeBookSite,
    kLinkTypeDeveloperSite,
    kLinkDesignerSite
}LinkTypes;
#define ENEMY_STATE_DEBUG 0
typedef enum{
    kStateStanding,
    kStateWalking,
    kStateCrouching,
    kStateProne,
    kStateDying,
    kStateAttacked,
    kStateFiring,
    kStateDead,
    kStateTakingDamage,
    kStateStandingUp,
    kStateProneToCrouch,
    kStateCrouchToStanding,
    kStateProneToStanding,
    kStateRunning,
    kStateSpawning,
    kStateTravelling,
    kStateNone    
}CharacterStates;

typedef enum {
    
    kStateMovingto,
    kStateDefending,
    kStateAttacking,
    kStateRetreating,
    kStateWaiting,
    kStateRotating,
    kStatePatrolling,
    kStateSeekCover

}AI_States;

typedef enum {
    kStateDefendPosition,
    kStateAttackPosition,
    kStateAmbushing,
    kStateWithdrawal
    //put other tactics here
}Squad_AI_States;

typedef enum {
    kStateAnalyzingEnemyStrategy,
    kStateDefensiveStrategy,
    KStateAggressiveStrategy
    //put in strategy states here
}Command_AI_States;




typedef enum {
    kAFC,
    kBullet,
    kDauntless,
    kHellfire,
    kDusanFighter,
    kDusanSoldier,
    kGadiSoldier,
    kGadiFighter,
    kStatic3d,
    kObjectTypeNone
}GameObjectType;

typedef enum {
    kWeapon_p90,
    kWeapon_Laser
}WeaponType;

typedef enum{
    kFullCoverFront,
    kHalfCoverFront,
    kFullCoverRight,
    kHalfCoverRight,
    kFullCoverLeft,
    kHalfCoverLeft,
    kFullCoverBack,
    kHalfCoverBack,
    kNoCover
    
}CoverState;
typedef enum{
    kNeutral,
    kUSAF,
    kGadi,
    kDusan,
    kTeam1,
    kTeam2,
    kTeam3,
    kTeam4
}TeamStates;
typedef struct {
    int tag;
    TeamStates team;
    
}ai_target_info;

@protocol GameplayLayerDelegate 

-(void) createObjectOfType:(GameObjectType)objectType 
withHealth:(int) initialHealth
atLocation:(CGPoint)spawnLocation
                                    withZValue:(int)Zvalue
andTag:(int)tag;
/*
-(void) createBodyAtLocation:(CGPoint)location 
forSprite:(IID_Game_Character *)sprite friction:(float32)friction      
restitution:(float32)restitution density:(float32)density 
isBox:(BOOL)isBox;
//-(void)createBulletWithRotation:(float)rotation
                 //   andVelocity:(float)velocity
                 //   andPosition:(CGPoint) spawnPosition
                 //        andtag:(int) tag1;
*/
-(b2World *) getRefToWorld;

@end

#endif
