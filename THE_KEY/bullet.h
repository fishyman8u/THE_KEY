//
//  bullet.h
//  The_KEY
//
//  Created by Nathan Jones on 10/9/11.
//  Copyright 2011 Student. All rights reserved.
//


#import "IID_Game_Character.h"
#import "Constants.h"
#import "CommonProtocols.h"

@interface bullet : IID_Game_Character
{
    CCAnimation *firingAnim;
    CCAnimation *travellingAnim;
    
    float live_time;
    //int owner_tag;
    
}

@property(nonatomic,retain) CCAnimation *firingAnim;
@property(nonatomic,retain) CCAnimation *travellingAnim;
@property(readwrite) float live_time;
//@property(readwrite) int owner_tag;
-(void) setRotationTransform:(float)rotation andPosition:(b2Vec2)pos;
@end
