//
//  YCInternetKeychainItemTest.m
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "YCInternetKeychainItem.h"

@interface InternetKeychainItem : XCTestCase

@end

@implementation InternetKeychainItem

- (void) setUp
{
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void) tearDown
{
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void) test01_Allocation
{
	NSArray *users = [YCInternetKeychainItem usersInKeychain];
	XCTAssertNotNil(users, @"Test01 allocation fail\"%s\"", __PRETTY_FUNCTION__);
}

@end
