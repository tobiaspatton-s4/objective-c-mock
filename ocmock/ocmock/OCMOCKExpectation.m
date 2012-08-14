//
//  OCMOCKExpectation.m
//  ocmock
//
//  Created by Tobias Patton on 8/9/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import "OCMOCKExpectation.h"
#import "OCMOCKStub.h"

@implementation OCMOCKExpectation

- (id) initWithTarget: (id)target
{
    if(self = [super init])
    {
        self.target = target;
    }
    return self;
}

- (void) forwardInvocation:(NSInvocation *)anInvocation
{
    self.invocation = anInvocation;
    [anInvocation setReturnValue:&self];
}

- (NSMethodSignature *) methodSignatureForSelector:(SEL)aSelector
{
    return [self.target methodSignatureForSelector:aSelector];
}

- (void) returns: (id)value
{
    [self.invocation setReturnValue:&value];
    if([self.target isKindOfClass:[OCMOCKStub class]])
    {
        [(OCMOCKStub *)self.target addExpectation:self];
    }
    else
    {
        NSLog(@"*** Attempting to set expecation on object that's not an OCMOCKStub");
    }
}

@end
