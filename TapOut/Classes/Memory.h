//
//  Memory.h
//  TapOut
//
//  Created by CSE483W on 10/31/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdlib.h>

@interface Memory : NSObject
{
    int buttonSequence[30];     // holds new sequence for each game
}

- (void)build;                  // builds new array for each game
- (int)getButton:(int)index;    // returns button in sequence at index

@end