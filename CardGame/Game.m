//
//  Game.m
//  Briscola
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define Card_Type_1 @"Spade"
#define Card_Type_2 @"Denari"
#define Card_Type_3 @"Coppe"
#define Card_Type_4 @"Bastoni"
    
#import "Game.h"

@implementation Game
@synthesize playerP = _playerP;
@synthesize playerQ = _playerQ;

#pragma mark - private

- (BOOL)judgeCard:(Card *) card otherCard:(Card *) otherCard {
    //如果两个玩家打出同样的花色,那么面值大的玩家得一分
    if ([[card suit] isEqualToString:[otherCard suit]]) {
        return ([card value] > [otherCard value]) ? YES : NO;
    } else {
        if ([[card suit] isEqualToString:_briscola] || [[otherCard suit] isEqualToString:_briscola]) {
            //如果两个玩家打出的花色不一样,那么打出 Briscola 花色的得一分
            return [[card suit] isEqualToString:_briscola] ? YES : NO;
        } else {
            //如果两个玩家打出的花色不一样,而且花色都不是 Briscola,那么这一轮的得分人将
           //由投掷硬币来决定。(实现的时候可以生成随机数,50%概率)
            char random = rand() % 2;
            return (random == 1) ? YES : NO;
        }
    }

    return NO;
}

- (void)initPlayer {
    _playerP = [[Player alloc] init];
    _playerQ = [[Player alloc] init];
}

- (void)initCards {
    //初始牌
    int cardIndex = 0;
    for (int i = 1; i <= 10; i++) {
        for (int j = 1; j <= 4; j++) {
            Card *card = [[Card alloc] init];
            
            if (j == 1) {
                [card setSuit:Card_Type_1];
            } else if (j == 2) {
                [card setSuit:Card_Type_2];
            } else if (j == 3) {
                [card setSuit:Card_Type_3];
            } else {
                [card setSuit:Card_Type_4];
            }
            [card setValue:i];
            totalCard[cardIndex++] = card;
        }
    }
}

- (void)kunthCard {
    for (int i = 39; i >= 0; i--) {
        int randomIndex;
        if (i==0) {
            randomIndex = random() % 1;
        }else {
            randomIndex = random() % i;
        }
        
        Card *firstCard = totalCard[i];
        totalCard[i] = totalCard[randomIndex];
        totalCard[randomIndex] = firstCard;
    }
}

-(void)dealCards {
    //发牌
    [[_playerP pack] removeAllObjects];
    [[_playerQ pack] removeAllObjects];
    for (int i = 0; i < 40; i++) {
        Card *card = totalCard[i];
        if (i % 2 == 0) {
            [_playerP add:card];
        } else {
            [_playerQ add:card];
        }
    }
}

- (void)showPlayerCards:(Player *)player {
    for (int i = 0; i < [[player pack]count]-1; i++) {
        Card *card = [player show:i];
         printf("index %i cardValue: %i %s \n",i ,[card value],[[card suit] UTF8String]);
    }
}

- (int)getPlayerPCard {
    int inputIndexP = -1;
   [self showPlayerCards:_playerP];
    while (inputIndexP < 0 || inputIndexP > ([[_playerP pack]count]-1)) {
        printf("\nPlease input the Player P card index from 0 -> %lu:\n",([[_playerP pack] count]-1));
        scanf("%i",&inputIndexP);
    }
    return inputIndexP;
}

- (int)getPlayerQCard {
    int inputIndexQ = -1;
    [self showPlayerCards:_playerQ];
    while (inputIndexQ < 0 || inputIndexQ > ([[_playerQ pack]count]-1)) {
        printf("\nPlease input the Player Q card index from 0 -> %lu:\n",([[_playerQ pack]count]-1));
        scanf("%i",&inputIndexQ);
    }
    return inputIndexQ;
}

- (void)gameProcess {
    int round = 1;
    while (true) {
       printf("round %i\n\n",round++);
        [_playerP setGameScore:0];
        [_playerQ setGameScore:0];
        //洗牌
        [self kunthCard];
        
        //发牌
        [self dealCards];
        
        //选择Briscola花色
        [self initBriscola];
        
        for (int i = 0; i < 20; i++) { 
            int inputIndexP = -1;
            int inputIndexQ =  -1;

            if (_isPlayerQFirst) {
                inputIndexQ = [self getPlayerQCard];
                inputIndexP = [self getPlayerPCard];
            } else {
                inputIndexP = [self getPlayerPCard];
                inputIndexQ = [self getPlayerQCard];
            }

            Card *pCard = [_playerP play:inputIndexP];
            Card *qCard = [_playerQ play:inputIndexQ];
            BOOL isPWin = [self judgeCard:pCard otherCard:qCard];
            
            if (isPWin) {
                [_playerP setGameScore:[_playerP gameScore] + 1];
            } else {
                [_playerQ setGameScore:[_playerQ gameScore] + 1];
            }
            printf("PlayerP Score %i; PlayerQ Score %i\n\n",[_playerP gameScore],[_playerQ gameScore]);
            [_playerP remove:inputIndexP];
            [_playerQ remove:inputIndexQ];
        }
        
        if ([_playerP gameScore] > [_playerQ gameScore]) {
            [_playerP setPoints:[_playerP points]+1];
        } else {
            [_playerQ setPoints:[_playerQ points]+1];
        }
        printf("PlayerP points %i; PlayerQ points %i\n\n",[_playerP points],[_playerQ points]);
        
        if ([_playerP points] >= 3 || [_playerQ points] >= 3) {
            break;
            return;
        }
         _isPlayerQFirst = !_isPlayerQFirst;
    }
}

- (void)showTheResult {
    if ([_playerP points] > [_playerQ points]) {
        printf("\n\n\nPlayerP:PlayerQ %i:%i PlayerP Win the Game \n\n",[_playerP points],[_playerQ points]);
    } else {
        printf("\n\n\nPlayerP:PlayerQ %i:%i PlayerQ Win the Game \n\n",[_playerP points],[_playerQ points]);
    }
}

-(void)initBriscola {
     int tmp = (random() % 4 + 1);

    if (tmp == 1) {
        _briscola = Card_Type_1;
    } else if (tmp == 2) {
        _briscola = Card_Type_2;
    } else if (tmp == 3) {
       _briscola = Card_Type_3;
    } else if (tmp == 4) {
        _briscola = Card_Type_4;
    }
    
    printf("The  briscol is Spade %s \n",[_briscola UTF8String]);
}

#pragma mark - call the function to start the game

- (void)setupGame {
    [self initCards];
    [self initPlayer];
}

- (void)playGame {
    //游戏过程
    [self gameProcess];
    
    //显示游戏结果
    [self showTheResult];
    
    //退出游戏
    printf("Do you want to quit the Game? input the 0 to exit!");
    int isQuit = 1;
    while (isQuit != 0) {
        scanf("%i",&isQuit);
    }
    
    //释放内存
    for (int i = 0;i<40;i++) {
        Card *card = totalCard[i];
        [card release];
    }
    
    [_playerP release];
    _playerP = nil;
    
    [_playerQ release];
    _playerQ = nil;
}

#pragma mark - lifecycle

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)dealloc {
    
    //释放内存
    if (_playerP) {
        [_playerP release];
    }
    
    if (_playerQ) {
        [_playerQ release];
    }
    
    for (int i = 0;i<40;i++) {
        Card *card = totalCard[i];
        [card release];
    }
    
    [super dealloc];
}

@end
