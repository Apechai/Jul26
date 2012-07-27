//
//  Asteroid.m
//  Jul26
//
//  Created by Matthew Fong on 7/26/12.
//  Copyright (c) 2012 Goldman Sachs. All rights reserved.
//

#import "Asteroid.h"
#import <QuartzCore/QuartzCore.h>

@implementation Asteroid

@synthesize color;
@synthesize dx;
@synthesize dy;

- (id) initWithFrame: (CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor blackColor];
        
        
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 3.0f;
        self.color = YES;
        self.dx = 1.5;
        self.dy = 1.5;
        
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void) drawRect: (CGRect) rect
 {
 // Drawing code
 }
 */


@end