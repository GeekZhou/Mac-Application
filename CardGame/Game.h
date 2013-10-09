//
//  Game.h
//  Briscola
//
//  Created by Danny Deng on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Card.h"
#import "Player.h"
#import <stdio.h>

@interface Game : NSObject {
    Player *_playerP;
    Player *_playerQ;
    Card *totalCard[40];
    NSString *_briscola;
    BOOL _isPlayerQFirst;
}
@property (nonatomic,retain) Player *playerP;
@property (nonatomic,retain) Player *playerQ;

- (void)setupGame;
- (void)playGame;


- (BOOL)judgeCard:(Card *) card otherCard:(Card *) otherCard;
- (void)initPlayer;
- (void)initCards;
- (void)kunthCard;
- (void)dealCards;
- (void)showPlayerCards:(Player *)player;
- (int)getPlayerPCard;
- (int)getPlayerQCard;
- (void)showTheResult;
-(void)initBriscola;
- (void)gameProcess;

@end
