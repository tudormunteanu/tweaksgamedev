//
//  Person.m
//  The Way Home
//
//  Created by Tudor Munteanu on 9/25/13.
//
//

#import "Person.h"
#import "PlayerAvatar.h"

@implementation Person

- (id) initWithPrefix:(NSString *)prefix {
    
    self = [super init];
    if (self) {
        
        self.prefix = [NSString stringWithString:prefix];
        [PlayerAvatar cacheTexturesWithPrefix:prefix];
    }
    return self;
}

- (CGPoint) position {
    
    return self.avatar.position;
}

- (void) dealloc {
    
    [_avatar release];
    _avatar = nil;
    [_prefix release];
    _prefix = nil;
    [_spritesheet release];
    _spritesheet = nil;
    [super dealloc];
}

@end
