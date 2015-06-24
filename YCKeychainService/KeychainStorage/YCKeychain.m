//
//  YCKeychain.m
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "YCKeychain.h"

@interface YCKeychain ()
#ifdef __cplusplus
extern "C" {
#endif
	static SecKeychainRef createKeyChain(NSString *path, NSString *pass, SecAccessRef permission, OSStatus *success, NSString **errorMessage);
#ifdef __cplusplus
} //end extern "C"
#endif
@end

@implementation YCKeychain
#pragma mark - synthesize properties
@synthesize keychain;
#pragma mark - class method
+ (YCKeychain *) defaultKeychain
{
	YCKeychain *keychain = [[YCKeychain alloc] init];
#if !__has_feature(objc_arc)
	[keychain autorelease];
#endif
	return keychain;
}// end + (YCKeychain *) defaultKeychain

#if __has_feature(objc_arc)
+ (BOOL) lockAll:(NSString * __autoreleasing *)errorMessage;
#else
+ (BOOL) lockAll:(NSString **)errorMessage;
#endif
{
	BOOL success = YES;
	OSStatus result = noErr;
	result = SecKeychainLockAll();
	
	// error handling
	if (result != noErr) {
		success = NO;
		if (errorMessage != nil)
			*errorMessage = errorMessageFromStatus(result);
	}// end if remove keychain is success or not
	
	return success;
}// end lockAll:(NSString **)errorMessage

#if __has_feature(objc_arc)
+ (BOOL) unlockAll:(NSString *)password error:(NSString * __autoreleasing *)errorMessage
#else
+ (BOOL) unlockAll:(NSString *)password error:(NSString **)errorMessage
#endif
{
	BOOL success = YES;
	OSStatus result = noErr;
	UInt32 length = 0;
	const char *pass = NULL;
	Boolean usePassword = false;
	
	if (password != nil) {
		length = (UInt32)[password length];
		pass = [password UTF8String];
		usePassword = true;
	}// end if password is defined
	result = SecKeychainUnlock(NULL, length, pass, usePassword);
	
	// error handling
	if (result != noErr) {
		success = NO;
		if (errorMessage != nil)
			*errorMessage = errorMessageFromStatus(result);
		// end if copy error message
	}// end if remove keychain is success or not
	
	return success;
}// end + (BOOL) unlockAll:(NSString *)password error:(NSString **)errorMessage

#pragma mark - constructor / destructor
- (id) init
{
	self = [super init];
	if (self) {
		lastResult = noErr;
	}// end if self
	
	return self;
}// end - (id) init

- (id) initWithPath:(NSString *)path password:(NSString *)password
{
	self = [super init];
	if (self) {
		lastResult = noErr;
		OSStatus success = noErr;
		NSString *errorMessage = nil;
		keychain = createKeyChain(path, password, NULL, &success, &errorMessage);
		if (success != noErr)
			ErrorLog(errorMessage);
	}// end if self
	
	return self;
}// end - (id) initWithPath:(NSString *)path password:(NSString *)password

#pragma mark - override
#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
#pragma mark - messages
#pragma mark - private
#pragma mark - C functions
static
SecKeychainRef createKeyChain(NSString *path, NSString *pass, SecAccessRef permission, OSStatus *success, NSString **errorMessage)
{		// variable for soter new keychain
	SecKeychainRef newKeychain = NULL;
	
	//	check keychain is already exists
	NSFileManager *fm = [NSFileManager defaultManager];
	OSStatus status = noErr;
	NSString *fullpath = path;
	// check path is relative from home or not
	switch ([path UTF8String][0]) {
		case '~':
			fullpath = [path stringByExpandingTildeInPath];
			break;
		case '/':
			fullpath = [NSString stringWithString:path];
			break;
		default:
			fullpath = [[@"~/Library/Keychains/" stringByAppendingPathComponent:path] stringByExpandingTildeInPath];
			break;
	}// end case by path begin from '~' or '/'
	
	// create or open keychain file
	if ([fm fileExistsAtPath:fullpath] == YES) {		// keychain file is exist, open it
		status = SecKeychainOpen([fullpath UTF8String], &newKeychain);
	}
	else
	{		// keychain file is not exist, create new
		const char *pathName = [fullpath UTF8String];
		const char *password = NULL;
		UInt32 passwordLength = 0;
		Boolean promptUser = (pass == nil) ? true : false;
		if (!promptUser) {
			password = [pass UTF8String];
			passwordLength = (UInt32)[pass length];
		}// end setup password
		// create keychain file
		status = SecKeychainCreate(pathName, passwordLength, password, promptUser, permission, &newKeychain);
	}// end if already keychain is there
	
	// error handling
	if (status != noErr) {		// error handling
		if (success != NULL)
			*success = status;
		if (errorMessage != nil)
			*errorMessage = errorMessageFromStatus(status);
		// end if copy error message
	}// end if open error
	
	return newKeychain;
}// end static SecKeychainRef createKeyChain(NSString *path, NSString *pass, SecAccessRef permission, OSStatus *success, NSString **errorMessage)

@end
