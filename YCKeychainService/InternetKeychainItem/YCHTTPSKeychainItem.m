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
#import "CommonUtilties.h"

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
+ (NSArray *) usersInKeychain:(NSURL *)url
{
	NSString *server = [url host];
	NSString *path = [url path];
	CFMutableDictionaryRef query = makeHTTPSPasswordQuery((__bridge CFStringRef)server, (__bridge CFStringRef)path);
	CFArrayRef searchResult = NULL;
	OSStatus status;
	
	status = SecItemCopyMatching(query, (CFTypeRef*)&searchResult);
	
	NSArray *users = nil;
	if (status != noErr)
		return users;
	
	NSMutableArray *tmpUsers = [NSMutableArray array];
	for (NSDictionary *foundItem in (__bridge NSArray *)searchResult) {
		YCHTTPSKeychainItem *keychainItem = [[YCHTTPSKeychainItem alloc] initWithURL:url andSecItem:foundItem];
		[tmpUsers addObject:keychainItem];
	}
	
	users = [NSArray arrayWithArray:tmpUsers];
	CFRelease(searchResult);
	return users;
}// end + (NSArray) usersInKeychain:(YCKeychain *)keychain

+ (YCHTTPSKeychainItem *) userInKeychain:(NSString *)account forURL:(NSURL *)url
{
	NSString *server = [url host];
	NSString *path = [url path];
	CFMutableDictionaryRef query = makeHTTPSPasswordQuery((__bridge CFStringRef)server, (__bridge CFStringRef)path);
	CFDictionaryAddValue(query, kSecAttrAccount, (__bridge CFStringRef)account);
	CFArrayRef searchResult = NULL;
	OSStatus status;
	
	status = SecItemCopyMatching(query, (CFTypeRef*)&searchResult);
	if (status != noErr) {
		NSLog(@"Error : %@", errorMessageFromStatus(status));
		return nil;
	}

	YCHTTPSKeychainItem *user = [[YCHTTPSKeychainItem alloc] initWithURL:url andSecItem:[(__bridge NSArray *)searchResult objectAtIndex:0]];

	return user;
}//end + (YCHTTPSKeychainItem) userInKeychain:(NSString *)account forURL:(NSURL *)url

#pragma mark - constructor / destructor
- (id) initWithURL:(NSURL *)aURL andSecItem:(NSDictionary *)item
{
	self = [super init];
	if (self) {
		account = [[NSString alloc] initWithString:[item valueForKey:kSecAttrAccount]];
		url = [[NSURL alloc] initWithString:[aURL absoluteString]];
		NSString *serverName = [item valueForKey:kSecAttrServer];
		NSString *serverPath = [item valueForKey:kSecAttrPath];
		UInt32 passwordLength;
		char *passwordData;

		OSStatus result = SecKeychainFindInternetPassword(NULL,
			(UInt32)[serverName length], (const char *)[serverName UTF8String],
			(UInt32)0, (const char *)NULL,
			(UInt32)[account length], (const char *)[account UTF8String],
			(UInt32)[serverPath length], (const char *)[serverPath UTF8String], 0,
			(UInt32)[[item valueForKey:kSecAttrProtocol] integerValue],
			(UInt32)[[item valueForKey:kSecAttrAuthenticationType] integerValue],
			(UInt32 *)&passwordLength, (void **)&passwordData, &keychainItem);

		if (result == noErr) {
			password = [[NSString alloc] initWithBytes:passwordData length:passwordLength encoding:NSUTF8StringEncoding];
			SecKeychainItemFreeContent(NULL, (void *)passwordData);
		}
	}// end if self

	return self;
}// - (id) initWithSecItem:(NSDictionary *)item

- (id) initWithAccount:(NSString *)acct andPassword:(NSString *)pass forURL:(NSURL *)aURL
{
	self = [super init];
	if (self) {
		account = [[NSString alloc] initWithString:acct];
		password = [[NSString alloc] initWithString:pass];
		url = [[NSURL alloc] initWithString:[aURL absoluteString]];
		NSString *serverName = [url host];
		NSString *serverPath = [url path];
		UInt32 port = (UInt32)[[url port] integerValue];

		OSStatus result = SecKeychainAddInternetPassword(NULL,
			(UInt32)[serverName length], (const char *)[serverName UTF8String],
			(UInt32)0, (const char *)NULL,
			(UInt32)[account length], (const char *)[account UTF8String],
			(UInt32)[serverPath length], (const char *)[serverPath UTF8String], port,
			(UInt32)kSecProtocolTypeHTTPS, kSecAuthenticationTypeAny,
			(UInt32)[password length], (const void *)[password UTF8String], &keychainItem);

		if (result != noErr)
			return nil;

	}// end if self

	return self;
}// end - (id) initWithAccount:(NSString *)acct andPassword:(NSString *)pass forURL:(NSURL *)aURL
#pragma mark - override
#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
#pragma mark - messages
- (BOOL) deleteFromKeychain
{
	OSStatus status = SecKeychainItemDelete(keychainItem);

	return (status == noErr) ? YES : NO;
}// - (BOOL) deleteFromKeychain
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
