//
//  OCMOCKStubTests.m
//  ocmock
//
//  Created by Tobias Patton on 8/3/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import "OCMOCKStubTests.h"
#import "OCMOCKRepository.h"


@interface StubTestClassToStub : NSObject
- (int) methodTakesIntReturnsInt: (int) val;
- (char) methodTakesInt: (int)i andFloatReturnsChar: (float) val;
@end

@implementation StubTestClassToStub
- (int) methodTakesIntReturnsInt: (int) val
{
    return val * 2;
}
- (char) methodTakesInt: (int)i andFloatReturnsChar: (float) val;
{
    return 'a';
}
@end

@implementation OCMOCKStubTests

- (void) testStubCreation
{
    StubTestClassToStub *stub = [OCMOCKRepository generateStubForClass: [StubTestClassToStub class]];
    STAssertNotNil(stub, @"Mock repositor return nil stub for %@", NSStringFromClass([StubTestClassToStub class]));
}

- (void) testStubMethodsReturnsDefaultValue
{
    StubTestClassToStub *stub = [OCMOCKRepository generateStubForClass: [StubTestClassToStub class]];
    int r1 = [stub methodTakesIntReturnsInt:5];
    STAssertEquals(0, r1, @"Stub method did not return default value");
    
    char r2 = [stub methodTakesInt:5 andFloatReturnsChar:2.0];
    STAssertEquals((char)'\0', r2, @"Stub method did not return default value");
}

@end
