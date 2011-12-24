//
//  Root_Menu.m
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "Root_Menu.h"
#import "Root_Menu_Scene.h"

@interface Root_Menu()
-(void)displayMainMenu;
-(void)displaySceneSelection;
@end

@implementation Root_Menu
- (id)init
{
    self = [super init];
    if (self) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        CCSprite * background = [CCSprite spriteWithFile:@"The_Key_IPAD_Cover.png"];
        [background setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild:background];
        [self displayMainMenu];
    }
    
    return self;
}
-(void) buyBook{
    
}
-(void) showOptions
{
    CCLOG(@"Show options screen");
    [[GameManager sharedGameManager] runSceneWithID:kOptionsScene];
}
-(void)playScene:(CCMenuItemFont *)itemPassedIn
{
    CCLOG(@"Run test 2D level");
    if([itemPassedIn tag] == 1)
    {
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel1];
    }
    else if([itemPassedIn tag] ==2)
    {
        [[GameManager sharedGameManager] runSceneWithID:kGameLevel2];  
    }
    else if ([itemPassedIn tag] == 3)
    {
        [[GameManager sharedGameManager] runSceneWithID:kBoxTest];
    }
}

-(void)displayMainMenu
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    if(sceneSelectMenu != nil)
    {
        [sceneSelectMenu removeFromParentAndCleanup:YES];
    }
    CCLabelTTF * playgame = [CCLabelTTF labelWithString:@"Play Game" fontName:@"Helvetica" fontSize:32];
    CCLabelTTF * options = [CCLabelTTF labelWithString:@"Options" fontName:@"Helvetica" fontSize:32];
    CCLabelTTF * getTheKeyBook = [CCLabelTTF labelWithString:@"Get The Key Book" fontName:@"Helvetica" fontSize:32];
    
    //Main Menu
    CCMenuItemImage *playGameButton = [CCMenuItemImage itemFromNormalImage:@"button.png" selectedImage:@"button1.png" disabledImage:nil target:self selector:@selector(displaySceneSelection)];
    CCMenuItemLabel *play_the_game = [CCMenuItemLabel itemWithLabel:playgame];
    
    CCMenuItemLabel *open_options = [CCMenuItemLabel itemWithLabel:options];
    CCMenuItemLabel *open_the_book = [CCMenuItemLabel itemWithLabel:getTheKeyBook];
    CCMenuItemImage *optionsButton = [CCMenuItemImage itemFromNormalImage:@"button.png" selectedImage:@"button1.png" disabledImage:nil target:self selector:@selector(showOptions)];
    CCMenuItemImage *bookButton = [CCMenuItemImage itemFromNormalImage:@"button.png" selectedImage:@"button1.png" disabledImage:nil target:self selector:@selector(buyBook)];
    [playGameButton addChild:play_the_game];
    [optionsButton addChild:open_options];
    [bookButton addChild:open_the_book];
     mainMenu = [CCMenu menuWithItems: playGameButton, optionsButton, bookButton, nil];
    [mainMenu alignItemsVerticallyWithPadding:screenSize.height *0.059f];
    [mainMenu setPosition:ccp(screenSize.width *2, screenSize.height / 2)];
    id moveAction = [CCMoveTo actionWithDuration:1.2f position:ccp(screenSize.width *0.85f, screenSize.height/2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [mainMenu runAction:moveEffect];
    [self addChild:mainMenu z:0 tag:kMainMenuTagValue];
    
    
}
-(void)displaySceneSelection
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    if(mainMenu != nil)
    {
        [mainMenu removeFromParentAndCleanup:YES];
    }
    
    CCLabelTTF *play2DtestSceneLabel = [CCLabelTTF labelWithString:@"TESTING 2D Game" fontName:@"Helvetica" fontSize:32.0f];
    CCMenuItemLabel *play2DTest = [CCMenuItemLabel itemWithLabel:play2DtestSceneLabel target:self selector:@selector(playScene:)];
    [play2DTest setTag:1];
    CCLabelTTF *play2DscrolltestSceneLabel = [CCLabelTTF labelWithString:@"TESTING Scrolling 2D Game" fontName:@"Helvetica" fontSize:32.0f];
    CCLabelTTF *playbox2DscrolltestLabel = [CCLabelTTF labelWithString:@"TESTING BOX 2D Game" fontName:@"Helvetica" fontSize:32.0f];
    CCMenuItemLabel *play2DScrollTest = [CCMenuItemLabel itemWithLabel:play2DscrolltestSceneLabel target:self selector:@selector(playScene:)];
    [play2DScrollTest setTag:2];
    
    CCMenuItemLabel *playBox2dtest = [CCMenuItemLabel itemWithLabel:playbox2DscrolltestLabel target:self selector:@selector(playScene:)];
    [playBox2dtest setTag:3];
    CCLabelTTF *back_Button = [CCLabelTTF labelWithString:@"Back to main menu" fontName:@"Helvetica" fontSize:32.0f];
    CCMenuItemLabel *back = [CCMenuItemLabel itemWithLabel:back_Button target:self selector:@selector(displayMainMenu)];
    
    sceneSelectMenu = [CCMenu menuWithItems:play2DTest, play2DScrollTest, playBox2dtest,back, nil];
    [sceneSelectMenu alignItemsVerticallyWithPadding:screenSize.height*0.059f];
    [sceneSelectMenu setPosition:ccp(screenSize.width * 2, screenSize.height /2)];
    id moveAction = [CCMoveTo actionWithDuration:0.5f position:ccp(screenSize.width *0.75f, screenSize.height /2)];
    id moveEffect = [CCEaseIn actionWithAction:moveAction rate:1.0f];
    [sceneSelectMenu runAction:moveEffect];
    [self addChild:sceneSelectMenu z:1 tag:kSceneMenuTagValue];
}

@end
