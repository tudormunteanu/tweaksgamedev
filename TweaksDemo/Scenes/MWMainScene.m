//
//  MWMainScene.m
//  TweaksDemo
//
//  Created by Tudor Munteanu on 11/07/14.
//  Copyright 2014 moWOW Studios. All rights reserved.
//

#import "FBTweakInline.h"
#import "FBTweakViewController.h"
#import "MWBackgroundLayer.h"
#import "MWMainScene.h"
#import "MWTwitterManager.h"
#import "MWUILayer.h"
#import "Player.h"

@interface MWMainScene ()

@property (nonatomic, retain) Player *player;

@end

@implementation MWMainScene

#pragma mark - Lifecycle

+ (CCScene *)scene {

    return [MWMainScene node];
}

- (void)onEnter {
    
    [super onEnter];
    
    [self setupBackground];
    [self setupCharacters];
    [self setupUI];
    
    [self runAnimation];
    
    [self registerNotifications];
}

- (void)onExit {
    
    [super onExit];
    
    [self unregisterNotifications];
}

- (void)reset {
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f
                                                                                 scene:[MWMainScene scene]                                                                             withColor:ccBLACK]];
}

- (void)dealloc {
    
    [_player release];
    _player = nil;
    [super dealloc];
}

#pragma mark - Private

- (void)setupBackground {
    
    MWBackgroundLayer *backgroundLayer = [MWBackgroundLayer background];
    [self addChild:backgroundLayer];
}

- (void)setupUI {
    
    CGFloat restartPadding = FBTweakValue(@"UI", @"Reset Button Position", @"Padding", 10.0f);
    
    CGFloat followPadding = FBTweakValue(@"UI", @"Follow Button Position", @"Padding", 10.0f);
    
    MWUILayer *layer = [MWUILayer uiWithRestartButtonPadding:restartPadding
                                      andFollowButtonPadding:followPadding];
    [layer setResetBlock:^(id sender){
        
        [self reset];
    }];
    [layer setFollowBlock:^(id sender){
        
        [self followTapped];
    }];
    [self addChild:layer];
}

- (void)setupCharacters {
    
    NSString *prefix = @"will";
    self.player = [[[Player alloc] initWithPrefix:prefix] autorelease];
    
    [self addChild:self.player.avatar];
    
    NSUInteger col = FBTweakValue(@"Animation", @"Character", @"Start Column", 2, 0, 22);
    
    NSUInteger row = FBTweakValue(@"Animation", @"Character", @"Start Row", 8, 0, 22);
    
    CGPoint startPosition = ccp(col * obstacleWidth + gridOffsetX,
                                row * obstacleHeight);
    self.player.avatar.position = startPosition;
}

- (void)runAnimation {
    
    [self.player run];
    
    CGFloat duration = FBTweakValue(@"Animation", @"Character", @"Duration", 4.0f);
    
    NSUInteger col = FBTweakValue(@"Animation", @"Character", @"End Column", 18, 0, 22);
    
    NSUInteger row = FBTweakValue(@"Animation", @"Character", @"End Row", 8, 0, 22);
    
    CGPoint endPosition = ccp(col * obstacleWidth + gridOffsetX,
                              row * obstacleHeight);
    
    CGPoint startPosition = self.player.avatar.position;
    
    CCMoveTo *runAway = [CCMoveTo actionWithDuration:duration position:endPosition];
    CCCallBlock *postRunAway = [CCCallBlock actionWithBlock:^{
        
        self.player.avatar.scaleX = -1;
    }];
    CCMoveTo *comeBack = [CCMoveTo actionWithDuration:duration position:startPosition];
    CCCallBlock *postComeBack = [CCCallBlock actionWithBlock:^{
        
        self.player.avatar.scaleX = 1;
    }];
    CCSequence *seq = [CCSequence actions:runAway, postRunAway, comeBack, postComeBack, nil];
    CCRepeatForever *rep = [CCRepeatForever actionWithAction:seq];
    [self.player.avatar runAction:rep];
}

#pragma mark Buttons

- (void)followTapped {
    
    MWTwitterManager *twitterManager = [[[MWTwitterManager alloc] init] autorelease];
    [twitterManager showTwitterProfile];
}

#pragma mark - Notifications

- (void)registerNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tweaksDismissed:)
                                                 name:FBTweakShakeViewControllerDidDismissNotification
                                               object:nil];
}

- (void)unregisterNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FBTweakShakeViewControllerDidDismissNotification object:nil];
}

- (void)tweaksDismissed:(NSNotification *)notif {
    
    [self reset];
}


@end
