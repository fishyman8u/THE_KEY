//
//  IID_Control_Layer.h
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"

@interface IID_Control_Layer : CCLayer
{
    //shooting and movement joystick interface
    SneakyJoystick * leftJoystick;
    SneakyJoystick * rightJoystick;
    
    //button interface
    SneakyButton * crouchButton;
    SneakyButton * proneButton;
    SneakyButton * menuButton;
    SneakyButton * coverButton;
    SneakyButton * pauseButton;
    
    //Information HUD
    //health display
    //objectives
    //minimap?
    //ammo and weapons
}
@property (nonatomic, readonly) SneakyJoystick * leftJoystick;
@property (nonatomic, readonly) SneakyJoystick * rightJoystick;
@property (nonatomic, readonly) SneakyButton * crouchButton;
@property (nonatomic, readonly) SneakyButton * proneButton;

@end
