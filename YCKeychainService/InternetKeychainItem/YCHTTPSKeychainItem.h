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
+ (NSArray *) usersInKeychain:(NSString *)url andPath:(NSString *)path;
@end
