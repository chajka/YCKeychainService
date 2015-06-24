//
//  YCKeychain.h
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import "YCKeychainACL.h"
#import "CommonUtilties.h"

@interface YCKeychain : NSObject {
	SecKeychainRef						keychain;
	YCKeychainACL						*accessControlList;

	OSStatus							lastResult;
	NSString							*lastResultMessage;
}
@property (readonly) SecKeychainRef		keychain;

+ (YCKeychain *) defaultKeychain;
#if __has_feature(objc_arc)
+ (BOOL) lockAll:(NSString * __autoreleasing *)errorMessage;
#else
+ (BOOL) lockAll:(NSString **)errorMessage;
#endif
#if __has_feature(objc_arc)
+ (BOOL) unlockAll:(NSString *)password error:(NSString * __autoreleasing *)errorMessage;
#else
+ (BOOL) unlockAll:(NSString *)password error:(NSString **)errorMessage;
#endif

- (id) init;
- (id) initWithPath:(NSString *)path password:(NSString *)password;

@end
