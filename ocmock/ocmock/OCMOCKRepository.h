//
//  OCMOCKRepository.h
//  ocmock
//
//  Created by Tobias Patton on 8/3/12.
//  Copyright (c) 2012 Tobias Patton. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OCMOCKRepository : NSObject

+ (id) generateStubForClass: (Class) class;

@end
