//
//  MemoryStruct.m
//  TapOut
//
//  Created by CSE483W on 10/31/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import "MemoryStruct.h"


@implementation Memory

// ---------------------------------------------------------------
// What exactly needs to be done in Memory constructor and reset?


- (void) Memory
{
    // ?
    
    [self build];
}

- (void) build
{
    for(int i=0; i<MAX; i++)
        buttonSequence[i] = rand() % 4;     // random number 0-3
}

- (int) getButton: (int)index
{
    return buttonSequence[index];
}

- (void) reset
{
    // ?
    
    [self build];
}



@end
