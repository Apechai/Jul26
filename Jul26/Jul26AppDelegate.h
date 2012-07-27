//
//  Jul26AppDelegate.h
//  Jul26
//
//  Created by Matthew Fong on 7/24/12.
//  Copyright (c) 2012 Goldman Sachs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h> 

@class ViewController;

@interface Jul26AppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *_window;
    AVAudioPlayer *player;
}

@property (strong, nonatomic) UIWindow *window;

@end
