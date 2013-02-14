//
//  MultiTouchSprite.m
//  cocos2d-2.x-ARC-iOS
//
//  Created by KazukiKubo on 2013/02/14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MultiTouchSprite.h"


@implementation MultiTouchSprite

-(id)init {
    if (self = [super init]) {
    }
    return self;
}

-(void)onEnter {
    [[[CCDirector sharedDirector] touchDispatcher] addStandardDelegate:self priority:0];
    [super onEnter];
}

-(void)onExit {
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

#pragma cocos2d touch event handler
//-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
//    BOOL isTouched = [self isTouched:touch];
//    if (isTouched) {
//        self.position = [self getTouchPoint:touch];
//    }
//    return isTouched;
//}
//
//-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
//    self.position = [self getTouchPoint:touch];
//    NSLog(@"touch moved : %f, %f", self.position.x, self.position.y);
//}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    isTouchesBegan = NO;
    // unko 同じ制御構文を書かないといけない。。。
    NSSet *allTouches = [event allTouches];
    for (UITouch *touch in allTouches) {
        if ([self isTouched:touch]) {
            NSLog(@"touches began");
            isTouchesBegan = YES;
        }
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isTouchesBegan) {
        NSLog(@"touches moved");
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // unko 同じ制御構文を書かないといけない。。。
    NSSet *allTouches = [event allTouches];
    for (UITouch *touch in allTouches) {
        if ([self isTouched:touch]) {
            NSLog(@"touches ended");
        }
    }
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
