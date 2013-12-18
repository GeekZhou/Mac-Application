//
//  AppDelegate.h
//  CardGame
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GameViewController.h"
#import "Game.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    Game *_game;
    
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)setUpButtonAction:(id)sender;
- (IBAction)playGameButtonAction:(id)sender;

@end
