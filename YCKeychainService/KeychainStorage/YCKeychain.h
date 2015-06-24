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

@interface YCKeychain : NSObject {
	SecKeychainRef						keychain;
	YCKeychainACL						*accessControlList;

	OSStatus							lastResult;
	NSString							*lastResultMessage;
}
@end
