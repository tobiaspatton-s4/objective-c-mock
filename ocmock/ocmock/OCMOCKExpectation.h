//
//  OCMOCKExpectation.h
//  ocmock
//
//  Created by Tobias Patton on 8/9/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMOCKExpectation : NSObject

@property (nonatomic, retain) id target;
@property (nonatomic, retain) NSInvocation *invocation;
@property (nonatomic, assign) BOOL isIgnoreArgument;

- (id) initWithTarget:(id)aTarget;
- (OCMOCKExpectation *) returns:(id)value;
- (OCMOCKExpectation *) ignoreArguments;

@end
