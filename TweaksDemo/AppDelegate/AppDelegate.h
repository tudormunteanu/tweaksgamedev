//
//  AppDelegate.h
//  TweaksDemo
//
//  Created by Tudor Munteanu on 08/07/14.
//  Copyright moWOW Studios 2014. All rights reserved.
//

#import "cocos2d.h"
#import "FBTweakShakeWindow.h"
#import <UIKit/UIKit.h>

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	FBTweakShakeWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) FBTweakShakeWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
