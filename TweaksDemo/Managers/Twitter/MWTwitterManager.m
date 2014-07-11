//
//  MWTwitterManager.m
//  TweaksDemo
//
//  Created by Tudor Munteanu on 11/07/14.
//  Copyright (c) 2014 moWOW Studios. All rights reserved.
//

#import "MWTwitterManager.h"

@implementation MWTwitterManager

- (void)showTwitterProfile {
    
    NSURL *twitterURL = [NSURL URLWithString:@"twitter:///user?screen_name=mowowstudios"];
    NSURL *safariURL = [NSURL URLWithString:@"http://www.twitter.com/mowowstudios"];
    
    if ([[UIApplication sharedApplication] canOpenURL:twitterURL]) {
        
        [[UIApplication sharedApplication] openURL:twitterURL];
    } else {
        
        [[UIApplication sharedApplication] openURL:safariURL];
    }
}

@end
