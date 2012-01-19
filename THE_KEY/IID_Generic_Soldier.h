//
//  IID_Generic_Soldier.h
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "IID_Game_Character.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "Constants.h"
#import "CommonProtocols.h"
#import "cocos2d.h"

@interface IID_Generic_Soldier : IID_Game_Character
{
    //UI
    SneakyJoystick *left_Joystick;//
    SneakyJoystick *right_Joystick;//
    
    SneakyButton *crouch;//
    SneakyButton *prone;//
    SneakyButton *cover;//
    
    //BOOLs
    BOOL canShoot;//set to block firing when crawling, reloading, etc
    BOOL isHit;
    BOOL isUnderAttack;//used by decision tree, set in physics update
    BOOL enemySighted;//used by decision tree, set in physics update
    BOOL decision_needed;//used by decision tree, set in physics update
    BOOL moving;
    BOOL isCrawling;
    BOOL isProne;
    BOOL isCrouched;
    BOOL isAgainstWall;
    BOOL isBehindCover;
    BOOL isRunning;
    BOOL isOutofAmmo;
    BOOL isUnderRecoil;
    BOOL firing;
    //Enums
    WeaponType weapon;//
    
    //Standard Soldier Anims
    CCAnimation *standing;//
    CCAnimation *Standing_to_crouching;//
    CCAnimation *crouching;
    CCAnimation *crouching_to_standing;//
    CCAnimation *crouching_to_prone;//
    CCAnimation *prone_to_crouching;//
    CCAnimation *prone_anim;
    CCAnimation *crawling;
    CCAnimation *dive_to_prone;
    CCAnimation *cover_behind_wall;
    CCAnimation *leave_wall;
    CCAnimation *walking;//
    CCAnimation *running;
    CCAnimation *firing_running;
    CCAnimation *firing_walking;
    CCAnimation *firing_standing;
    CCAnimation *firing_crouched;
    CCAnimation *firing_prone;
    CCAnimation *lean_from_wall_and_fire;
    CCAnimation *fire_over_low_wall;
    CCAnimation *get_hit;
    CCAnimation *dying;//could do mulitple versions...
    CCAnimation *wounded;
    
    //message vars
    NSMutableArray *path; //used for recieving paths after a pathfinding request
    float targeting_rotation; //used for recieving a target angle from a targeting request
    BOOL pathLoops; //used for determining where the path is a looping path (for a patrol)
    BOOL fireIfAble;
    BOOL move;
    BOOL enemySpotted;
    CGPoint currentDestination;
    NSMutableArray *enemies_sighted;
    
    //physics variables
   // b2Vec2 *velocity;
    ccTime timeSinceLastShot;
    ccTime button_lock;
    ccTime left_overtime;
    int step;
    //Scrolling Var
    CGPoint old_pos;
    
    BOOL prone_but;
    BOOL crouch_but;
    
    //Sight distance
  //  float sight_distance;
}
@property(nonatomic, retain) CCAnimation *standing;
@property(nonatomic, retain) CCAnimation *Standing_to_crouching;
@property(nonatomic, retain) CCAnimation *crouching;
@property(nonatomic, retain) CCAnimation *crouching_to_standing;
@property(nonatomic, retain) CCAnimation *crouching_to_prone;
@property(nonatomic, retain) CCAnimation *prone_to_crouching;
@property(nonatomic, retain) CCAnimation *prone_anim;
@property(nonatomic, retain) CCAnimation *crawling;
@property(nonatomic, retain) CCAnimation *dive_to_prone;
@property(nonatomic, retain) CCAnimation *cover_behind_wall;
@property(nonatomic, retain) CCAnimation *leave_wall;
@property(nonatomic, retain) CCAnimation *walking;
@property(nonatomic, retain) CCAnimation *running;
@property(nonatomic, retain) CCAnimation *firing_running;
@property(nonatomic, retain) CCAnimation *firing_walking;
@property(nonatomic, retain) CCAnimation *firing_crouched;
@property(nonatomic, retain) CCAnimation *firing_prone;
@property(nonatomic, retain) CCAnimation *lean_from_wall_and_fire;
@property(nonatomic, retain) CCAnimation *fire_over_low_wall;
@property(nonatomic, retain) CCAnimation *get_hit;
@property(nonatomic, retain) CCAnimation *dying;
@property(nonatomic, retain) CCAnimation *wounded;

@property(nonatomic, retain) SneakyButton *crouch;
@property(nonatomic, retain) SneakyButton *prone;
@property(nonatomic, retain) SneakyButton *cover;
@property(nonatomic, retain) SneakyJoystick *left_Joystick;
@property(nonatomic, retain) SneakyJoystick *right_Joystick;

@property(nonatomic, readwrite) BOOL canShoot;
@property(nonatomic, readwrite) BOOL decision_needed;
@property(nonatomic, readwrite) BOOL move;
@property(nonatomic, readwrite) BOOL moving;
@property(nonatomic, readwrite) BOOL isOutofAmmo;
@property(nonatomic, readwrite) BOOL isUnderRecoil;
@property(nonatomic, readwrite) WeaponType weapon;
@property(nonatomic, readwrite) CGPoint old_pos;
//@property(nonatomic, readwrite) b2Vec2 
@property(nonatomic, readwrite) BOOL isProne;
@property(nonatomic, readwrite) BOOL isCrouched;
@property(nonatomic, readwrite) BOOL isRunning;
@property(nonatomic, readwrite) ccTime timeSinceLastShot;
@property(nonatomic, readwrite) BOOL firing;
@property(nonatomic, readwrite) BOOL fireIfAble;
@property(nonatomic, readwrite) NSMutableArray *enemies_sighted;
@end
