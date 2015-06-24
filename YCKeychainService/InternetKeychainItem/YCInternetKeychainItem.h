//
//  YCInternetKeychainItem.h
//  YCKeychainService
//
//  Created by Чайка on 6/24/15.
//  Copyright (c) 2015 Instrumentality of Mankind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCKeychain.h"
#import "YCKeychainItem.h"

enum {
	kYCPortUndefined	=  0,
	kYCPortFTP			= 20,
	kYCPortSSH			= 22,
	kYCPortTelnet		= 23,
	kYCPortSMTP			= 25,
	kYCPortHTTP			= 80,
	kYCPortIRC			= 194,
	kYCPortNNTP			= 119,
	kYCPortPOP3			= 110,
	kYCPortIMAP			= 143,
	kYCPortAppleTalk	= 201,
	kYCPortLDAP			= 389,
	kYCPortHTTPS		= 443,
	kYCPortSMB			= 445,
	kYCPortRTSP			= 554,
	kYCPortAFP			= 548,
	kYCPortFTPS			= 989,
	kYCPortSOCKS		= 1080,
	kYCPortDAAP			= 3689
};

@interface YCInternetKeychainItem : NSObject {
	NSURL									*url;
	NSString								*securityDomain;
	UInt16									port;
	SecProtocolType							protocol;
	SecAuthenticationType					authenticationType;
}
@property (readonly) NSURL					*url;
@property (readonly) NSString				*securityDomain;
@property (readonly) UInt16					port;
@property (readonly) SecProtocolType		protocol;
@property (readonly) SecAuthenticationType	authenticationType;

+ (NSArray *) usersInKeychain;
@end
