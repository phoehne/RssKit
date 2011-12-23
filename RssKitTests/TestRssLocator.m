//
//  TestRssLocator.m
//  RssKit
//
//  Created by Paul Hoehne on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
// Use the following test file:
// http://cyber.law.harvard.edu/rss/examples/rss2sample.xml
//

#import "TestRssLocator.h"
#import "RssLocator.h"
#import "RssRoot.h"

@implementation TestRssLocator

// All code under test must be linked into the Unit Test bundle
- (void)testLoactorFactory
{
    RssLocator* locator = [[RssLocator alloc] init];
    
    STAssertNotNil(locator, @"Loactor must return a valid instance.");
}

-(void)testDocumentRetrieve
{
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample.xml" withExtension:nil]];
    RssRoot* root = [locator retrieveFeed];
    
    STAssertNotNil(root, @"This should retrieve a document, please check you network settings");
}

-(void)testNoFeedURLException
{
    RssLocator* locator = [[RssLocator alloc] init];
    RssRoot* root;
    
    STAssertThrows(root = [locator retrieveFeed], @"No feed url should result in an excpeiton.");
}

-(void)testNoDocumentFound
{
    RssLocator* locator = [[RssLocator alloc] init];
    RssRoot* root;
    [locator setFeedUrl: [NSURL URLWithString: @"http://google.com/rss/examples/rss2sample.foo"]];
    STAssertThrows(root = [locator retrieveFeed], @"No document returned should throw an excpetion");
}


@end
