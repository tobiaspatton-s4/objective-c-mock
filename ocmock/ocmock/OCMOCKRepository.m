//
//  OCMOCKRepository.m
//  ocmock
//
//  Created by Tobias Patton on 8/3/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import "OCMOCKRepository.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface OCMOCKRepository(PrivateMethods)
+ (void) stubClassMethodsinStub: (Class)stub fromSourceClass:(Class)sourceClass;
+ (BOOL) encodedTypeIsIntegral: (char *)type;
@end

static id StubMethodReturningZero(id self, SEL _cmd, ...);

@implementation OCMOCKRepository

+ (id) generateStubForClass: (Class) class
{
    NSString *mockClassName = [NSString stringWithFormat:@"OCMOCKStub%@", NSStringFromClass(class)];
    Class mock = objc_allocateClassPair(class, [mockClassName cStringUsingEncoding:NSUTF8StringEncoding], 0);
    
    [self stubClassMethodsinStub:mock fromSourceClass:class];
    return [[mock alloc] init];
}

+ (BOOL) encodedTypeIsIntegral: (char *)type
{
    size_t len = strlen(type);
    if(len > 1 && type[0] == '^')
    {
        // Pointer type
        return TRUE;
    }
    
    if(len > 1 && type[0] == '[')
    {
        // Array type
        return TRUE;
    }
    
    if(len == 1)
    {
        switch(type[0])
        {
            case 'c':
            case 'i':
            case 's':
            case 'l':
            case 'q':
            case 'C':
            case 'I':
            case 'S':
            case 'L':
            case 'Q':
            case 'f':
            case 'd':
            case 'B':
            case '*':
            case '@':
                return TRUE;
        }
    }
    return FALSE;
}

+ (void) stubClassMethodsinStub: (Class)stub fromSourceClass:(Class)sourceClass
{
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(sourceClass, &methodCount);
    
    for(unsigned i = 0; i < methodCount; i++)
    {
        Method m = methodList[i];
        char *returnType = method_copyReturnType(m);
        const char *types = method_getTypeEncoding(m);
       
        if([self encodedTypeIsIntegral:returnType])
        {
            class_addMethod(stub, method_getName(m), StubMethodReturningZero, types);
        }
        
        free(returnType);
    }
}

static id StubMethodReturningZero(id self, SEL _cmd, ...)
{
    NSLog(@"Calling stubbed method %@", NSStringFromSelector(_cmd));
    return 0;
}

@end
