//
//  MyButton.m
//  TapOut
//
//  Created by Justin on 12/15/12.
//  Copyright (c) 2012 CSE483W. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}
@end