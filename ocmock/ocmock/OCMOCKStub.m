//
//  OCMOCKStub.m
//  ocmock
//
//  Created by Tobias Patton on 8/14/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import "OCMOCKStub.h"
#import "OCMOCKExpectation.h"

BOOL OCMOCKExpectationMatchesInvocation(NSInvocation *invocation, OCMOCKExpectation *expectaton);

@implementation OCMOCKStub

@synthesize _class;
@synthesize _expectations;

- (id) initWithClass:(Class)class
{
    self._class = class;
    self._expectations = [[NSMutableDictionary alloc] init];
    return self;
}

- (BOOL) isKindOfClass:(Class)aClass
{
    return aClass == [OCMOCKStub class];
}

- (void) forwardInvocation:(NSInvocation *)invocation
{
    NSString *key = NSStringFromSelector([invocation selector]);
    OCMOCKExpectation *expectation = [self._expectations valueForKey:key];
    
    if(expectation != nil &&
       OCMOCKExpectationMatchesInvocation(invocation, expectation))
    {
        id result;
        [expectation.invocation getReturnValue:&result];
        [[result retain] autorelease];
        [invocation setReturnValue:&result];
    }
    else
    {
        // If no expectations set on the object, or if the arguments of the expectation 
        // were not matched, return 0;
        int64_t i = 0L;
        NSData *data = [NSData dataWithBytes:&i length:sizeof(int64_t)];
        const char* bytes = [data bytes];
        [invocation setReturnValue: (void *)bytes];
    }
}

- (NSMethodSignature *) methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *result = [self._class instanceMethodSignatureForSelector: aSelector];
    return result;
}

- (OCMOCKExpectation *) expect
{
    return [[[OCMOCKExpectation alloc] initWithTarget:self] autorelease];
}

- (void) addExpectation:(OCMOCKExpectation *)expectation
{
    NSString *key = NSStringFromSelector([expectation.invocation selector]);
    [self._expectations setValue:expectation forKey:key];
}

@end

BOOL OCMOCKExpectationMatchesInvocation(NSInvocation *invocation, OCMOCKExpectation *expectaton)
{
    const int numArgs= [[invocation methodSignature] numberOfArguments];
    
    if(numArgs != [[expectaton.invocation methodSignature] numberOfArguments])
    {
        NSLog(@"*** Number of arguments in expecation does match invocation. Something went wrong.");
        return FALSE;
    }
    
    if([invocation selector] != [expectaton.invocation selector])
    {
        NSLog(@"*** Selector in expecation does match invocation. Something went wrong.");
        return FALSE;        
    }
    
    if(expectaton.isIgnoreArgument || numArgs == 2)
    {
        return TRUE;
    }
    
    for (int i = 2; i < numArgs; i++) 
    {
        // TODO: deal with different argument types
        int64_t actual = 0;
        int64_t expected = 0;
        
        [invocation getArgument:&actual atIndex:i];
        [expectaton.invocation getArgument:&expected atIndex:i];
        
        if(actual != expected)
        {
            return FALSE;
        }
    }
    
    return TRUE;
}