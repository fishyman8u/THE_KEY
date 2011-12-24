//
//  AppDelegate.h
//  THE_KEY
//
//  Created by Nathan Jones on 12/23/11.
//  Copyright Student 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
