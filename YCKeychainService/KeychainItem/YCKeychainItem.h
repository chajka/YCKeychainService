//
//  YCKeychainItem.h
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import "YCKeychain.h"

@interface YCKeychainItem : NSObject {
	SecKeychainItemRef						keychainItem;
	YCKeychain								*belongsToKeychain;

	NSString								*account;
	NSString								*password;

	OSStatus								lastResult;
}
@property (readonly)	NSString			*account;
@property (readonly)	NSString			*password;
@property (readonly)	YCKeychain			*inKeyChain;

- (id) init;
- (id) initWithName:(NSString *)accountName password:(NSString *)accountPassword;

- (BOOL) addTo:(YCKeychain *)keychain;
- (BOOL) deleteFromKeychain;
- (NSString *)errorMessage;
@end
