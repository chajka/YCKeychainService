//
//  YCKeychainStorageTest.m
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "YCKeychain.h"

@interface YCKeychainStorageTest : XCTestCase

@end

@implementation YCKeychainStorageTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void) test01_Allocation
{
	YCKeychain *keychain = [[YCKeychain alloc] init];
	XCTAssertNotNil(keychain, @"Test01 allocation fail\"%s\"", __PRETTY_FUNCTION__);
	XCTAssert((keychain.keychain == NULL), @"Test01 property keychain is not NULL\"%s\"", __PRETTY_FUNCTION__);
}// end - (void) test01_Allocation

- (void) test02_KeychainCreationWithPrompt
{
	NSFileManager *fm = [NSFileManager defaultManager];
	NSString *keychainPath = @"~/TestKeychain02";
	
	YCKeychain *keychain = [[YCKeychain alloc] initWithPath:keychainPath password:nil];
	XCTAssertNotNil(keychain, @"Test02 allocation fail\"%s\"", __PRETTY_FUNCTION__);
	XCTAssert((keychain.keychain != NULL), @"Test02 property keychain is NULL\"%s\"", __PRETTY_FUNCTION__);
	
	NSString *fullpath = [keychainPath stringByExpandingTildeInPath];
	BOOL exists = [fm fileExistsAtPath:fullpath isDirectory:NULL];
	XCTAssertTrue(exists, "Test02 keychain file creation success \"%s\"", __PRETTY_FUNCTION__);
	
	NSString *errorMessage = nil;
	BOOL success = [keychain remove];
	XCTAssertTrue(success, @"Test02 Keychain failed to remove \"%s\"", __PRETTY_FUNCTION__);
	XCTAssertNil(errorMessage, @"Test02 Keychain remove failed message %@", errorMessage);
	XCTAssert((keychain.keychain == NULL), @"Test02 property keychain is not clear\"%s\"", __PRETTY_FUNCTION__);
	
	exists = [fm fileExistsAtPath:fullpath isDirectory:NULL];
	XCTAssertFalse(exists, "Test02 keychain file can not removed \"%s\"", __PRETTY_FUNCTION__);
}// end - (void) test02_KeychainCreationWithPrompt

- (void) test03_KeychainCreationWithPassword
{
	NSFileManager *fm = [NSFileManager defaultManager];
	NSString *keychainPath = @"TestKeychain03";
	
	YCKeychain *keychain = [[YCKeychain alloc] initWithPath:keychainPath password:@"keychaintest03"];
	XCTAssertNotNil(keychain, @"Test03 allocation fail\"%s\"", __PRETTY_FUNCTION__);
	XCTAssert((keychain.keychain != NULL), @"Test03 property keychain is NULL\"%s\"", __PRETTY_FUNCTION__);
	NSLog(@"%@", keychain.keychain);
	
	NSString *fullpath = [@"~/Library/Keychains/TestKeychain03" stringByExpandingTildeInPath];
	BOOL exists = [fm fileExistsAtPath:fullpath isDirectory:NULL];
	XCTAssertTrue(exists, "Test03 keychain file creation success \"%s\"", __PRETTY_FUNCTION__);
	
	NSString *errorMessage = nil;
	BOOL success = [keychain remove];
	XCTAssertTrue(success, @"Test03 Keychain failed to remove \"%s\"", __PRETTY_FUNCTION__);
	XCTAssertNil(errorMessage, @"Test03 Keychain remove failed message %@", errorMessage);
	XCTAssert((keychain.keychain == NULL), @"Test03 property keychain is not clear\"%s\"", __PRETTY_FUNCTION__);
	
	exists = [fm fileExistsAtPath:fullpath isDirectory:NULL];
	XCTAssertFalse(exists, "Test03 keychain file can not removed \"%s\"", __PRETTY_FUNCTION__);
}// end - (void) test03_KeychainCreationWithPassword

- (void) Skip_04_lockUnlock
{
	NSFileManager *fm = [NSFileManager defaultManager];
	NSString *keychainPath = @"TestKeychain04";
	
	NSString *errorMessage = nil;
	BOOL success = NO;
	success = [YCKeychain lockAll:&errorMessage];
	XCTAssertTrue(success, @"Test04 Kychain lock all failed \"%s\"", __PRETTY_FUNCTION__);
	XCTAssertNil(errorMessage, @"Test04 Keychain lock all error message :‘%@’  \"%s\"", errorMessage, __PRETTY_FUNCTION__);
	success = [YCKeychain unlockAll:nil error:&errorMessage];
	
	XCTAssertTrue(success, @"Test04 Kychain unlock all failed \"%s\"", __PRETTY_FUNCTION__);
	XCTAssertNil(errorMessage, @"Test04 Keychain unlock all error message :‘%@’  \"%s\"", errorMessage, __PRETTY_FUNCTION__);
	
	YCKeychain *keychain = [[YCKeychain alloc] initWithPath:keychainPath password:@"keychaintest04"];
	XCTAssertNotNil(keychain, @"Test03 allocation fail\"%s\"", __PRETTY_FUNCTION__);
	XCTAssert((keychain.keychain != NULL), @"Test03 property keychain is NULL\"%s\"", __PRETTY_FUNCTION__);
	NSLog(@"%@", keychain.keychain);
	
	success = [keychain lock];
	XCTAssertTrue(success, "Test04 keychain lock fail \"%s\"", __PRETTY_FUNCTION__);
	XCTAssertNil(errorMessage, @"Test04 Keychain lock failed message %@", errorMessage);
	
	success = [keychain unlock:@"keychaintest04"];
	XCTAssertTrue(success, "Test04 keychain lock fail \"%s\"", __PRETTY_FUNCTION__);
	XCTAssertNil(errorMessage, @"Test04 Keychain lock failed message %@", errorMessage);
	
	NSString *fullpath = [@"~/Library/Keychains/TestKeychain04" stringByExpandingTildeInPath];
	BOOL exists = [fm fileExistsAtPath:fullpath isDirectory:NULL];
	XCTAssertTrue(exists, "Test04 keychain file creation success \"%s\"", __PRETTY_FUNCTION__);
	
	errorMessage = nil;
	success = [keychain remove];
	XCTAssertTrue(success, @"Test04 Keychain failed to remove \"%s\"", __PRETTY_FUNCTION__);
	XCTAssertNil(errorMessage, @"Test04 Keychain remove failed message %@", errorMessage);
	XCTAssert((keychain.keychain == NULL), @"Test04 property keychain is not clear\"%s\"", __PRETTY_FUNCTION__);
}// end - (void) teest04_lock

@end
