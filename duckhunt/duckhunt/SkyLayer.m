//
//  HelloWorldLayer.m
//  duckhunt
//
//  Created by Sanjay Madhav on 8/8/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "SkyLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - SkyLayer

// HelloWorldLayer implementation
@implementation SkyLayer

@synthesize m_Dog;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super initWithColor: ccc4(0,191,255,255)]) )
	{
        m_Dog = [Dog node];
        [self addChild:m_Dog];
            
		// ask director for the window size
		// be sure to implement different layers such that this image is ranked 4TH (i.e. background)
    
		//
		// Leaderboards and Achievements
		//
		
		
	}
	return self;
}

- (void) showDog:(enum DogState)state
{
    [m_Dog showDog:state];
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
