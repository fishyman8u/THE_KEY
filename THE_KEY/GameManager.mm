//
//  GameManager.m
//  The_KEY
//
//  Created by Nathan Jones on 10/23/11.
//  Copyright 2011 Student. All rights reserved.
//

#import "GameManager.h"
#import "Root_Menu_Scene.h"

@implementation GameManager
static GameManager * _sharedGameManager = nil;
@synthesize isMusicOn;
@synthesize hasPlayerDied;
@synthesize isSoundEffectsOn;
+(GameManager *)sharedGameManager {
    @synchronized ([GameManager class])
    {
        if(!_sharedGameManager) [[self alloc]init];
        return _sharedGameManager;
    }
    return nil;
}
+(id) alloc{
    @synchronized ([GameManager class])
    {
        NSAssert(_sharedGameManager == nil, @"Attempted to allocate  a second instance of game manager singleton." );
        _sharedGameManager = [super alloc];
        return _sharedGameManager;
    }
    return nil;
}
- (id)init
{
    self = [super init];
    if (self) {
        CCLOG(@"Game Manager Singleton init");
        isMusicOn = YES;
        isSoundEffectsOn = YES;
        hasPlayerDied = NO;
        currentScene = kNoSceneUninitialized;
      
    }
    
    return self;
}
-(void)runSceneWithID:(SceneTypes)sceneID
{
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    id sceneToRun = nil;
    
    switch (sceneID) {
        case kMainMenuScene:
            sceneToRun = [Root_Menu_Scene node];
            break;
        case kOptionsScene:
            //sceneToRun = [OptionsScene node];
        case kCreditsScene:
           // sceneToRun = [CreditsScene node];
        case kGameLevel1:
            CCLOG(@"Running initial test scene");
           sceneToRun = [IID_Game_Scene node];
            [sceneToRun initializeSceneWithTileMapFile:@"test_level.tmx"];
         //   {
         //       CCLOG(@"Scene loaded!");
         //   }
            break;
        case kGameLevel2:
            CCLOG(@"Running scene 2");
          //  sceneToRun = [GameScene2 node];
            break;
        case kBoxTest:
          //  sceneToRun = [Box2D_Test scene];
            break;
        case kLevelCompleteScene:
            break;
        case kIntroScene:
            break;
            
        default:
            CCLOG(@"Unknown scene ID, cannot switch scenes!");
            break;
    }
    if(sceneToRun == nil)
    {
        currentScene = oldScene;
    }
    
    if(sceneID < 100)
    {
        if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
        {
            CCLOG(@"NOT IPAD");
            CGSize screenSize = [CCDirector sharedDirector].winSizeInPixels;
            if(screenSize.width == 960.0f){
                //iPhone 4
                [sceneToRun setScaleX:0.9375f];
                [sceneToRun setScaleY:0.8333f];
                CCLOG(@"Scaling for Iphone 4.");
            }
            else
            {
                [sceneToRun setScaleX:0.4688f];
                [sceneToRun setScaleY:0.4166f];
                CCLOG(@"Scaling for not Iphone 4.");
            }
            
        }
    }
    if([[CCDirector sharedDirector] runningScene ]== nil)
    {
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
    }
    else
    {
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
    }
}
-(void)openSiteWithLinkType:(LinkTypes)linkTypeToOpen
{
    CCLOG(@"No links set yet!");
    //COCOS 2D book 32% of the way, chapter 7
}
-(CGSize) getDimensionsOfCurrentScene
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CGSize levelSize;
    switch (currentScene) {
        case kMainMenuScene:
        case kOptionsScene:
        case kCreditsScene:
        case kIntroScene:
        case kGameLevel1:
        case kLevelCompleteScene:
            levelSize = screenSize;
            break;
        case kGameLevel2:
            levelSize = CGSizeMake(200.0f*32.0f, 200.f*32.0f);
            break;
        case kBoxTest:
            levelSize = screenSize;
            break;
        default:
            levelSize = screenSize;
            break;
    }
    return levelSize;
}
@end
