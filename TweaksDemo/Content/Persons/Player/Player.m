//
//  Player.m
//  The Way Home
//
//  Created by Tudor Munteanu on 9/23/13.
//
//

#import "Player.h"

@interface Player ()

@property (nonatomic, retain) PlayerAvatar *playerAvatar;

@end

@implementation Player

- (PlayerAvatar *) playerAvatar {
    
    if (!_playerAvatar) {
        
        _playerAvatar = [[PlayerAvatar createWithPrefix:self.prefix] retain];
    }
    return _playerAvatar;
}

- (CCSpriteBatchNode *) spritesheet {
    
    if (!_spritesheet) {
        
        _spritesheet = [[PlayerAvatar spritesheetWithPrefix:self.prefix] retain];
    }
    return _spritesheet;
}

- (CCNode *) avatar {
    
    if (!_avatar) {
        
        _avatar = [[CCNode node] retain];
        [_avatar addChild:self.spritesheet];
        [self.spritesheet addChild:self.playerAvatar];
    }
    return _avatar;
}

- (CCSprite *) randomFrameInDirection:(NSInteger)direction {
    
    CCSprite *spriteContainer = [CCSprite node];
    CCSprite *player = [PlayerAvatar createWithPrefix:self.prefix];
    [spriteContainer addChild:player];
    spriteContainer.scaleX = direction;
    return spriteContainer;
}

- (void) setOpacity:(float)opacity {
    
    [self.playerAvatar adjustOpacity:opacity];
}

#pragma mark - Animations

- (void) startRunningCallback:(void (^)(void))callback {
    
    callback();
}

- (void) run {
    
    [self.playerAvatar run];
}

- (void) switchDirection:(int)direction callback:(void (^)(void))callback {
    
    self.avatar.anchorPoint = ccp(1.0f - self.avatar.anchorPoint.x, self.avatar.anchorPoint.y);
    self.avatar.scaleX = direction;
    [self.playerAvatar switchDirection];
    if (callback) {
        
        callback();
    }
}

- (void) dieInDirection:(NSInteger)direction {
    
    [self.playerAvatar dieInDirection:direction];
}

- (void) idle {
    
    self.avatar.scaleX = 1;
    self.avatar.anchorPoint = ccp(0.4f, self.avatar.anchorPoint.y);
    [self.playerAvatar idle];
}

- (void) buzz {
    
    [self.playerAvatar buzzContinuously];
}

- (void) blinkFadeOut:(void (^)(void))callback {
    
    [self.playerAvatar blinkFadeWithCallback:callback];
}

- (void) fadeIn:(void (^)(void))doneBlock {
    
    [self.playerAvatar fadeIn:doneBlock];
}

#pragma mark - Memory

- (void) dealloc {
    
    [_playerAvatar release];
    _playerAvatar = nil;
    [super dealloc];
}

@end