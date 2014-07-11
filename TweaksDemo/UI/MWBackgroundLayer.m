//
//  MWBackgroundLayer.m
//  TweaksDemo
//
//  Created by Tudor Munteanu on 11/07/14.
//  Copyright 2014 moWOW Studios. All rights reserved.
//

#import "MWBackgroundLayer.h"

@implementation MWBackgroundLayer

+ (MWBackgroundLayer *)background {
    
    MWBackgroundLayer *layer = [MWBackgroundLayer node];
    CCSprite *background = [CCSprite spriteWithFile:@"background-airport-runway.png"];
    background.anchorPoint = CGPointZero;
    [layer addChild:background];
    return layer;
}


@end
