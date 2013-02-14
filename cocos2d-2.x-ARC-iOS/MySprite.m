//
//  MySprite.m
//  cocos2d-2.x-ARC-iOS
//
//  Created by KazukiKubo on 2013/02/14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MySprite.h"


@implementation MySprite

-(id)init {
    if (self = [super init]) {
    }
    return self;
}

-(void)onEnter {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}

-(void)onExit {
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

#pragma cocos2d touch event handler
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    BOOL isTouched = [self isTouched:touch];
    if (isTouched) {
        self.position = [self getTouchPoint:touch];
    }
    self.isTouchBegan = isTouched;
    return isTouched;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    self.position = [self getTouchPoint:touch];
    NSLog(@"touch moved : %f, %f", self.position.x, self.position.y);
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
}

// 自身の領域にあるかどうかを判定するメソッド
-(BOOL)isTouched:(UITouch*)touch {
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    CGRect rect = [self boundingBox];

    return CGRectContainsPoint(rect, touchPoint);
}

// 座標変換君
-(CGPoint)getTouchPoint:(UITouch*)touch {
    CGPoint touchPoint = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchPoint];
}

@end
