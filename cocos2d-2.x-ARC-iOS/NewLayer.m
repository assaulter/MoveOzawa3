//
//  NewLayer.m
//  cocos2d-2.x-ARC-iOS
//
//  Created by KazukiKubo on 2013/02/14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "NewLayer.h"

@implementation NewLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	NewLayer *layer = [NewLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init {
    if (self = [super init]) {
        UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(makeRotate:)];
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(makepinch:)];
        [[[CCDirector sharedDirector] view] addGestureRecognizer:pinch];
        [[[CCDirector sharedDirector] view] addGestureRecognizer:rotate];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        MySprite *ozawa = [[MySprite alloc] initWithFile:@"ozawa.jpg"];
        ozawa.position = ccp( screenSize.width/2 , screenSize.height /2);
        [self addChild:ozawa];
        
        MySprite *ozawa2 = [[MySprite alloc] initWithFile:@"ozawa.jpg"];
        ozawa2.position = ccp( screenSize.width/2 + 100 , screenSize.height /2 + 100);
        [self addChild:ozawa2];
        
        MySprite *ozawa3 = [[MySprite alloc] initWithFile:@"ozawa.jpg"];
        ozawa3.position = ccp( screenSize.width/2 - 100 , screenSize.height /2 - 100);
        [self addChild:ozawa3];
        
        ozawas = [[NSArray alloc]initWithObjects:ozawa, ozawa2, ozawa3, nil];
    }
    return self;
}

// runActionを入れ替えることで、なんでも出来る予感。
//-(void)ozawaRotate {
//    id rotateTo = [CCRotateTo actionWithDuration:2 angle:61.0f];
//    [ozawa runAction:[CCSequence actions:rotateTo, nil]];
//}

// 拡大縮小イベント
-(void)makepinch:(UIPinchGestureRecognizer*)pinch {
    NSLog(@"pinch scale % f", pinch.scale);
    if(pinch.state == UIGestureRecognizerStateEnded) {
        [self getActiveSprite].scale = pinch.scale;
    } else if (pinch.state == UIGestureRecognizerStateBegan) {
        pinch.scale = [self getActiveSprite].scale;
    }
}

// 回転イベント
-(void)makeRotate:(UIRotationGestureRecognizer*)rotate {
    NSLog(@"rotatin rad = %f, velocity = %f", rotate.rotation, rotate.velocity);
    if (rotate.state == UIGestureRecognizerStateEnded) {
        // ozawaを回転させる
        id rotateTo = [CCRotateTo actionWithDuration:0 angle:[self radianToAngle:rotate.rotation]];
        [[self getActiveSprite] runAction:[CCSequence actions:rotateTo, nil]];
    } else if (rotate.state == UIGestureRecognizerStateBegan) {
        // ozawaの回転角を得る
        rotate.rotation = [self angleToRadian:[self getActiveSprite].rotation];
    }
}

// 操作領域にあるspriteを返すメソッド
-(CCSprite*)getActiveSprite {
    MySprite *activeOzawa = nil;
    for (MySprite *ozawa in ozawas) {
        if (ozawa.isTouchBegan) {
            activeOzawa = ozawa;
        }
    }
    return activeOzawa;
}

// ラジアン to 角度(適当)
-(CGFloat)radianToAngle:(CGFloat)radian {
    return (radian * 180)/3.1;
}
// 角度 to ラジアン(適当)
-(CGFloat)angleToRadian:(CGFloat)angle {
    return (angle * 3.1)/180;
}

@end
