//
//  AppDelegate.m
//  CardGame
//
//  Created by Danny Deng on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc {
    [_game release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    _game = [[Game alloc] init];
}



- (IBAction)setUpButtonAction:(id)sender {
    [_game setupGame];
}

- (IBAction)playGameButtonAction:(id)sender {
    [_game playGame];
    
    GameViewController *gameViewController = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
//    [self.window setContentView:gameViewController.view];
}

@end
