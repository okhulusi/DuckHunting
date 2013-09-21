//
//  UILayer.m
//  duckhunt
//
//  Created by Omar Khulusi on 9/11/13.
//
//

#import "UILayer.h"

@implementation UILayer

@synthesize m_GameOverLabel;

-(id) init{
    if( (self=[super init]) ){
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        m_RoundLabel = [CCLabelTTF labelWithString:@"Round 1" fontName:@"Marker Felt" fontSize:30];
        m_RoundLabel.position = ccp(size.width/2, size.height/2);
        m_RoundLabel.visible = NO;
        [self addChild: m_RoundLabel];
        
        m_WaveLabel = [CCLabelTTF labelWithString:@"Got 2/2 Ducks!"
                                         fontName:@"Marker Felt" fontSize:26];
        m_WaveLabel.position = ccp(size.width/2, size.height/2);
        m_WaveLabel.visible = NO;
        [self addChild: m_WaveLabel];
        
        m_GameOverLabel = [CCLabelTTF labelWithString:@"Game Over"
                                         fontName:@"Marker Felt" fontSize:26];
        m_GameOverLabel.position = ccp(size.width/2, size.height/2);
        m_GameOverLabel.visible = NO;
        [self addChild: m_GameOverLabel];
    }
    return self;
}

-(void) showRoundLabel:(int)num{
    m_RoundLabel.string = [NSString stringWithFormat:@"Round %d", num];
    m_RoundLabel.visible = YES;
}
-(void) hideRoundLabel{
    m_RoundLabel.visible = NO;
}
-(void) showWaveLabel:(int)num{ // might need to change
    m_WaveLabel.string = [NSString stringWithFormat:@"Got %d/2 ducks!", num];
    m_WaveLabel.visible = YES;
}
-(void) hideWaveLabel{
    m_WaveLabel.visible = NO;
}

@end
