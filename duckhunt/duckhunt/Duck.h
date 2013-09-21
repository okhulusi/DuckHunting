//
//  Duck.h
//  duckhunt
//
//  Created by Omar Khulusi on 9/6/13.
//
//

#import "CCSprite.h"
#import "cocos2d.h"

enum DuckAnimation{
    Animation1,
    Animation2,
    Animation3
};

@interface Duck : CCSprite
{
    CGPoint m_Direction;
    int speed;
}

@property enum DuckAnimation m_animState;
@property int speed;
@property CGPoint direction;

- (void) update:(ccTime)dt;
- (CGRect) rect;
- (void) setupAnim;

@end
