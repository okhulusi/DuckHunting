//
//  DuckLayer.m
//  duckhunt
//
//  Created by Omar Khulusi on 9/4/13.
//
//

#import "SpriteLayer.h"

@implementation SpriteLayer
@synthesize isWaveOver;
@synthesize numBullets;
@synthesize numDeadDucksWave;
@synthesize currDuckSpeed;

-(id) init{
    if( (self=[super init]) ){
        self.isTouchEnabled = YES;
        
        isWaveOver = YES;
        numBullets = 3;
        numDeadDucksWave = 0;
        currDuckSpeed = 200;
        
        
        m_duckArray = [[NSMutableArray alloc] init];
        centerScreen = ccp([[CCDirector sharedDirector] winSize].width/2,[[CCDirector sharedDirector] winSize].height/2);
 
      // [self schedule:@selector(spawnDuck) interval:2.0];
    }
    
    return self;
}

- (void) registerWithTouchDispatcher{
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(!isWaveOver){
        CGPoint location = [self convertTouchToNodeSpace: touch];
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"shot.wav"];
        for(Duck* duck in m_duckArray) // might want to change to a standard for loop
        {
            if(CGRectContainsPoint(duck.rect, location))
            {
                [self removeChild:duck cleanup:YES];
                [m_duckArray removeObject:duck];
                numDeadDucksWave++;
                break;
            }
        }
        numBullets--;
        
        if(numBullets == 0 || numDeadDucksWave == 2){
            [self endWave];
        }
    }
    
    return YES;
}

- (void) update:(ccTime)dt{
    for (Duck* duck in m_duckArray)
    {
        [duck update:dt];
    }
}

- (void) spawnDuck{
    
    int spawnTimer = arc4random() % 4;
    
    Duck *duck = [Duck node];
    duck.speed = currDuckSpeed;
    
    if(spawnTimer == 0){ //spawn left edge
        duck.position = ccp(duck.contentSize.width/2, arc4random() % (int)[[CCDirector sharedDirector] winSize].height);
    } else if(spawnTimer == 1){ // spawn right edge
        duck.position = ccp((int)[[CCDirector sharedDirector] winSize].width - duck.contentSize.width/2, arc4random() % (int)[[CCDirector sharedDirector] winSize].height);
    } else if(spawnTimer == 2){ //spawn top edge
        duck.position = ccp(arc4random() % (int)[[CCDirector sharedDirector] winSize].width, (int)[[CCDirector sharedDirector] winSize].height - duck.contentSize.height/2);
    } else if(spawnTimer == 3){ // spawn top edge
        duck.position = ccp(arc4random() % (int)[[CCDirector sharedDirector] winSize].width, duck.contentSize.height/2);
    }
    
    duck.direction = ccpNormalize(ccpSub(centerScreen, duck.position));
    if(duck.direction.x < 0){
        duck.flipX = YES;
    }
    
    [duck setupAnim];
    
    [m_duckArray addObject:duck];
    [self addChild:duck];
   
    if (m_duckArray.count > 5)
    {
        [self removeChild:[m_duckArray objectAtIndex:0] cleanup:YES];
        [m_duckArray removeObjectAtIndex:0];
    }
}

- (void) startWave{
    isWaveOver = NO;
    numBullets = 3;
    numDeadDucksWave = 0;
    
    while([m_duckArray count] > 0){
        [self removeChild:[m_duckArray objectAtIndex:0] cleanup:YES];
        [m_duckArray removeObjectAtIndex:0];
    }
    
    //SPAWN TWO DUCKS
    [self spawnDuck];
    [self spawnDuck];
    
    [self scheduleOnce:@selector(endWave) delay:8.0];
}

- (void) endWave{
    [self unschedule:@selector(endWave)];
    isWaveOver = YES;
}

- (void) clearDuckArray{
    while([m_duckArray count] > 0){
        [self removeChild:[m_duckArray objectAtIndex:0] cleanup:YES];
        [m_duckArray removeObjectAtIndex:0];
    }
}

- (void) dealloc{
    [m_duckArray dealloc];
    
   // [self dealloc];
    [super dealloc];
}

@end
