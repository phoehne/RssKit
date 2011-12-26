//
//  TestRssLocator.m
//  RssKit
//
// Copyright (c) 2011, Paul C. Hoehne
// All rights reserved.
//
// Redistribution and use in source and binary forms, with 
// or without modification, are permitted provided that the 
// following conditions are met:
//
// Redistributions of source code must retain the above 
// copyright notice, this list of conditions and the 
// following disclaimer.
// 
// Redistributions in binary form must reproduce the above 
// copyright notice, this list of conditions and the 
// following disclaimer in the documentation and/or other 
// materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND 
// CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR 
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
// DAMAGE.
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
