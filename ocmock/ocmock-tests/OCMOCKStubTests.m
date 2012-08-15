//
//  OCMOCKStubTests.m
//  ocmock
//
//  Created by Tobias Patton on 8/3/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import "OCMOCKStubTests.h"
#import "OCMOCKRepository.h"
#import "OCMOCKExpectation.h"
#import "OCMOCKStub.h"

@interface StubTestClassToStub : NSObject
- (id) methodReturnsId;
- (id) methodTakesIntReturnsId: (int) val;
- (char) methodTakesInt: (int)i andFloatReturnsChar: (float) val;
@end

@implementation StubTestClassToStub
- (id) methodReturnsId
{
    return [NSString string];
}

- (id) methodTakesIntReturnsId: (int) val
{
    return @"goodbye world";
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
    
    char r2 = [stub methodTakesInt:5 andFloatReturnsChar:2.0];
    STAssertEquals((char)'\0', r2, @"Stub method did not return default value");
    
    id r3 = [stub methodReturnsId];
    STAssertNil(r3, @"Method that returns id did not return nil");
}

- (void) testExcpectation
{
    NSString *mockResult = @"mock NSString result";
    id stub = [OCMOCKRepository generateStubForClass: [StubTestClassToStub class]];
    [[[stub expect] methodReturnsId] returns:mockResult];
    
    id result = [stub methodReturnsId];
    STAssertEqualObjects(result, mockResult, @"Expectation on stub did not return correct value");
}

- (void) testIgnoreArguments
{
    NSString *mockResult = @"mock NSString result";
    const int mockIntArg = 22;
    
    id  stub = [OCMOCKRepository generateStubForClass: [StubTestClassToStub class]];
    [[[[stub expect] methodTakesIntReturnsId:mockIntArg] returns:mockResult] ignoreArguments];
    
    id result = [stub methodTakesIntReturnsId:5];
    STAssertEqualObjects(result, mockResult, @"Expectation on stub did not return correct value");
}

- (void) testExpectationWithArguments
{
    NSString *mockResult = @"mock NSString result";
    const int mockIntArg = 22;
    
    id  stub = [OCMOCKRepository generateStubForClass: [StubTestClassToStub class]];
    [[[stub expect] methodTakesIntReturnsId:mockIntArg] returns:mockResult];
    
    id result = [stub methodTakesIntReturnsId:mockIntArg];
    STAssertEqualObjects(result, mockResult, @"Expectation on stub did not return correct value");
    
    id resultWithIncorrectArg = [stub methodTakesIntReturnsId:0];
    STAssertNil(resultWithIncorrectArg, @"Expectation on stub did not return default value when incorrect argument passed");
}

@end
