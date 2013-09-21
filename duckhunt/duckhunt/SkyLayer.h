//
//  HelloWorldLayer.h
//  duckhunt
//
//  Created by Sanjay Madhav on 8/8/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Dog.h"

// HelloWorldLayer
@interface SkyLayer : CCLayerColor
{
}

@property Dog* m_Dog;

- (void) showDog:(enum DogState)state;

@end
