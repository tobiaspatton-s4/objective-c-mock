//
//  NSObject-Mock.h
//  ocmock
//
//  Created by Tobias Patton on 8/3/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSObject(Mock)

- (void) stub: (SEL)selector returns: (id)value;

@end
