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

- (id) initWithTarget:(id)target;
- (void) returns:(id)value;

@end
