//
//  PersonAvatar.h
//  The Way Home
//
//  Created by Tudor Munteanu on 9/25/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PersonAvatar : CCSprite {
    
}

@property (nonatomic, retain) CCSpriteBatchNode *dustSpritesheet;
@property (nonatomic, retain) CCSprite *headSprite;
@property (nonatomic, retain) CCSprite *headOutlineSprite;
@property (nonatomic, retain) CCSprite *leftFootSprite;
@property (nonatomic, retain) CCSprite *leftFootOutlineSprite;
@property (nonatomic) NSUInteger number;
@property (nonatomic, retain) NSString *prefix;
@property (nonatomic, retain) CCSprite *rightFootSprite;
@property (nonatomic, retain) CCSprite *rightFootOutlineSprite;
@property (nonatomic, retain) CCSprite *shadowSprite;
@property (nonatomic, retain) CCSprite *torsoSprite;
@property (nonatomic, retain) CCSprite *torsoOutlineSprite;


+ (void) cacheTexturesWithPrefix:(NSString *)prefix;
+ (CCSpriteBatchNode *) spritesheetWithPrefix:(NSString *)prefix;


@end
