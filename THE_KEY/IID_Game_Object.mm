//
//  IID_Game_Object.m
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//
//DONE!!!////////////////////
#import "IID_Game_Object.h"

@implementation IID_Game_Object
@synthesize gameObjectType;
//@synthesize rotation;
@synthesize isActive;
@synthesize reactsToScreenBoundaries;

-(void) updateStateWithDeltaTime:(ccTime)deltaTime
            andListofGameObjects:(CCArray*)listOfGameObjects
{
    CCLOG(@"NEED TO OVERRIDE FUNCTION, ******* IN IID_GAME_OBJECT UPDATE STATE");
}

-(void) changeState:(CharacterStates)newState
{
    CCLOG(@"NEED TO OVERRIDE FUNCTION, ******* IN IID_GAME_OBJECT CHANGE STATE");
}
-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName
                                andClassName:(NSString *)className
{
    CCLOG(@"Loading animations");
    
    CCAnimation *animationToReturn = nil;
    NSString *fullFileName = [NSString stringWithFormat:@"%@.plist", className];
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:fullFileName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath]){
        plistPath = [[NSBundle mainBundle] pathForResource:className ofType:@"plist"];
    }
    //2: read plist file
    NSDictionary *plistDictionary =
    [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    //3: If the plistDictionary was null, the file was not found
    if(plistDictionary == nil)
    {
        CCLOG(@"Error reading plist: %@.plist", className);
        return nil;
    }
    //4: Get just the mini dictionary for this animation
    NSDictionary *animationSettings = [plistDictionary objectForKey:animationName];
    if(animationSettings == nil)
    {
        CCLOG(@"Could not locate AnimationWithName: %@", animationName);
        return nil;
    }
    // 5: get the delay value for the animation
    float animationDelay = [[animationSettings objectForKey:@"delay"]floatValue];
    animationToReturn = [CCAnimation animation];
    [animationToReturn setDelay:animationDelay];
    
    // 6: Add the frames to the animation
    NSString * animationFramePrefix = [animationSettings objectForKey:@"filenamePrefix"];
    NSString *animationFrames = [animationSettings objectForKey:@"animationFrames"];
    NSArray *animationFrameNumbers = [animationFrames componentsSeparatedByString:@","];
    for (NSString * frameNumber in animationFrameNumbers)
    {
        NSString *frameName = [NSString stringWithFormat:@"%@%@.png", animationFramePrefix, frameNumber];
        [animationToReturn addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:frameName]];
        
    }
    return animationToReturn;
}
-(id) init
{
    self = [super init];
    if (self) {
        CCLOG(@"GameObject init");
        screenSize = [CCDirector sharedDirector].winSize;
        isActive = TRUE;
        gameObjectType = kObjectTypeNone;
    }
    return self;
}

@end
