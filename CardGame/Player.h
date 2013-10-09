//
//  Player.h
//  CardGame
//
//  Created by Danny Deng on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Player : NSObject
{
    NSMutableArray * _pack ;
    int gameScore ;
    int points ;
}
@property (nonatomic,assign,getter = gameScore,setter = setGameScore:) int gameScore;
@property (nonatomic,assign,getter = points,setter = setPoints:) int points;
@property (nonatomic,retain) NSMutableArray *pack;

- ( void )add: ( Card *) c;
- ( void )remove : ( int) n;
- ( Card *)show : ( int) n; // returns the ith card
- ( Card *)play : ( int) n; // returns the ith card and removes it from pack

@end