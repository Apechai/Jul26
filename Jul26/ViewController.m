//
//  ViewController.m
//  Jul26
//
//  Created by Matthew Fong on 7/26/12.
//  Copyright (c) 2012 Goldman Sachs. All rights reserved.
//

#import "ViewController.h"
#import "View.h"
#import <QuartzCore/QuartzCore.h> //for CADisplayLink


@interface ViewController ()

@end

@implementation ViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
// self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
// if (self) {
// // Custom initialization
// }
// return self;
//}

@synthesize displayLink;

- (void) didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void) loadView
{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self.view = [[View alloc] initWithFrame: frame controller:self];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupDisplayLink];
    
}

- (void)setupDisplayLink
{
    displayLink = [CADisplayLink displayLinkWithTarget: self.view
                                              selector: @selector(move:)
                   ];
    
    //Call move: every time the display is refreshed.
    displayLink.frameInterval = 1;
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [displayLink addToRunLoop: loop forMode: NSDefaultRunLoopMode];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc {
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [displayLink removeFromRunLoop: loop forMode: NSDefaultRunLoopMode];
}

@end