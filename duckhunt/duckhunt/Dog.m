//
//  Dog.m
//  duckhunt
//
//  Created by Omar Khulusi on 9/13/13.
//
//

#import "Dog.h"
#import "SimpleAudioEngine.h"

@implementation Dog

@synthesize m_AnimState;

- (id) init{
    if(self = [super init]){
        
         [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sprites.plist"];
    
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        self.position = ccp(size.width/2, 0);
        [self setVisible:NO];
    }
    return self;
}

- (void) setupAnim{
    NSMutableArray* files;
    if(m_AnimState == Duck1){
        files = [NSMutableArray arrayWithObjects: @"dog-caught-00.png", nil];
    } else if(m_AnimState == Ducks2){
        files = [NSMutableArray arrayWithObjects: @"dog-caught-01.png", nil];
    } else{
        files = [NSMutableArray arrayWithObjects: @"dog-laugh-00.png", @"dog-laugh-01.png", nil];
    }
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < files.count; i++){
        NSString* file = [files objectAtIndex:i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                spriteFrameByName:file];
        [frames addObject:frame];
    }
    
    [self stopAllActions];
    
    CCAnimation* anim = [CCAnimation animationWithSpriteFrames:frames
                                                         delay:0.15f];
    CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
    CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
    [self runAction:repeat];

    [self setVisible:YES];
}

- (void) showDog:(enum DogState)state
{
    m_AnimState = state;
    [self setupAnim];
    
    if(m_AnimState == Laughing){
        [[SimpleAudioEngine sharedEngine] playEffect:@"dog_laugh.wav"];
    }
    
    [self runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(0,80)]];
    [self scheduleOnce:@selector(hideDog) delay:2.5f];
}

- (void) hideDog{
    [self runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(0,-80)]];
}

@end
