//
//  ViewController.h
//  Jul26
//
//  Created by Matthew Fong on 7/26/12.
//  Copyright (c) 2012 Goldman Sachs. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> //for CADisplayLink

@interface ViewController : UIViewController {
    CADisplayLink *displayLink;
}

-(void) setupDisplayLink;

@property CADisplayLink *displayLink;

@end