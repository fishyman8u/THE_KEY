//
//  AFC.m
//  The_KEY
//
//  Created by Nathan Jones on 10/8/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "AFC.h"

@implementation AFC


- (void) dealloc
{
    [super dealloc];
}
- (int) getWeaponDamage
{
    if(weapon == kWeapon_p90)
    {
        return kP90_Weapon_Damage;
    }
    if(weapon == kWeapon_Laser)
    {
        return kLaser_Weapon_Damage;
    }
    CCLOG(@"Undefined Weapon Type");
    return 0;
}


-(CGRect) adjustedBoundingBox
{
    CGRect placeholder = [self boundingBox];
    
    
    return placeholder;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.gameObjectType = kAFC;
        [self setHealth:100];
        //angle_adjustment = 0;
        //self.flipY = YES;
        //self.flipX = YES;
    }
    
    return self;
}

@end
