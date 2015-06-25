//
//  YCHTTPSKeychainItem.h
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "YCInternetKeychainItem.h"
#import "YCKeychainItem.h"

@interface YCHTTPSKeychainItem : YCInternetKeychainItem
+ (NSArray *) usersInKeychain:(NSURL *)url;
+ (YCHTTPSKeychainItem *) userInKeychain:(NSString *)account forURL:(NSURL *)url;
- (id) initWithURL:(NSURL *)aURL andSecItem:(NSDictionary *)item;
- (id) initWithAccount:(NSString *)acct andPassword:(NSString *)pass forURL:(NSURL *)aURL;
- (BOOL) deleteFromKeychain;
@end
