//
//  YCGenericKeychainItem.h
//  YCKeychainService
//
//  Created by Чайка on 6/26/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCKeychainItem.h"

@interface YCGenericKeychainItem : YCKeychainItem {
	NSString						*serviceName;
}
- (id) initWithName:(NSString *)accnt forService:(NSString *)service;
- (id) initWithName:(NSString *)accnt password:(NSString *)passwd  forService:(NSString *)service;
@end
