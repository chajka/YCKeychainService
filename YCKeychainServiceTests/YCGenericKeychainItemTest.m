//
//  YCGenericKeychainItemTest.m
//  YCKeychainService
//
//  Created by Чайка on 6/26/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "YCGenericKeychainItem.h"

@interface YCGenericKeychainItemTest : XCTestCase

@end

@implementation YCGenericKeychainItemTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test01_Allocation {
	YCGenericKeychainItem *new = [[YCGenericKeychainItem alloc] initWithName:@"YCKeychainService" password:@"testPassword" forService:@"XCTest"];
	XCTAssertNotNil(new, @"Test01 allocation fail\"%s\"", __PRETTY_FUNCTION__);
	YCGenericKeychainItem *found = [[YCGenericKeychainItem alloc] initWithName:@"YCKeychainService" forService:@"XCTest"];
	XCTAssertNotNil(found, @"Test01 allocation fail\"%s\"", __PRETTY_FUNCTION__);
	BOOL success = [new deleteFromKeychain];
	XCTAssertTrue(success, @"Test01 allocation fail\"%s\"", __PRETTY_FUNCTION__);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
