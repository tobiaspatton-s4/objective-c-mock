//
//  OCMOCKStub.h
//  ocmock
//
//  Created by Tobias Patton on 8/14/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCMOCKExpectation;

@interface OCMOCKStub : NSProxy

@property (nonatomic, copy) Class _class;
@property (nonatomic, retain) NSMutableDictionary *_expectations;

- (id) initWithClass:(Class)class;

- (void) addExpectation:(OCMOCKExpectation *)expectation;

- (OCMOCKExpectation *) expect;

@end
