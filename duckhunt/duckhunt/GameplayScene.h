//
//  GameplayScene.h
//  duckhunt
//
//  Created by Omar Khulusi on 8/28/13.
//
//

#import "CCScene.h"
#import "Skylayer.h"
#import "GroundLayer.h"
#import "SpriteLayer.h"
#import "UILayer.h"
#import "MainMenuLayer.h"
#import "cocos2d.h"

enum GameState
{
    RoundBreak = 0,
    Wave,
    WaveBreak,
    GameOver
};

@interface GameplayScene : CCScene
{
    SkyLayer *skyLayer;
    GroundLayer *groundLayer;
    SpriteLayer *spriteLayer;
    UILayer *uilayer;
    
    enum GameState m_state;
}

@property int round;
@property int wave;
@property int deadDucksThisRound;

- (void) update:(ccTime)dt;

- (void) startRoundBreak;
- (void) startWave;
- (void) startWaveBreak;
- (void) startGameOver;
- (void) exitScene;

- (void) duckQuack;

@end
