//
//  Duck.m
//  duckhunt
//
//  Created by Omar Khulusi on 9/6/13.
//
//

#import "Duck.h"

@implementation Duck
@synthesize direction = m_Direction;
@synthesize speed;
@synthesize m_animState;

- (id) init{
    if(self = [super initWithFile:(@"duck.png")]){
        self.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        //speed = 200;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sprites.plist"];
    }
    return self;
}

- (void) update:(ccTime)dt{
    
    if(self.position.x > [[CCDirector sharedDirector] winSize].width){
        self.position = ccp([[CCDirector sharedDirector] winSize].width,self.position.y);

        m_Direction.x*=-1;
        self.flipX = YES;
        
        [self setupAnim];
    } else if(self.position.x < 0){
        self.position = ccp(0, self.position.y);
        
        m_Direction.x*=-1;
        self.flipX = NO;
        
        [self setupAnim];
    } else if(self.position.y > [[CCDirector sharedDirector] winSize].height){
        self.position = ccp(self.position.x,[[CCDirector sharedDirector] winSize].height);
        
        m_Direction.y*=-1;
        
        [self setupAnim];
    } else if(self.position.y < 0){
        self.position = ccp(self.position.x, 0);
        
        m_Direction.y*=-1;
        
        [self setupAnim];
    } else{
        self.position = ccpAdd(self.position, ccpMult(m_Direction,speed*dt));
    }
}

- (CGRect) rect{
    return CGRectMake(self.position.x - self.contentSize.width * self.anchorPoint.x, self.position.y - self.contentSize.height * self.anchorPoint.y, self.contentSize.width, self.contentSize.height);
}

- (void) setupAnim{
    CGPoint upVector = CGPointMake(0.0, 1.0);
    CGFloat dotProduct = ccpDot(upVector,m_Direction);
    
    NSMutableArray* files;
    if(dotProduct > 0.7){
        if(m_animState == Animation1){
            return;
        }
        files = [NSMutableArray arrayWithObjects: @"duck-06.png", @"duck-07.png", @"duck-08.png", nil];
        m_animState = Animation1;
    } else if(dotProduct > 0.2){
        if(m_animState == Animation2){
            return;
        }
        files = [NSMutableArray arrayWithObjects: @"duck-03.png", @"duck-04.png", @"duck-05.png", nil];
        m_animState = Animation2;
    } else{
        if(m_animState == Animation3){
            return;
        }
        files = [NSMutableArray arrayWithObjects: @"duck-00.png", @"duck-01.png", @"duck-02.png", nil];
        m_animState = Animation3;
    }
        NSMutableArray* frames = [NSMutableArray arrayWithCapacity:10];
    
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
}

@end
