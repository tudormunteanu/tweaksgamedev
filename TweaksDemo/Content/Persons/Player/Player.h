//
//  Player.h
//  The Way Home
//
//  Created by Tudor Munteanu on 9/23/13.
//
//

#import "Person.h"
#import "PlayerAvatar.h"

@interface Player : Person

- (void) startRunningCallback:(void (^)(void))callback;
- (void) run;
- (void) switchDirection:(int)direction callback:(void (^)(void))callback;
- (void) dieInDirection:(NSInteger)direction;
- (void) idle;
- (void) buzz;
- (void) blinkFadeOut:(void (^)(void))callback;
- (void) fadeIn:(void (^)(void))doneBlock;
- (void) setOpacity:(float)opacity;
- (CCSprite *) randomFrameInDirection:(NSInteger)direction;

@end
