//
//  PlayerAvatar.m
//  The Way Home
//
//  Created by Tudor Munteanu on 9/23/13.
//
//

#import "PlayerAvatar.h"

static float walkSpeed = 3.0f;

@interface PlayerAvatar ()

@end

@implementation PlayerAvatar

+ (PlayerAvatar *) createWithPrefix:(NSString *)prefix
{
    PlayerAvatar *baseSprite = [PlayerAvatar spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-shadow.png", prefix]];
    baseSprite.prefix = [NSString stringWithString:prefix];
    baseSprite.anchorPoint = ccp(0.4f, 0.36f);
    baseSprite.opacity = 0;
    
    CGPoint position = ccp(baseSprite.boundingBox.size.width/2,
                           baseSprite.boundingBox.size.height/2);
    
    CCSprite *shadowSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-shadow.png", prefix]];
    shadowSprite.position = position;
    baseSprite.shadowSprite = shadowSprite;
    [baseSprite addChild:shadowSprite];
    
    CCSprite *torsoOutlineSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-torso-outline.png", prefix]];
    torsoOutlineSprite.position = position;
    baseSprite.torsoOutlineSprite = torsoOutlineSprite;
    [baseSprite addChild:torsoOutlineSprite];
    
    CCSprite *headOutlineSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-head-outline.png", prefix]];
    headOutlineSprite.position = position;
    baseSprite.headOutlineSprite = headOutlineSprite;
    [baseSprite addChild:headOutlineSprite];
    
    CCSprite *leftFootOutlineSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-left-foot-outline.png", prefix]];
    leftFootOutlineSprite.position = position;
    [baseSprite addChild:leftFootOutlineSprite];
    baseSprite.leftFootOutlineSprite = leftFootOutlineSprite;
    
    CCSprite *rightFootOutlineSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-right-foot-outline.png", prefix]];
    rightFootOutlineSprite.position = position;
    [baseSprite addChild:rightFootOutlineSprite];
    baseSprite.rightFootOutlineSprite = rightFootOutlineSprite;
    
    CCSprite *torsoSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-torso.png", prefix]];
    torsoSprite.position = position;
    baseSprite.torsoSprite = torsoSprite;
    [baseSprite addChild:torsoSprite];
    
    CCSprite *headSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-head.png", prefix]];
    headSprite.position = position;
    baseSprite.headSprite = headSprite;
    [baseSprite addChild:headSprite];
    
    CCSprite *leftFootSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-left-foot.png", prefix]];
    leftFootSprite.position = position;
    [baseSprite addChild:leftFootSprite];
    baseSprite.leftFootSprite = leftFootSprite;
    
    CCSprite *rightFootSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@-right-foot.png", prefix]];
    rightFootSprite.position = position;
    [baseSprite addChild:rightFootSprite];
    baseSprite.rightFootSprite = rightFootSprite;
    
    return baseSprite;
}

+ (void) cacheTexturesWithPrefix:(NSString *)prefix
{
    NSString *filename = [NSString stringWithFormat:@"%@-bits.plist", prefix];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:filename];
}

+ (CCSpriteBatchNode *) spritesheetWithPrefix:(NSString *)prefix
{
    NSString *filename = [NSString stringWithFormat:@"%@-bits.png", prefix];
    return [CCSpriteBatchNode batchNodeWithFile:filename];
}

- (void) adjustOpacity:(float)opacity
{
    NSArray *bits = @[self.headSprite,
                      self.headOutlineSprite,
                      self.torsoSprite,
                      self.torsoOutlineSprite,
                      self.leftFootSprite,
                      self.leftFootOutlineSprite,
                      self.rightFootSprite,
                      self.rightFootOutlineSprite,
                      self.shadowSprite];
    for (CCSprite *sprite in bits) {
        sprite.opacity = opacity;
    }
}

#pragma mark - Dust

+ (CCSprite *) randomDust {
    
    NSUInteger i = arc4random()%6 + 1;
    NSString *frameName = [NSString stringWithFormat:@"animation0%02d.png", i];
    CCSprite *randomDust = [CCSprite spriteWithSpriteFrameName:frameName];
    randomDust.anchorPoint = ccp(0.4f, 0.36f);
    return randomDust;
}

- (void) setupDustInNode:(CCNode *)node {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"morse-dust.plist"];
    CCSpriteBatchNode *dustSpritesheet = [CCSpriteBatchNode batchNodeWithFile:@"morse-dust.png"];
    [[[node parent] parent] addChild:dustSpritesheet];
    self.dustSpritesheet = dustSpritesheet;
    
    CCSprite *dust = [CCSprite spriteWithSpriteFrameName:@"animation001.png"];
    dust.position = self.position;
    dust.opacity = (255 * 7)/10;
    dust.anchorPoint = self.anchorPoint;
    [dustSpritesheet addChild:dust];
    
    NSMutableArray *animFrames = [NSMutableArray array];
    for (int i=1; i<=6; i++) {
        [animFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"animation0%02d.png", i]]];
    }
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animFrames delay:0.1f];
    CCRepeatForever *action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
    [dust runAction:action];
}

#pragma mark - Animations

- (void) fadeOutWithDuration:(float)duration
{
    NSArray *bits = @[self.headSprite,
                      self.headOutlineSprite,
                      self.torsoSprite,
                      self.torsoOutlineSprite,
                      self.leftFootSprite,
                      self.leftFootOutlineSprite,
                      self.rightFootSprite,
                      self.rightFootOutlineSprite,
                      self.shadowSprite];
    for (CCSprite *sprite in bits) {
        CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:duration];
        [sprite runAction:fadeOut];
    }
}

- (void) blinkFadeWithCallback:(void (^)(void))callback
{
    float duration = 0.2f;
    float delayTime = 0.3f;
    NSUInteger numberOfRepeates = 3;
    NSArray *bits = @[self.headSprite,
                      self.headOutlineSprite,
                      self.torsoSprite,
                      self.torsoOutlineSprite,
                      self.leftFootSprite,
                      self.leftFootOutlineSprite,
                      self.rightFootSprite,
                      self.rightFootOutlineSprite,
                      self.shadowSprite];
    __block NSUInteger index = 1;
    for (CCSprite *sprite in bits) {
        CCFadeOut *fadeOut = [CCFadeOut actionWithDuration:duration];
        CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:duration];
        CCSequence *fadeSeq = [CCSequence actions:fadeOut, fadeIn, nil];
        CCRepeat *rep = [CCRepeat actionWithAction:fadeSeq times:numberOfRepeates];
        CCCallBlock *fadeDone = [CCCallBlock actionWithBlock:^{
            index++;
            if (index == [bits count]) {
                callback();
            }
        }];
        CCFadeOut *finalFadeOut = [CCFadeOut actionWithDuration:duration];
        CCDelayTime *delay = [CCDelayTime actionWithDuration:delayTime];
        CCSequence *seq = [CCSequence actions:rep, finalFadeOut, delay, fadeDone, nil];
        [sprite runAction:seq];
    }
}

- (void) fadeIn:(void (^)(void))doneBlock
{
    float duration = 2.4f;
    NSArray *bits = @[self.headSprite,
                      self.headOutlineSprite,
                      self.torsoSprite,
                      self.torsoOutlineSprite,
                      self.leftFootSprite,
                      self.leftFootOutlineSprite,
                      self.rightFootSprite,
                      self.rightFootOutlineSprite,
                      self.shadowSprite];
    __block NSUInteger index = 1;
    for (CCSprite *sprite in bits) {
        CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:duration];
        CCEaseOut *ease = [CCEaseOut actionWithAction:fadeIn rate:2];
        CCCallBlock *fadeDone = [CCCallBlock actionWithBlock:^{
            index++;
            if (index == [bits count]) {
                doneBlock();
            }
        }];
        CCSequence *seq = [CCSequence actions:ease, fadeDone, nil];
        [sprite runAction:seq];
    }
}

- (void) run
{
//    NSLog(@"-=- run");
    [self setupDustInNode:self];
    
    {
        float speed = walkSpeed/10.0f;
        CCScaleTo *s1 = [CCScaleTo actionWithDuration:speed scaleX:0.95f scaleY:1];
        CCScaleTo *s2 = [CCScaleTo actionWithDuration:speed scaleX:1.0f scaleY:1];
        CCSequence *sSeq = [CCSequence actions:s1, s2, nil];
        CCRepeatForever *sRep = [CCRepeatForever actionWithAction:sSeq];
        [self.shadowSprite runAction:sRep];
    }

    {
        float speed = walkSpeed/15.0f;
        
        for (CCSprite *sprite in @[self.torsoSprite, self.torsoOutlineSprite]) {
            CGPoint center = ccp(self.boundingBox.size.width/2, self.boundingBox.size.height/2);
            CCMoveTo *t1 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.y + 1)];
            CCMoveTo *t2 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.y)];
            CCSequence *tSeq = [CCSequence actions:t1, t2, nil];
            CCRepeatForever *tRep = [CCRepeatForever actionWithAction:tSeq];
            [sprite runAction:tRep];
        }
    }

    {
        float speed = walkSpeed/15.0f;
        
        for (CCSprite *sprite in @[self.headSprite, self.headOutlineSprite]) {
            CGPoint center = ccp(self.boundingBox.size.width/2, self.boundingBox.size.height/2);
            CCMoveTo *h1 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 1, center.y - 1)];
            CCMoveTo *h4 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.x)];
            CCMoveTo *h5 = [CCMoveTo actionWithDuration:speed position:ccp(center.x - 1, center.y - 1)];
            CCMoveTo *h8 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.x)];
            CCSequence *hSeq = [CCSequence actions:h1, h4, h5, h8, nil];
            CCRepeatForever *hRep = [CCRepeatForever actionWithAction:hSeq];
            [sprite runAction:hRep];
        }
    }

    [self moveLeftFoot];
}

- (void) stopAllActionsForAllBodyBits
{
    [self stopAllActions];
    [self.headOutlineSprite stopAllActions];
    [self.headSprite stopAllActions];
    [self.torsoOutlineSprite stopAllActions];
    [self.torsoSprite stopAllActions];
    [self.leftFootOutlineSprite stopAllActions];
    [self.leftFootSprite stopAllActions];
    [self.rightFootOutlineSprite stopAllActions];
    [self.rightFootSprite stopAllActions];
    [self.shadowSprite stopAllActions];
    
}

- (void) dieInDirection:(NSInteger)direction
{
    
    [self stopAllActionsForAllBodyBits];
    [self.dustSpritesheet removeFromParentAndCleanup:YES];

    float height = 30;
    float easeRate = 1.5f;
    float speed = 0.3f;
    for (CCSprite *bit in @[self.headSprite, self.headOutlineSprite]) {
        float angle = -70;
        CCRotateTo *rotate = [CCRotateTo actionWithDuration:speed angle:angle];
        [bit runAction:rotate];
        CGPoint offset = IS_IPAD ? ccp(-74, 2) : ccp(-39, 1);
        CCJumpTo *jump = [CCJumpTo actionWithDuration:speed position:ccp(bit.position.x + offset.x, bit.position.y + offset.y) height:height jumps:1];
        CCEaseIn *ease = [CCEaseIn actionWithAction:jump rate:easeRate];
        [bit runAction:ease];
    }
    
    for (CCSprite *bit in @[self.torsoSprite, self.torsoOutlineSprite]) {
        float angle = -80;
        CCRotateTo *rotate = [CCRotateTo actionWithDuration:speed angle:angle];
        [bit runAction:rotate];
        CGPoint offset = IS_IPAD ? ccp(-80, 0) : ccp(-40, 0);
        CCJumpTo *jump = [CCJumpTo actionWithDuration:speed position:ccp(bit.position.x + offset.x, bit.position.y) height:height jumps:1];
        CCEaseIn *ease = [CCEaseIn actionWithAction:jump rate:easeRate];
        [bit runAction:ease];
    }

    for (CCSprite *bit in @[self.leftFootSprite, self.leftFootOutlineSprite]) {
        float angle = -40;
        CCRotateTo *rotate = [CCRotateTo actionWithDuration:speed angle:angle];
        [bit runAction:rotate];
        CGPoint offset = IS_IPAD ? ccp(-75, 12) : ccp(-38, 6);
        CCJumpTo *jump = [CCJumpTo actionWithDuration:speed position:ccp(bit.position.x + offset.x, bit.position.y + offset.y) height:height jumps:1];
        CCEaseIn *ease = [CCEaseIn actionWithAction:jump rate:easeRate];
        [bit runAction:ease];
    }


    for (CCSprite *bit in @[self.rightFootSprite, self.rightFootOutlineSprite]) {
        float angle = -80;
        CCRotateTo *rotate = [CCRotateTo actionWithDuration:speed angle:angle];
        [bit runAction:rotate];
        CGPoint offset = IS_IPAD ? ccp(-80, 0) : ccp(-40, 0);
        CCJumpTo *jump = [CCJumpTo actionWithDuration:speed position:ccp(bit.position.x + offset.x, bit.position.y) height:height jumps:1];
        CCEaseIn *ease = [CCEaseIn actionWithAction:jump rate:easeRate];
        [bit runAction:ease];
    }
    
//    float shadowRotation = -90;
//    CCRotateTo *rotateShadow = [CCRotateTo actionWithDuration:speed angle:shadowRotation];
//    [self.shadowSprite runAction:rotateShadow];
//    float speed = 0.5f;
    CGPoint offset = IS_IPAD ? ccp(-63, -3) : ccp(-32, -2);
    CCMoveTo *moveShadow = [CCMoveTo actionWithDuration:speed position:ccp(self.shadowSprite.position.x + offset.x, self.shadowSprite.position.y + offset.y)];
    [self.shadowSprite runAction:moveShadow];
    CCScaleTo *scaleDown = [CCScaleTo actionWithDuration:speed/2.0f scale:0.7f];
    CCScaleTo *scaleUp = [CCScaleTo actionWithDuration:speed/2.0f scale:1.0f];
    CCCallBlock *callback = [CCCallBlock actionWithBlock:^{
        [self buzz];
    }];
    CCSequence *scaleSeq = [CCSequence actions:scaleDown, scaleUp, callback, nil];
    
    [self.shadowSprite runAction:scaleSeq];
}

- (void) buzz
{
    [self buzzAndLoop:YES shortRun:NO];
}

- (void) buzzContinuously
{
    [self buzzAndLoop:YES shortRun:NO continuously:YES];
}

- (void) buzzAndLoop:(BOOL)shouldLoop shortRun:(BOOL)shortRun
{
    [self buzzAndLoop:shouldLoop shortRun:shouldLoop continuously:NO];
}

- (void) buzzAndLoop:(BOOL)shouldLoop shortRun:(BOOL)shortRun continuously:(BOOL)continuously
{
    NSArray *bitsDicts = @[
                           @{@"sprite": self.headSprite, @"outline": self.headOutlineSprite, @"bitName": [NSString stringWithFormat:@"%@-head", self.prefix]},
                           @{@"sprite": self.torsoSprite, @"outline": self.torsoOutlineSprite, @"bitName": [NSString stringWithFormat:@"%@-torso", self.prefix]},
                           @{@"sprite": self.leftFootSprite, @"outline": self.leftFootOutlineSprite, @"bitName": [NSString stringWithFormat:@"%@-left-foot", self.prefix]},
                           @{@"sprite": self.rightFootSprite, @"outline": self.rightFootOutlineSprite, @"bitName": [NSString stringWithFormat:@"%@-right-foot", self.prefix], @"final": @(YES)}
                           ];
    float delay = 3.0f;
    if (continuously) {
        delay = 0.3f;
    }
    float frameTime = 0.15f;
    if (shortRun) {
        frameTime = 0.1f;
    }
    for (NSDictionary *bitDict in bitsDicts) {
        
        NSMutableArray *animFrames = [NSMutableArray array];
        NSArray *frameNames = nil;
        if (shortRun) {
            frameNames = @[
                           [NSString stringWithFormat:@"%@-buzzed-1.png", bitDict[@"bitName"]],
                           [NSString stringWithFormat:@"%@-buzzed-2.png", bitDict[@"bitName"]],
                           [NSString stringWithFormat:@"%@-buzzed-3.png", bitDict[@"bitName"]],
                           ];
        } else {
            frameNames = @[
                           [NSString stringWithFormat:@"%@-buzzed-1.png", bitDict[@"bitName"]],
                           [NSString stringWithFormat:@"%@-buzzed-2.png", bitDict[@"bitName"]],
                           [NSString stringWithFormat:@"%@-buzzed-3.png", bitDict[@"bitName"]],
                           [NSString stringWithFormat:@"%@-buzzed-1.png", bitDict[@"bitName"]],
                           [NSString stringWithFormat:@"%@-buzzed-3.png", bitDict[@"bitName"]],
                           [NSString stringWithFormat:@"%@-buzzed-2.png", bitDict[@"bitName"]]
                           ];
        }
        for (NSString *frameName in frameNames) {
            [animFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
        }
        CCCallBlock *hideOutlineAction = [CCCallBlock actionWithBlock:^{
            [bitDict[@"outline"] setVisible:NO];
        }];
        CCAnimation *buzzAnim = [CCAnimation animationWithSpriteFrames:animFrames delay:frameTime];
        CCAnimate *buzzAction = [CCAnimate actionWithAnimation:buzzAnim];
        NSString *frameName = [NSString stringWithFormat:@"%@.png", bitDict[@"bitName"]];
        CCSpriteFrame *normalSprite = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
        CCAnimation *normalAnim = [CCAnimation animationWithSpriteFrames:@[normalSprite] delay:delay];
        CCAnimate *normalState = [CCAnimate actionWithAnimation:normalAnim];
        CCCallBlock *showOutlineAction = [CCCallBlock actionWithBlock:^{
            [bitDict[@"outline"] setVisible:YES];
        }];
        CCCallBlock *rerunAction = [CCCallBlock actionWithBlock:^{
            if (shouldLoop) {
                if ([bitDict[@"final"] isEqualToNumber:@(YES)]) {
                    if (continuously) {
                        [self buzzAndLoop:shouldLoop shortRun:shortRun continuously:YES];
                    } else {
                        [self buzz];
                    }
                }
            }
        }];
        CCSequence *seq = [CCSequence actions:hideOutlineAction, buzzAction, showOutlineAction, normalState, rerunAction, nil];
        [bitDict[@"sprite"] runAction:seq];
    }
}

- (void) switchDirection
{
    [self buzzAndLoop:NO shortRun:YES];
}

- (void) idle
{
    CGPoint pos = ccp(self.boundingBox.size.width/2, self.boundingBox.size.height/2);
    NSArray *bits = @[self.headSprite,
                      self.headOutlineSprite,
                      self.torsoSprite,
                      self.torsoOutlineSprite,
                      self.leftFootSprite,
                      self.leftFootOutlineSprite,
                      self.rightFootSprite,
                      self.rightFootOutlineSprite,
                      self.shadowSprite];
    for (CCSprite *sprite in bits) {
        sprite.rotation = 0;
        sprite.position = pos;
        [sprite stopAllActions];
    }
    [self.dustSpritesheet removeFromParentAndCleanup:YES];
}

- (void) moveLeftFoot
{
    CCSprite *leftFootSprite = self.leftFootSprite;
    CCSprite *leftFootOutlineSprite = self.leftFootOutlineSprite;

    float speed = 0.05f;
    float delayTime = 0;
    
    CGPoint center = ccp(self.boundingBox.size.width/2, self.boundingBox.size.height/2);
    
    CCMoveTo *lf1 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.y + 1)];
    CCMoveTo *lf2 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 1, center.y + 1)];
    CCMoveTo *lf3 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 2, center.y + 1)];
    CCMoveTo *lf4 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 2, center.y)];
    CCMoveTo *lf5 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 1, center.y)];
    CCMoveTo *lf6 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.y)];
    CCDelayTime *delay = [CCDelayTime actionWithDuration:delayTime];
    CCCallBlock *postMove = [CCCallBlock actionWithBlock:^{
        [self moveRightFoot];
    }];
    CCSequence *lfSeq = [CCSequence actions:lf1, lf2, lf3, lf4, lf5, lf6, delay, postMove, nil];
    [leftFootSprite runAction:lfSeq];

    CCMoveTo *lfo1 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.y + 1)];
    CCMoveTo *lfo2 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 1, center.y + 1)];
    CCMoveTo *lfo3 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 2, center.y + 1)];
    CCMoveTo *lfo4 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 2, center.y)];
    CCMoveTo *lfo5 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 1, center.y)];
    CCMoveTo *lfo6 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.y)];
    CCDelayTime *delayo = [CCDelayTime actionWithDuration:delayTime];
    CCSequence *lfoSeq = [CCSequence actions:lfo1, lfo2, lfo3, lfo4, lfo5, lfo6, delayo, nil];
    [leftFootOutlineSprite runAction:lfoSeq];
}

- (void) moveRightFoot
{

    CCSprite *rightFootSprite = self.rightFootSprite;
    CCSprite *rightFootOutlineSprite = self.rightFootOutlineSprite;

    float speed = 0.05f;
    float delayTime = 0;
    
    CGPoint center = ccp(self.boundingBox.size.width/2, self.boundingBox.size.height/2);

    CCMoveTo *rf1 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.y + 1)];
    CCMoveTo *rf2 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 2, center.y + 2)];
    CCMoveTo *rf3 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 2, center.y + 1)];
    CCMoveTo *rf4 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 2, center.y)];
    CCMoveTo *rf5 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 1, center.y)];
    CCMoveTo *rf6 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.y)];
    CCDelayTime *delay = [CCDelayTime actionWithDuration:delayTime];
    CCCallBlock *postMove = [CCCallBlock actionWithBlock:^{
        [self moveLeftFoot];
    }];
    CCSequence *rfSeq = [CCSequence actions:delay, rf1, rf2, rf3, rf4, rf5, rf6, postMove, nil];
    [rightFootSprite runAction:rfSeq];

    CCMoveTo *rfo1 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.y + 1)];
    CCMoveTo *rfo2 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 2, center.y + 2)];
    CCMoveTo *rfo3 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 2, center.y + 1)];
    CCMoveTo *rfo4 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 2, center.y)];
    CCMoveTo *rfo5 = [CCMoveTo actionWithDuration:speed position:ccp(center.x + 1, center.y)];
    CCMoveTo *rfo6 = [CCMoveTo actionWithDuration:speed position:ccp(center.x, center.y)];
    CCDelayTime *delayo = [CCDelayTime actionWithDuration:delayTime];
    CCSequence *rfoSeq = [CCSequence actions:delayo, rfo1, rfo2, rfo3, rfo4, rfo5, rfo6, nil];
    [rightFootOutlineSprite runAction:rfoSeq];

}

#pragma mark - Memory

- (void) dealloc
{
//    NSLog(@"-=- player avatar dealloced");
    [super dealloc];
}

@end
