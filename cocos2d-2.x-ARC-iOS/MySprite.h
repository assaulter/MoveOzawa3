//
//  MySprite.h
//  cocos2d-2.x-ARC-iOS
//
//  Created by KazukiKubo on 2013/02/14.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// シングルタップを受け付けるSprite
@interface MySprite : CCSprite<CCTargetedTouchDelegate> {
}
// このスプライト内をタッチしているかどうかのフラグ
@property (assign, nonatomic) BOOL isTouchBegan;

@end
