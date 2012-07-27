//
//  View.m
//  Jul26
//
//  Created by Matthew Fong on 7/26/12.
//  Copyright (c) 2012 Goldman Sachs. All rights reserved.
//

#import "Asteroid.h"
#import "Ship.h"
#include <stdlib.h>
#import "View.h"
#import "ViewController.h"

@implementation View

@synthesize controller;

- (id) initWithFrame: (CGRect) frame controller: (ViewController *) c {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        controller = c;
        self.backgroundColor = [UIColor blackColor];
        fueltank = 100;
        highscore = 100;
        NSString *string = [NSString stringWithFormat:
                            @"Current Fuel: %d",
                            fueltank];
        UIFont *font = [UIFont systemFontOfSize: 14.0 ];
        CGSize size = [string sizeWithFont: font];
        CGRect z = CGRectMake(
                              self.bounds.origin.x,
                              self.bounds.origin.y,
                              size.width,
                              size.height
                              );
        
        fuel = [[UILabel alloc] initWithFrame: z];
        fuel.backgroundColor = [UIColor clearColor];
        fuel.textColor = [UIColor greenColor];
        fuel.font = font;
        fuel.text = string;
        [self addSubview: fuel];
        
        CGRect scr = CGRectMake(
                                160,
                                0,
                                size.width,
                                size.height
                                );
        NSString *string2 = [NSString stringWithFormat:
                             @"Best Score: %d",
                             highscore];
        
        score = [[UILabel alloc] initWithFrame: scr];
        score.backgroundColor = [UIColor clearColor];
        score.textColor = [UIColor greenColor];
        score.font = font;
        score.text = string2;
        [self addSubview: score];
        
        CGRect f = CGRectMake(0, 0, 60, 60);
        CGRect s = CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, 30, 30);
        asteroid1 = [[Asteroid alloc] initWithFrame: f];
        asteroid2 = [[Asteroid alloc] initWithFrame: f];
        [self addSubview: asteroid1];
        [self addSubview: asteroid2];
        ship = [[Ship alloc] initWithFrame:s];
        [self addSubview: ship];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // generate random starting point
    asteroid1.center = CGPointMake(arc4random()%(100-30)+30, arc4random()%(100-30)+30);
    asteroid2.center = CGPointMake(arc4random()%(300-200)+200, arc4random()%(400-300)+300);
    
    asteroid2.dx = asteroid2.dx * 1.5;
    asteroid2.dy = asteroid2.dy * 1.5;
    
}



// move ship according to touch

- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    if (touches.count > 0) {
        
        fueltank = fueltank - 1;
        CGPoint destination = [[touches anyObject] locationInView: self];
        CGFloat delta_x = destination.x - ship.center.x;
        CGFloat delta_y = destination.y - ship.center.y;
        
        CGFloat directiontouched = atan2(delta_x, -delta_y);
        [UIView animateWithDuration: 0.3
                              delay: 0
                            options: UIViewAnimationOptionCurveEaseInOut
         | UIViewAnimationOptionAllowUserInteraction
         | UIViewAnimationOptionBeginFromCurrentState
                         animations: ^{
                             //This block describes what the animation should do.
                             [UIView setAnimationRepeatCount: 1];
                             ship.center = [[touches anyObject] locationInView: self];
                             ship.transform = CGAffineTransformMakeRotation(directiontouched);
                             fuel.text = [NSString stringWithFormat:
                                          @"Current Fuel: %d",
                                          fueltank];
                         }
                         completion: NULL
         ];
    }
}

//moves the asteroids
- (void) move: (CADisplayLink *) displayLink {
    //NSLog(@"%.15g", displayLink.timestamp); //15 significant digits
    
    asteroid1.center = CGPointMake(asteroid1.center.x + asteroid1.dx, asteroid1.center.y + asteroid1.dy);
    asteroid2.center = CGPointMake(asteroid2.center.x + asteroid2.dx, asteroid2.center.y + asteroid2.dy);
    
    [self bounce:asteroid1];
    [self bounce:asteroid2];
}

//Change the ball's direction of motion,
//if necessary to avoid an impending collision.

- (void) bounce: (Asteroid *) asteroid{
    //Where the ball would be if its horizontal motion were allowed
    //to continue for one more move.
    CGRect horizontal = asteroid.frame;
    horizontal.origin.x += asteroid.dx;
    
    //Where the ball would be if its vertical motion were allowed
    //to continue for one more move.
    CGRect vertical = asteroid.frame;
    vertical.origin.y += asteroid.dy;
    
    //asteroid must remain inside self.bounds.
    if (!CGRectEqualToRect(horizontal, CGRectIntersection(horizontal, self.bounds))) {
        //asteroid will bounce off left or right edge of View.
        asteroid.dx = -asteroid.dx;
    }
    
    if (!CGRectEqualToRect(vertical, CGRectIntersection(vertical, self.bounds))) {
        //asteroid will bounce off top or bottom edge of View.
        asteroid.dy = -asteroid.dy;
    }
    
    //If the ship hits an asteroid end the game currently
    if (CGRectIntersectsRect(asteroid.frame, ship.frame)) {
        
        [self endGame];
    }
}

- (void) endGame {
    
    [self.controller.displayLink invalidate];
    
    CGRect g = CGRectMake (
                           self.bounds.size.width/2-100,
                           self.bounds.size.height/2-30,
                           200,
                           60
                           );
    gameover = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gameover.frame = g;
    //[gameover setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gameover setTitle: @"Game Over...Play Again?" forState:UIControlStateNormal];
    
    [gameover addTarget: self
                 action: @selector(resetGame:)
       forControlEvents: UIControlEventTouchUpInside
     ];
    
    [self addSubview:gameover];
    
    if (fueltank < highscore) {
        
        highscore = fueltank;
    }
    
    //[self resetGame];
}

- (void) resetGame: (id) sender {
    
    // generate random starting point
    asteroid1.center = CGPointMake(arc4random()%(100-30)+30, arc4random()%(100-30)+30);
    asteroid2.center = CGPointMake(arc4random()%(300-200)+200, arc4random()%(400-300)+300);
    fueltank = 100;
    fuel.text = [NSString stringWithFormat:
                 @"Current Fuel: %d",
                 fueltank];
    score.text = [NSString stringWithFormat:@"Best Score: %d", highscore];
    
    ship.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    [gameover removeFromSuperview];
    
    [self.controller setupDisplayLink];
    
}

@end