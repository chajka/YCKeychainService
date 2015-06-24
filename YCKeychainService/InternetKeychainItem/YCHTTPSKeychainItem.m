//
//  YCHTTPSKeychainItem.m
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Security/SecItem.h>
#import "YCHTTPSKeychainItem.h"
#import "YCKeychainItem+private.h"

@interface YCHTTPSKeychainItem ()
#ifdef __cplusplus
extern "C" {
#endif
CFMutableDictionaryRef makeHTTPSPasswordQuery(CFStringRef url, CFStringRef path);
#ifdef __cplusplus
} //end extern "C"
#endif

@end

@implementation YCHTTPSKeychainItem
#pragma mark - synthesize properties
#pragma mark - class method
+ (NSArray *) usersInKeychain:(NSString *)url andPath:(NSString *)path
{
	CFMutableDictionaryRef query = makeHTTPSPasswordQuery((__bridge CFStringRef)url, (__bridge CFStringRef)path);
	CFArrayRef searchResult = NULL;
	OSStatus status;
	
	status = SecItemCopyMatching(query, (CFTypeRef*)&searchResult);
	
	NSArray *users = nil;
	if (status != noErr)
		return users;
	
	users = [NSArray arrayWithArray:(__bridge NSArray *)searchResult];
	CFRelease(searchResult);
	return users;
}// end + (NSArray) usersInKeychain:(YCKeychain *)keychain
#pragma mark - constructor / destructor
#pragma mark - override
#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
#pragma mark - messages
#pragma mark - private
#pragma mark - C functions
CFMutableDictionaryRef makeHTTPSPasswordQuery(CFStringRef url, CFStringRef path)
{
	CFMutableDictionaryRef query = makeBaseQuery(kSecClassInternetPassword);
	CFDictionaryAddValue(query, kSecClass, kSecClassInternetPassword);
	CFDictionaryAddValue(query, kSecAttrProtocol, kSecAttrProtocolHTTPS);
	CFDictionaryAddValue(query, kSecAttrServer, url);
	CFDictionaryAddValue(query, kSecAttrPath, path);
	
	
	return query;
}

@end
