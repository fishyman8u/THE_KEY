//
//  shortestPathStep.h
//  THE_KEY
//
//  Created by Nathan Jones on 12/27/11.
//  Copyright (c) 2011 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shortestPathStep : NSObject
{
	CGPoint position;
	int gScore;
	int hScore;
	shortestPathStep *parent;
}

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) int gScore;
@property (nonatomic, assign) int hScore;
@property (nonatomic, assign) shortestPathStep *parent;

- (id)initWithPosition:(CGPoint)pos;
- (int)fScore;
@end
