//
//  CommonUtilties.m
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "CommonUtilties.h"

@implementation CommonUtilties
#pragma mark - synthesize properties
#pragma mark - class method
#pragma mark - constructor / destructor
#pragma mark - instance method
#pragma mark constructor
#pragma mark - properties
#pragma mark - messages
#pragma mark - private
#pragma mark - C functions
NSString *errorMessageFromStatus(OSStatus status)
{
	CFStringRef message = SecCopyErrorMessageString(status, NULL);
	NSString *errorMessage =
#if __has_feature(objc_arc)
	[NSString stringWithString:(__bridge NSString *)message];
#else
	[NSString stringWithString:(NSString *)message];
#endif
	CFRelease(message);
	
	return errorMessage;
}// end static NSString *errorMessageFromStatus(OSStatus status)
@end
