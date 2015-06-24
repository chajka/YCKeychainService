//
//  YCKeychainACL.h
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCKeychainACL : NSObject {
	SecAccessRef						accessRef;

	NSString							*descriptor;
}
@property (readonly) SecAccessRef		ACL;
@property (readonly) NSString			*descriptor;
@end
