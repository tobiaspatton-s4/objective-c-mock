//
//  NSObject-Mock.m
//  ocmock
//
//  Created by Tobias Patton on 8/3/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import "NSObject-Mock.h"
#import <objc/runtime.h>

@interface NSObject(PrivateMock)
static id stubMethodReturningValue(id self, SEL _cmd, id value);
@end

@implementation NSObject(Mock)

- (void) stub: (SEL)selector returns: (id)value
{
    Method method = class_getInstanceMethod([self class], selector);
   // method_setImplementation(method, ^id(id self, SEL _cmd, ...){ return stubMethodReturningValue(self, _cmd, value); });
}

static id stubMethodReturningValue(id self, SEL _cmd, id value)
{
    return value;
}

@end
