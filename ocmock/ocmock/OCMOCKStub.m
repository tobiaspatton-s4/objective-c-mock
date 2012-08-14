//
//  OCMOCKStub.m
//  ocmock
//
//  Created by Tobias Patton on 8/14/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import "OCMOCKStub.h"
#import "OCMOCKExpectation.h"

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
    NSLog(@"*** Looking for expection with key %@", key);
    OCMOCKExpectation *expectation = [self._expectations valueForKey:key];
    if(expectation == nil)
    {
        // If no expectations set on the object, return 0;
        int64_t i = 0L;
        NSData *data = [NSData dataWithBytes:&i length:sizeof(int64_t)];
        const char* bytes = [data bytes];
        [invocation setReturnValue: (void *)bytes];
    }
    else
    {
        id result;
        [expectation.invocation getReturnValue:&result];
        [[result retain] autorelease];
        [invocation setReturnValue:&result];
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
    NSLog(@"***Adding expection with key %@", key);
    [self._expectations setValue:expectation forKey:key];
}

@end
