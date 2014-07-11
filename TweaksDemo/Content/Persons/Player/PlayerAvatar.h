//
//  PlayerAvatar.h
//  The Way Home
//
//  Created by Tudor Munteanu on 9/23/13.
//
//

#import "cocos2d.h"
#import "PersonAvatar.h"

@interface PlayerAvatar : PersonAvatar

+ (PlayerAvatar *) createWithPrefix:(NSString *)prefix;

- (void) idle;
- (void) run;
- (void) dieInDirection:(NSInteger)direction;
- (void) switchDirection;
- (void) buzz;
- (void) buzzContinuously;
- (void) fadeOutWithDuration:(float)duration;
- (void) blinkFadeWithCallback:(void (^)(void))callback;
- (void) fadeIn:(void (^)(void))doneBlock;
- (void) adjustOpacity:(float)opacity;
+ (CCSprite *) randomDust;

@end