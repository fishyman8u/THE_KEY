//
//  IID_Control_Layer.m
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "IID_Control_Layer.h"

@implementation IID_Control_Layer
@synthesize crouchButton;
@synthesize proneButton;
@synthesize rightJoystick;
@synthesize leftJoystick;
-(void) initJoystickAndButtons
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CGRect joystickBaseDimensions = CGRectMake(0, 0, 128.0f, 128.0f);
    CGRect crouchButtonDimensions = CGRectMake(0, 0, 64.0f, 64.0f);
    CGPoint right_joystick_base_position;
    CGPoint left_joystick_base_position;
    CGPoint crouch_button_position;
    CGPoint prone_button_position;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CCLOG(@"Positioning Joystick and Buttons for ipad");
        left_joystick_base_position = ccp(screenSize.width * 0.152f, screenSize.height * 0.152f);
        right_joystick_base_position = ccp(screenSize.width * 0.851f, screenSize.height *0.152f);
        crouch_button_position = ccp(screenSize.width * 0.85f, screenSize.height * 0.052f);
        prone_button_position = ccp(screenSize.width * 0.60f, screenSize.height * 0.052f);
        
    }else
    {
        CCLOG(@"Positioning Joystick and Buttons for iphone");
        left_joystick_base_position = ccp(screenSize.width * 0.07f, screenSize.height * 0.11f);
        right_joystick_base_position = ccp(screenSize.width * 0.93f, screenSize.height *0.11f);
        crouch_button_position = ccp(screenSize.width * 0.85f, screenSize.height * 0.11f);
        prone_button_position = ccp(screenSize.width * 0.60f, screenSize.height * 0.011f);
    }
    //right joystick
    SneakyJoystickSkinnedBase *r_joystick_base = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    r_joystick_base.position = right_joystick_base_position;
    r_joystick_base.backgroundSprite = [CCSprite spriteWithFile:@"Joystick_base-01.png"];
    r_joystick_base.thumbSprite = [CCSprite spriteWithFile:@"Joystick_Cross_Hairs-01.png"];
    r_joystick_base.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    rightJoystick = [r_joystick_base.joystick retain];
    [self addChild:r_joystick_base];
    //left joystick
    SneakyJoystickSkinnedBase *l_joystick_base = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    l_joystick_base.position = left_joystick_base_position;
    l_joystick_base.backgroundSprite = [CCSprite spriteWithFile:@"Joystick_base-01.png"];
    l_joystick_base.thumbSprite = [CCSprite spriteWithFile:@"Joystick_Cross_Hairs-01.png"];
    l_joystick_base.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    leftJoystick = [l_joystick_base.joystick retain];
    [self addChild:l_joystick_base];
    //sneaky button
    SneakyButtonSkinnedBase *crouch_button_base = [[[SneakyButtonSkinnedBase alloc]init]autorelease];
    crouch_button_base.position = crouch_button_position;
    crouch_button_base.defaultSprite = [CCSprite spriteWithFile:@"button_base-01.png"];
    crouch_button_base.activatedSprite = [CCSprite spriteWithFile:@"Button_Pressed-01.png"];
    crouch_button_base.pressSprite = [CCSprite spriteWithFile:@"Button_Pressed-01.png"];
    crouch_button_base.button = [[SneakyButton alloc] initWithRect:crouchButtonDimensions];
    crouchButton = [crouch_button_base.button retain];
    [self addChild:crouch_button_base];
    
    SneakyButtonSkinnedBase *prone_button_base = [[[SneakyButtonSkinnedBase alloc]init]autorelease];
    prone_button_base.position = prone_button_position;
    prone_button_base.defaultSprite = [CCSprite spriteWithFile:@"button_base-01.png"];
    prone_button_base.activatedSprite = [CCSprite spriteWithFile:@"Button_Pressed-01.png"];
    prone_button_base.pressSprite = [CCSprite spriteWithFile:@"Button_Pressed-01.png"];
    prone_button_base.button = [[SneakyButton alloc] initWithRect:crouchButtonDimensions];
    proneButton = [prone_button_base.button retain];
    [self addChild:prone_button_base];
    
}

-(id) init
{
    self = [super init];
    if(self)
    {
        CCLOG(@"Setting up buttons and Joysticks");
        [self initJoystickAndButtons];
    }
    return self;
}
@end
