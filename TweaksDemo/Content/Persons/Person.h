//
//  Person.h
//  The Way Home
//
//  Created by Tudor Munteanu on 9/25/13.
//
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    CCNode *_avatar;
    CCSpriteBatchNode *_spritesheet;
}

@property (nonatomic, retain) CCNode *avatar;
@property (nonatomic) CGPoint position;
@property (nonatomic, retain) NSString *prefix;
@property (nonatomic, retain) CCSpriteBatchNode *spritesheet;

- (id) initWithPrefix:(NSString *)prefix;

@end
