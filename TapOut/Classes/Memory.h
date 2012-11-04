//
//  MemoryStruct.h
//  TapOut
//
//  Created by CSE483W on 10/31/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdlib.h>

@interface Memory : NSObject{
    
}

@property int userMode;
@property int MAX;
@property int index;
@property int playerPos;        // number 0-3 indicating position
extern NSInteger array[];

- (int)startGame;
- (int)addRandom:(NSInteger[])arr;
- (void)deleteValues;
- (int)getValue:(int)index;

@end
