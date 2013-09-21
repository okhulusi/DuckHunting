//
//  GroundLayer.m
//  duckhunt
//
//  Created by Omar Khulusi on 9/4/13.
//
//

#import "GroundLayer.h"

@implementation GroundLayer

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
	{
		
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *background;
		background = [CCSprite spriteWithFile:@"game_background.png"];
		
		background.position = ccp(size.width/2, size.height/2);
		
		// add the image as a child to this Layer
		[self addChild: background];
        
	}
	return self;
}
@end
