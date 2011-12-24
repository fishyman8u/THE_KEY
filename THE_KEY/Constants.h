//
//  Constants.h
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#ifndef The_KEY_Constants_h
#define The_KEY_Constants_h
#define kAFC_Player_Z_Value 100
#define kAFC_Player_TagValue 0
#define kWorldNodeTag 1
#define kAFC_Player_idle_timer 3.0f
//#define kVikingFistDamage 10
//#define kVikingHammerDamage 40
//#define kRadarDishTagValue 10
#define kP90_Weapon_Damage 30
#define kLaser_Weapon_Damage 15
#define kBulletSpeed 100
#define kBulletTimeToLive 10
#define kDefaultFireRate 1
#define PI 3.14159
#define RadianConvert PI / 180
#define DegreeConvert 180 / PI
#define PTM_RATIO 32.0
//Damage will need to be defined some other way, plist?
typedef struct {
    float degree, factor;
}angle_table;

    


#endif
