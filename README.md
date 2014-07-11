## Facebook Tweaks for iOS Game Development

This is a demo project of using a [custom fork](https://github.com/tudormunteanu/Tweaks) of [Facebook Tweaks](https://github.com/facebook/Tweaks) while developing a Cocos2D-iOS game. 

Tweaking animations, positions, UI layout can speed up the development process massively.

### Instructions

The important bits can be found in ``MWMainScene.m``

Using FBTweak to set the padding for a ``CCMenu``

``CGFloat restartPadding = FBTweakValue(@"UI", @"Reset Button Position", @"Padding", 10.0f);``

In the same manner, ``FBTweakValue`` can be used to adjust various animation attributes:

``CGFloat duration = FBTweakValue(@"Animation", @"Character", @"Duration", 4.0f);``

### Note

The main reason why a fork of Facebook Tweaks is used, is to add an NSNotification which can refresh the currently running scene whent he Tweaks UI is dismissed. 

## License

TweaksDemo is released with a BSD License, while humbly and lovingly working at [moWOW Studios](http://mowowstudios.com).

Follow us at [@mowowstudios](http://twitter.com/mowowstudios)
