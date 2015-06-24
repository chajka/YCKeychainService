//
//  CommonUtilties.h
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif
	extern NSString *errorMessageFromStatus(OSStatus status);
#ifdef __cplusplus
} //end extern "C"
#endif

#define ErrorLog(message)	NSLog(@"[%@  %@] error %@", [self class], NSStringFromSelector(_cmd), message)

@interface CommonUtilties : NSObject

@end
