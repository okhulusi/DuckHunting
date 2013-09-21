//
//  Dog.h
//  duckhunt
//
//  Created by Omar Khulusi on 9/13/13.
//
//

#import "CCSprite.h"
#import "cocos2d.h"

enum DogState{
    Duck1,
    Ducks2,
    Laughing
};

@interface Dog : CCSprite
{
}

@property enum DogState m_AnimState;

- (void) setupAnim;

- (void) showDog:(enum DogState)state;

@end
