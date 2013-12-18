//
//  Player.m
//  Briscola
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize gameScore = _gameScore;
@synthesize points = _points;
@synthesize pack;

- (id) init {
    // allow superclass to initialise its state first
    if ( self = [ super init ]) {
        // do other initialisation ...
        pack = [[ NSMutableArray alloc ] init ];
    }
    return self ;
}

- ( void ) add :( Card *)c {
    [ pack addObject :c];
}

- ( void ) remove : ( int) n {
    if (n >=0 && n <[ pack count]){
        Card *card = [pack objectAtIndex:n];
        if (card) {
            [pack removeObject:card];
        }
    } 
}


- ( Card *) show : ( int) n {
    return ( Card *)[ pack objectAtIndex :n];
}

- ( Card *) play : ( int) n {
    Card * c = [pack objectAtIndex :n];
    //    [ self remove :n]; // delete card from pack
    return c;
}

- (void)dealloc {
    [pack release];
    [super dealloc];
}

@end
