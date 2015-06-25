//
//  YCInternetKeychainItem.m
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "YCInternetKeychainItem.h"
#import "YCKeychainItem+private.h"

@interface YCInternetKeychainItem ()

#ifdef __cplusplus
extern "C" {
#endif
	CFMutableDictionaryRef makeQuery(CFTypeRef keychainClass);
#ifdef __cplusplus
} //end extern "C"
#endif

@end

@implementation YCInternetKeychainItem
#pragma mark - synthesize properties
@synthesize url;
@synthesize securityDomain;
@synthesize protocol;
@synthesize authenticationType;
#pragma mark - class method
+ (NSArray *) usersInKeychain
{
	CFMutableDictionaryRef query = makeInternetPasswordQuery();
	CFArrayRef searchResult = NULL;
	OSStatus status;
	
	status = SecItemCopyMatching(query, (CFTypeRef*)&searchResult);
	
	NSLog(@"%@", searchResult);
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
- (NSString *) server
{
	return [url host];
}// end - (NSString *) server

- (NSString *) path
{
	return [url path];
}// end - (NSString *) path

- (NSUInteger) port
{
	return [[url port] integerValue];
}//end - (NSUInteger) port
#pragma mark - actions
#pragma mark - messages
- (void) setURL:(NSURL *)aURL
{
	[self setURL:aURL port:0];
}// end - (void) setURL:(NSURL *)url

- (void) setURL:(NSURL *)aURL port:(UInt16)aPort
{
	[self setURL:aURL securityDomain:kSecAuthenticationTypeAny port:aPort Protocol:kSecProtocolTypeAny authenticationType:kSecAuthenticationTypeAny];
}// end - (void) setURL:(NSURL *)aURL port:(UInt16)aPort

- (void) setURL:(NSURL *)aURL securityDomain:(NSString *)domain port:(UInt16)aPort Protocol:(SecProtocolType)aProtocol authenticationType:(SecAuthenticationType)auth
{
	url = [[NSURL alloc] initWithString:[aURL absoluteString]];
	securityDomain = [[NSString alloc] initWithString:domain];
	protocol = aProtocol;
	authenticationType = auth;
	
}// end - (void) setURL:(NSURL *)aURL securityDomain:(NSString *)domain port:(UInt16)aPort Protocol:(SecProtocolType)aProtocol authenticationType:(SecAuthenticationType)auth
#pragma mark - private
#pragma mark - C functions
CFMutableDictionaryRef makeInternetPasswordQuery(void)
{
	CFMutableDictionaryRef query = makeBaseQuery(kSecClassInternetPassword);
	CFDictionaryAddValue(query, kSecClass, kSecClassInternetPassword);
	
	return query;
}
@end
