//
//  TestRssItem.m
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


#import "TestRssItem.h"
#import "RssLocator.h"
#import "RssRoot.h"
#import "RssChannel.h"
#import "RssItem.h"
#import "RssCategory.h"
#import "RssEnclosure.h"
#import "RssSource.h"

@implementation TestRssItem


-(void) setUp {
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample2.xml" withExtension:nil]];
    
    RssRoot* root = [locator retrieveFeed];
    channel = [root channel];
    item = [[channel items] objectAtIndex: 0];
}


// All code under test must be linked into the Unit Test bundle
-(void)testOptional 
{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    STAssertEquals((NSUInteger)1, [[channel items] count], @"There should be one item in sample2.xml");
    
    STAssertEqualObjects(@"Star City", [item title], 
                         @"The title for sample2.xml should be 'Star City'");
    STAssertEqualObjects(@"http://liftoff.msfc.nasa.gov/news/2003/news-starcity.asp", [item link], 
                         @"The link for sample2.xml should be 'http://liftoff.msfc.nasa.gov/news/2003/news-starcity.asp'");
    STAssertEqualObjects(@"The story <a href=\"http://foo.com/m\">Link</a>.", [item rssDescription], 
                         @"The story does not match the expected value for sample2.xml");
    STAssertEqualObjects([dateFormatter dateFromString: @"Tue, 03 Jun 2003 09:39:21 GMT"], [item pubDate], 
                         @"The pub date should be 'Tue, 03 Jun 2003 09:39:21 GMT' for sample2.xml");
    STAssertEqualObjects(@"joe.author@foo.bar.com (Joe Author)", [item author], 
                         @"The e-mail address should be 'joe.author@foo.bar.com (Joe Author)' for sample2.xml");
    STAssertEqualObjects(@"http://foo.bar.com/news/1234/comments", [item comments], 
                         @"The comments should be 'http://foo.bar.com/news/1234/comments' for sample2.xml");
}

-(void)testCategories 
{
    STAssertEquals((NSUInteger)3, [[item categories] count], @"There should be 3 categories in item in sample2.xml");
    RssCategory *one, *two, *three;
    one = [[item categories] objectAtIndex:0];
    two = [[item categories] objectAtIndex:1];
    three = [[item categories] objectAtIndex:2];
    
    STAssertEqualObjects(@"http://foo.bar.com/domains#somedomain", [one domain],
                         @"First category domain name %@ does not match sample2.xml", [one domain]);
    STAssertEqualObjects(@"Science", [one text], 
                         @"First category text %@ does not match sample2.xml", [one text]);
    STAssertEqualObjects(@"http://foo.bar.com/domains#somedomain", [two domain], 
                         @"Second category domain %@ does not match sample2.xml", [two domain]);
    STAssertEqualObjects(@"Russia", [two text], 
                         @"Second category text %@ does not match sample2.xml", [two text]);
    STAssertNil([three domain], @"The third category in sample2.xml should have a blank domain");
    STAssertEqualObjects(@"ISS", [three text], 
                         @"Third category text %@ does not match sample2.xml", [three text]);
}

-(void)testEnclosure 
{
    STAssertNotNil([item enclosure], @"There should be an enclosure for item in sample2.xml");
    
    STAssertEqualObjects(@"http://foo.bar.com/media/sound/starcity.mp3", [[item enclosure] url], 
                         @"The url %@ of enclosure for item in sample2.xml is incorrect", [[item enclosure] url]);
    STAssertEquals(12345678, [[item enclosure] length], 
                   @"The length of the enclosure resource in the item in sample2.xml should be 12345678");
    STAssertEqualObjects(@"audio/mpeg", [[item enclosure] mimeType], 
                         @"The mime type %@ of enclosure for item in sample2.xml is incorrect", [[item enclosure] mimeType]);
}

-(void)testSource 
{
    STAssertNotNil([item source], @"There should be a source for the item in sample2.xml");
    
    STAssertEqualObjects(@"http://wunderbar.spaceflight.com/newsagg/feed.rss", [[item source] url], 
                         @"The url %@ of source for item in sample2.xml is incorrect.", [[item source] url]);
    STAssertEqualObjects(@"wunderbar spaceflight", [[item source] text], 
                         @"The text %@ of source for item in sample2.xml is incorrect.", [[item source] text]);
}

@end
