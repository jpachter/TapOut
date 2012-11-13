//
//  Memory.m
//  TapOut
//
//  Created by CSE483W on 10/31/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import "Memory.h"

@implementation Memory

- (void) build
{
    for(int i=0; i<30; i++)
        buttonSequence[i] = arc4random()%4+1;
}

- (int) getButton: (int)index
{
    return buttonSequence[index];
}

@end
