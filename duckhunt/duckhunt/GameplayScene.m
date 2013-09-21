//
//  GameplayScene.m
//  duckhunt
//
//  Created by Omar Khulusi on 8/28/13.
//
//

#import "GameplayScene.h"
#import "SimpleAudioEngine.h"

@implementation GameplayScene

@synthesize wave;
@synthesize round;
@synthesize deadDucksThisRound;

- (id)init
{
    self = [super init];
    [self scheduleUpdate];
    
    if (self) {
        
        wave = 0;
        round = 0;
        deadDucksThisRound = 0;
        
        skyLayer = [SkyLayer node];
        [self addChild: skyLayer z:0];
        
        groundLayer = [GroundLayer node];
        [self addChild: groundLayer z:1];
        
        spriteLayer = [SpriteLayer node];
        [self addChild: spriteLayer z:2];
        
        uilayer = [UILayer node];
        [self addChild: uilayer z:4];
        
        [self startRoundBreak];
    }
    return self;
}

- (void) update:(ccTime)dt{
    [spriteLayer update:dt];
    
    if(m_state == Wave && spriteLayer.isWaveOver){
        [self startWaveBreak];
    }
}

- (void) startRoundBreak{
    m_state = RoundBreak;
    round++;
    
    wave = 0;
    deadDucksThisRound = 0;
    
    spriteLayer.currDuckSpeed = 200 + (round - 1) * 50;
    [uilayer showRoundLabel:round];
    [uilayer hideWaveLabel];
    
    [self scheduleOnce:@selector(startWave) delay:5.0];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:
     @"next_round_music.mp3" loop:NO];
    
}

- (void) startWave{
    m_state = Wave;
    wave++;
    [spriteLayer startWave];
    [self schedule:@selector(duckQuack) interval:0.25f];
    
    [uilayer hideWaveLabel];
    [uilayer hideRoundLabel];
}

- (void) startWaveBreak{
    m_state = WaveBreak;
    
    [self unschedule:@selector(duckQuack)];
    
    deadDucksThisRound+=spriteLayer.numDeadDucksWave;
    
    [spriteLayer clearDuckArray];
    
    
//    [uilayer showWaveLabel:uilayer.wave];
    
    if(wave == 5){
        if(deadDucksThisRound < 6){
            [self startGameOver];
            return;
        } else{
            [self scheduleOnce:@selector(startRoundBreak) delay:3.0];
        }
    } else{
        [self scheduleOnce:@selector(startWave) delay:3.0];
    }
    
    if(spriteLayer.numDeadDucksWave == 0){
        [skyLayer.m_Dog showDog:Laughing];
    } else if(spriteLayer.numDeadDucksWave == 1){
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:
         @"got_ducks_music.mp3" loop:NO];
        
        [skyLayer.m_Dog showDog:Duck1];
    } else {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:
         @"got_ducks_music.mp3" loop:NO];
        
        [skyLayer.m_Dog showDog:Ducks2];
    }
}

- (void) startGameOver{
    [uilayer hideWaveLabel];
    [uilayer.m_GameOverLabel setVisible:YES];
    
    [skyLayer.m_Dog showDog:GameOver];
    
    [self scheduleOnce:@selector(exitScene) delay:3.0];
}

- (void) exitScene{
    m_state = GameOver;
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:
     @"game_over_music.mp3" loop:NO];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[MainMenuLayer scene]]];
}

- (void) duckQuack{
    [[SimpleAudioEngine sharedEngine] playEffect:@"duck_quack.wav"];
}

@end
