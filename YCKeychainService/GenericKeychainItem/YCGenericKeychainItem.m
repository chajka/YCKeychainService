//
//  YCGenericKeychainItem.m
//  YCKeychainService
//
//  Created by Чайка on 6/26/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "YCGenericKeychainItem.h"

@implementation YCGenericKeychainItem
#pragma mark - synthesize properties
#pragma mark - class method
#pragma mark - constructor / destructor
- (id) initWithName:(NSString *)accnt forService:(NSString *)service
{
	self = [super init];
	if (self) {
		UInt32 passwordLength = 0;
		const char *passwordData;
		OSStatus result = SecKeychainFindGenericPassword(NULL,
					(UInt32)[service length], (const char *)[service UTF8String],
					(UInt32)[accnt length], (const char *)[accnt UTF8String],
					&passwordLength, (void **)&passwordData, &keychainItem);

		if (result != noErr)
			return nil;

		account = [[NSString alloc] initWithString:accnt];
		password = [[NSString alloc] initWithBytes:passwordData length:passwordLength encoding:NSUTF8StringEncoding];
		serviceName = [[NSString alloc] initWithString:service];

		SecKeychainItemFreeContent(NULL, (void *)passwordData);
	}// end if self

	return self;
}// end - (id) initWithName:(NSString *)accnt forService:(NSString *)service

- (id) initWithName:(NSString *)accnt password:(NSString *)passwd  forService:(NSString *)service
{
	self = [super init];
	if (self) {
		OSStatus result = SecKeychainAddGenericPassword(NULL,
					(UInt32)[service length], (const char *)[service UTF8String],
					(UInt32)[accnt length], (const char *)[accnt UTF8String],
					(UInt32)[passwd length], (const char *)[passwd UTF8String], &keychainItem);

		if (result != noErr)
			return nil;
		
		account = [[NSString alloc] initWithString:accnt];
		password = [[NSString alloc] initWithString:passwd];
		serviceName = [[NSString alloc] initWithString:service];
}// end if self

	return self;
}// end - (id) initWithName:(NSString *)accnt password:(NSString *)passwd  forService:(NSString *)service
#pragma mark - override
#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
#pragma mark - messages
#pragma mark - private
#pragma mark - C functions


@end
