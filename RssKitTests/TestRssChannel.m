//
//  TestRssChannel.m
//  RssKit
//
//  Created by Paul Hoehne on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TestRssChannel.h"
#import "RssLocator.h"
#import "RssRoot.h"
#import "RssChannel.h"

@implementation TestRssChannel

// All code under test must be linked into the Unit Test bundle
- (void)testChannleRequiredElements
{
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample.xml" withExtension:nil]];
    RssRoot* root = [locator retrieveFeed];
    
    RssChannel* channel = [root channel];
    
    STAssertNotNil([channel title], @"There must always be a title as in the test document");
    STAssertNotNil([channel link],  @"There must always be a link as in the test document");
    STAssertNotNil([channel description], @"There must always be a description in the test document.");
    
    STAssertEqualObjects([channel title], @"Liftoff News", 
                         @"The sample test document's title should be 'Liftoff News'");
    STAssertEqualObjects([channel link], @"http://liftoff.msfc.nasa.gov/", 
                         @"The sample test document's link should be 'http://liftoff.msfc.nasa.gov/'");
    STAssertEqualObjects([channel description], @"Liftoff to Space Exploration.",
                         @"The sample test document's description should be 'Liftoff to Space Exploration.");
}

@end
