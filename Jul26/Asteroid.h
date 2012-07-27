//
//  Asteroid.h
//  Jul26
//
//  Created by Matthew Fong on 7/26/12.
//  Copyright (c) 2012 Goldman Sachs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Asteroid : UIView {
    
    BOOL color;
    CGFloat dx;
    CGFloat dy;
}

@property BOOL color;
@property CGFloat dx, dy;

@end