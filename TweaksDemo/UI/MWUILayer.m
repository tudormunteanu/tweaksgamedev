//
//  MWUILayer.m
//  TweaksDemo
//
//  Created by Tudor Munteanu on 11/07/14.
//  Copyright 2014 moWOW Studios. All rights reserved.
//

#import "MWUILayer.h"

@implementation MWUILayer

#pragma mark - Lifecycle

+ (MWUILayer *)uiWithRestartButtonPadding:(CGFloat)restartPadding
                   andFollowButtonPadding:(CGFloat)followPadding {
    
    MWUILayer *layer = [MWUILayer node];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"buttons.plist"];
    
    //
    CCMenuItemSprite *restartMenuItem = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"reset-button-normal.png"]
                                                                selectedSprite:[CCSprite spriteWithSpriteFrameName:@"reset-button-selected.png"]
                                                                         block:^(id sender) {
                                                                             
                                                                             [layer resetTapped:sender];
                                                                         }];
    
    CCMenu *restartMenu = [CCMenu menuWithItems:restartMenuItem, nil];
    
    restartMenu.position = ccp(winSize.width - restartMenuItem.contentSize.width/2 - restartPadding,
                               winSize.height - restartMenuItem.contentSize.height/2 - restartPadding);
    [layer addChild:restartMenu];
    
    //
    CCMenuItemSprite *followMenuItem = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"follow-us-normal.png"]
                                                               selectedSprite:[CCSprite spriteWithSpriteFrameName:@"follow-us-selected.png"]
                                                                        block:^(id sender) {
                                                                            
                                                                            [layer followTapped:sender];
                                                                        }];
    
    CCMenu *followMenu = [CCMenu menuWithItems:followMenuItem, nil];
    
    followMenu.position = ccp(winSize.width - followMenuItem.contentSize.width/2 - followPadding,
                              followMenuItem.contentSize.height/2 + followPadding);
    [layer addChild:followMenu];

    return layer;
}

- (void)dealloc {
    
    [_resetBlock release];
    _resetBlock = nil;
    [_followBlock release];
    _followBlock = nil;
    [super dealloc];
}

#pragma mark - Private

- (void)resetTapped:(id)sender {
    
    if (self.resetBlock) {
        
        self.resetBlock(sender);
    }
}

- (void)followTapped:(id)sender {
    
    if (self.followBlock) {
        
        self.followBlock(sender);
    }
}

@end
