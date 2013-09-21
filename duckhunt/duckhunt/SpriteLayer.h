//
//  DuckLayer.h
//  duckhunt
//
//  Created by Omar Khulusi on 9/4/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "Duck.h"
#import "SimpleAudioEngine.h"

@interface SpriteLayer : CCLayer
{
    NSMutableArray *m_duckArray;
    CGPoint centerScreen;
}

@property BOOL isWaveOver;
@property int numBullets;
@property int numDeadDucksWave;
@property int currDuckSpeed;

- (void) update:(ccTime)dt;

- (void) spawnDuck;

- (void) startWave;

- (void) endWave;

- (void) clearDuckArray;

- (void) dealloc;

@end
