//
//  YCKeychainItem+private.h
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "YCKeychainItem.h"

@interface YCKeychainItem (private)
#ifdef __cplusplus
extern "C" {
#endif
CFMutableDictionaryRef makeBaseQuery(CFTypeRef keychainClass);
#ifdef __cplusplus
} //end extern "C"
#endif

@end
