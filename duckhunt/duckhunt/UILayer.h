//
//  UILayer.h
//  duckhunt
//
//  Created by Omar Khulusi on 9/11/13.
//
//

#import "CCLayer.h"
#import "CCLabelTTF.h"
#import "cocos2d.h"

@interface UILayer : CCLayer
{
    CCLabelTTF* m_RoundLabel;
    CCLabelTTF* m_WaveLabel;
}

@property CCLabelTTF* m_GameOverLabel;

-(void) showRoundLabel:(int)num;
-(void) hideRoundLabel;
-(void) showWaveLabel:(int)num;
-(void) hideWaveLabel;

@end
