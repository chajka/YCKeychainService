//
//  YCKeychainItem+private.m
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "YCKeychainItem+private.h"

@implementation YCKeychainItem (private)
#pragma mark - C functions
CFMutableDictionaryRef makeBaseQuery(CFTypeRef keychainClass)
{		// create query dictionary
	CFMutableDictionaryRef query = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
	
	// set value for query
	CFDictionaryAddValue(query, kSecClass, keychainClass);
	CFDictionaryAddValue(query, kSecMatchLimit, kSecMatchLimitAll);
	CFDictionaryAddValue(query, kSecReturnAttributes, kCFBooleanTrue);
	CFDictionaryAddValue(query, kSecAttrKeyClass, kSecAttrDescription);
	CFDictionaryAddValue(query, kSecAttrKeyClass, kSecAttrSecurityDomain);
	CFDictionaryAddValue(query, kSecAttrKeyClass, kSecAttrProtocol);
	CFDictionaryAddValue(query, kSecAttrKeyClass, kSecAttrAuthenticationType);
	CFDictionaryAddValue(query, kSecAttrKeyClass, kSecAttrPort);
	CFDictionaryAddValue(query, kSecAttrKeyClass, kSecAttrPath);
	
	return query;
}// end CFMutableDictionaryRef makeQuery(CFTypeRef keychainClass)

@end
