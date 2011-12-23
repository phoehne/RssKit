//
//  TestRssRoot.m
//  RssKit
//
//  Created by Paul Hoehne on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TestRssRoot.h"
#import "RssLocator.h"
#import "RssRoot.h"
#import "RssChannel.h"

static NSString* TEST_FEED_URL = @"http://cyber.law.harvard.edu/rss/examples/rss2sample.xml";

@implementation TestRssRoot

// All code under test must be linked into the Unit Test bundle
- (void)testRootHasChannel
{
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample.xml" withExtension:nil]];
    
    RssRoot* root = [locator retrieveFeed];
    
    STAssertNotNil([root channel], @"The root should have one element, a channel");
}

@end
