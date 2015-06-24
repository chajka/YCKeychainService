//
//  YCKeychainItem.m
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import "YCKeychainItem.h"

@implementation YCKeychainItem
#pragma mark - synthesize properties
@synthesize account;
@synthesize password;
@synthesize inKeyChain = belongsToKeychain;
#pragma mark - class method
#pragma mark - constructor / destructor
- (id) init
{
	self = [super init];
	if (self)
		lastResult = noErr;
	
	return self;
}// end - (id) init

- (id) initWithName:(NSString *)accountName password:(NSString *)accountPassword
{
	self = [super init];
	if (self) {
		lastResult = noErr;
		account = [[NSString alloc] initWithString:accountName];
		password = [[NSString alloc] initWithString:accountPassword];
	}// end if self
	
	return self;
}// end - (id) initWithName:(NSString *)accountName password:(NSString *)accountPassword

#pragma mark - override
#pragma mark - delegate
#pragma mark - properties
#pragma mark - actions
#pragma mark - messages
#pragma mark - private
#pragma mark - C functions


@end
