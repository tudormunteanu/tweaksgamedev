//
//  Config.h
//  Searching For Sundown
//
//  Created by Tudor Munteanu on 6/19/13.
//
//

#define IS_IPHONE (!IS_IPAD)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
#define IS_TALL_IPHONE ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && ([[CCDirector sharedDirector] winSize].width == 568))

#define obstacleBorder (IS_IPAD ? 2 : 1)
#define obstacleHeight (IS_IPAD ? 45 : 19)
#define obstacleWidth (IS_IPAD ? 45 : 21)

#define ballHeight (IS_IPAD ? 45 : 19)
#define ballWidth (IS_IPAD ? 45 : 21)

#define gridOffsetX (IS_IPAD ? 50.0f : 20)