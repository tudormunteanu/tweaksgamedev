//
//  PersonAvatar.m
//  The Way Home
//
//  Created by Tudor Munteanu on 9/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PersonAvatar.h"


@implementation PersonAvatar

+ (void) cacheTexturesWithPrefix:(NSString *)prefix {
    
}

+ (CCSpriteBatchNode *) spritesheetWithPrefix:(NSString *)prefix {
    
    NSAssert(1==0, @"Must overwrite");
    return nil;
}


- (void) dealloc {
    [_dustSpritesheet release];
    _dustSpritesheet = nil;
    [_headSprite release];
    _headSprite = nil;
    [_headOutlineSprite release];
    _headOutlineSprite = nil;
    [_leftFootSprite release];
    _leftFootSprite = nil;
    [_leftFootOutlineSprite release];
    _leftFootOutlineSprite = nil;
    [_prefix release];
    _prefix = nil;
    [_rightFootSprite release];
    _rightFootSprite = nil;
    [_rightFootOutlineSprite release];
    _rightFootOutlineSprite = nil;
    [_shadowSprite release];
    _shadowSprite = nil;
    [_torsoSprite release];
    _torsoSprite = nil;
    [_torsoOutlineSprite release];
    _torsoOutlineSprite = nil;
    [super dealloc];
}

@end
