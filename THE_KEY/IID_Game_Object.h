//
//  IID_Game_Object.h
//  The_KEY
//
//  Created by Nathan Jones on 12/1/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import "CCSprite.h"
#import "CommonProtocols.h"
#import "Constants.h"
#import "cocos2d.h"
@interface IID_Game_Object : CCSprite
{
    BOOL isActive;
    BOOL reactsToScreenBoundaries;
    CGSize screenSize;
    GameObjectType gameObjectType;
    float rotation;
}
@property(nonatomic) GameObjectType gameObjectType;
@property(nonatomic, readwrite) BOOL isActive;
@property(nonatomic, readwrite) BOOL reactsToScreenBoundaries;
@property(nonatomic, readwrite) float rotation;

-(void) updateStateWithDeltaTime:(ccTime)deltaTime
            andListofGameObjects:(CCArray*)listOfGameObjects;
-(void) changeState:(CharacterStates)newState;
-(CCAnimation*)loadPlistForAnimationWithName:(NSString*)animationName
                                andClassName:(NSString *)className;

@end
