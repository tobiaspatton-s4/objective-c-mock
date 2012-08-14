//
//  OCMOCKRepository.m
//  ocmock
//
//  Created by Tobias Patton on 8/3/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import "OCMOCKRepository.h"
#import "OCMOCKStub.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation OCMOCKRepository

+ (id) generateStubForClass: (Class) class
{
    return [[OCMOCKStub alloc] initWithClass:class];
}

@end
