//
//  Cloud.h
//  FeedGetter
//
//  Created by Paul Hoehne on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssCloud : NSObject

/**
 <cloud domain="radio.xmlstoragesystem.com" port="80" path="/RPC2" registerProcedure="xmlStorageSystem.rssPleaseNotify" protocol="xml-rpc" />
 */

@property (strong) NSString* domain;
@property (assign) int port;
@property (strong) NSString* path;
@property (strong) NSString* registerProcedure;
@property (strong) NSString* protocol;

@end
