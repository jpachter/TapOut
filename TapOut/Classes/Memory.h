//
//  MemoryStruct.h
//  TapOut
//
//  Created by CSE483W on 10/31/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdlib.h>

@interface Memory : NSObject
{
    NSInteger MAX;
    NSInteger buttonSequence[30];
}

- (void)Memory;
- (void)build;
- (int)getButton:(int)index;
- (void)reset;

@end