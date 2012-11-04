//
//  MemoryStruct.m
//  TapOut
//
//  Created by CSE483W on 10/31/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import "MemoryStruct.h"


@implementation Memory

@synthesize userMode;
@synthesize MAX;

- (int)startGame           // do we need to save user's mode in this class?
{
    MAX = 20;
    
    //Test
                        // to add element: [array addObject: @"color"];
                        // to insert     : [array insertObject: @..];
    
    _index = 0;
    _playerPos = -1;
    
    int ret = [self addRandom:array];
    return ret;
    
}

- (int)addRandom:(NSInteger[])arr
{
    arr[_index] = rand() % 4;       // random number 0-3
    _index += 1;
    return arr[_index-1];
}

- (void) deleteValues // delete array
{
    for(int i = 0; i < 20; i++)
        array[i] = -1;
}

- (int)getValue:(int)index
{
    return array[index];
}



@end
