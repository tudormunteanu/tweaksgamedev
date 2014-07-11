//
//  MWUILayer.h
//  TweaksDemo
//
//  Created by Tudor Munteanu on 11/07/14.
//  Copyright 2014 moWOW Studios. All rights reserved.
//

#import "cocos2d.h"

typedef void(^ResetBlock)(id sender);
typedef void(^FollowBlock)(id sender);

@interface MWUILayer : CCLayer

@property (nonatomic, copy) ResetBlock resetBlock;
@property (nonatomic, copy) FollowBlock followBlock;

+ (MWUILayer *)uiWithRestartButtonPadding:(CGFloat)restartPadding
                   andFollowButtonPadding:(CGFloat)followPadding;

@end
