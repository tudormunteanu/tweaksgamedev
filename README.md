## Facebook Tweaks for iOS Game Development

This is a demo project of using [Facebook Tweaks](https://github.com/facebook/Tweaks) while developing a Cocos2D-iOS game. 

Tweaking animations, positions, UI layout can speed up the development process massively.

![Duration Tweak](https://dl.dropboxusercontent.com/u/1618599/mowow/duration_tweak.gif)

### Instructions

The important bits can be found in ``MWMainScene.m``

Using FBTweak to set the padding for a ``CCMenu``

``CGFloat restartPadding = FBTweakValue(@"UI", @"Reset Button Position", @"Padding", 10.0f);``

In the same manner, ``FBTweakValue`` can be used to adjust various animation attributes:

``CGFloat duration = FBTweakValue(@"Animation", @"Character", @"Duration", 4.0f);``

## License

TweaksDemo is released with a BSD License, while humbly and lovingly working at [moWOW Studios](http://mowowstudios.com).

Follow us at [@mowowstudios](http://twitter.com/mowowstudios)
