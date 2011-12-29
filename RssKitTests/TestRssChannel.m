//
//  TestRssChannel.m
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


#import "TestRssChannel.h"
#import "RssLocator.h"
#import "RssRoot.h"
#import "RssChannel.h"
#import "RssCategory.h"
#import "RssCloud.h"
#import "RssImage.h"
#import "RssTextInput.h"

@implementation TestRssChannel

-(void)setUp {
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample.xml" withExtension:nil]];
    RssRoot* root = [locator retrieveFeed];
    
    channelOne = [root channel];
    
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample2.xml" withExtension:nil]];
    root = [locator retrieveFeed];
    channelTwo = [root channel];
}

// All code under test must be linked into the Unit Test bundle
- (void)testChannleRequiredElements
{
    STAssertNotNil([channelOne title], @"There must always be a title as in the test document");
    STAssertNotNil([channelOne link],  @"There must always be a link as in the test document");
    STAssertNotNil([channelOne description], @"There must always be a description in the test document.");
    
    STAssertEqualObjects([channelOne title], @"Liftoff News", 
                         @"The sample test document's title should be 'Liftoff News'");
    STAssertEqualObjects([channelOne link], @"http://liftoff.msfc.nasa.gov/", 
                         @"The sample test document's link should be 'http://liftoff.msfc.nasa.gov/'");
    STAssertEqualObjects([channelOne description], @"Liftoff to Space Exploration.",
                         @"The sample test document's description should be 'Liftoff to Space Exploration.");
}

-(void)testOptionalElements 
{
    STAssertNotNil([channelTwo language], @"Optional element langauge should be present in sample2.xml");
    STAssertNotNil([channelTwo copyright], @"Optional eleemnt copyright should be present in sampel2.xml");
    STAssertNotNil([channelTwo managingEditor], @"Optional element managingEditor should be present in sample2.xml");
    STAssertNotNil([channelTwo webMaster], @"Optional element webMaster should be present in sample2.xmo");
    STAssertNotNil([channelTwo pubDate], @"Optional element pubDate should be present in sample2.xml");
    STAssertNotNil([channelTwo lastBuildDate], @"Optional element lastBuildDate should be present in sample2.xmo");
    STAssertNotNil([channelTwo categories], @"Optional element categories should be present in sample2.xml");
    STAssertNotNil([channelTwo generator], @"Optional element generator should be present in sample2.xml");
    STAssertNotNil([channelTwo docs], @"Optional element docs should be present in sample2.xml");
    STAssertNotNil([channelTwo cloud], @"Optional element cloud should be present in sample2.xml");
    STAssertNotNil([channelTwo ttl], @"Optional element ttl should be present in sample2.xmo");
    STAssertNotNil([channelTwo image], @"Optional element image should be present in sample2.xml");
    STAssertNotNil([channelTwo rating], @"Optional element rating should be present ins sample2.xml");
    STAssertNotNil([channelTwo textInput], @"Optional element textInput should be present in sample2.xml");
    STAssertNotNil([channelTwo skipHours], @"Optional element skipHours should be present in sample2.xml");
    STAssertNotNil([channelTwo skipDays], @"Optional element skipDays should be present in sample2.xml");
}

-(void)testOptionalValues
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"EEE, dd MMM yyyy HH:mm:ss zzz"];
    [dateFormatter setLocale: [NSLocale currentLocale]];
    
    STAssertEqualObjects(@"en-us", [channelTwo language], 
                         @"Optional element langauge is not valid in sample2.xml");
    STAssertEqualObjects(@"Copyright 2011, Major Eastern Syndicate", [channelTwo copyright], 
                         @"Optional eleemnt copyright should be present in sampel2.xml");
    STAssertEqualObjects(@"editor@example.com", [channelTwo managingEditor], 
                         @"Optional element managingEditor is not valid in sample2.xml");
    STAssertEqualObjects(@"webmaster@example.com", [channelTwo webMaster], 
                         @"Optional element webMaster is not valid in sample2.xmo");
    STAssertEqualObjects([dateFormatter dateFromString: @"Tue, 10 Jun 2003 04:00:00 GMT"], 
                         [channelTwo pubDate], @"Optional element pubDate is not valid in sample2.xml");

    STAssertEqualObjects([dateFormatter dateFromString: @"Tue, 10 Jun 2003 09:41:01 GMT"], 
                         [channelTwo lastBuildDate], 
                         @"Optional element lastBuildDate sis not valid in sample2.xmo");
    STAssertEqualObjects(@"Weblog Editor 2.0", [channelTwo generator], 
                         @"Optional element generator is not valid in sample2.xml");
    STAssertEqualObjects(@"http://www.rssboard.org/rss-specification", [channelTwo docs], 
                         @"Optional element docs is not valid in sample2.xml");
    STAssertEqualObjects(@"480", [channelTwo ttl], 
                         @"Optional element ttl is not valid in sample2.xmo");
}

-(void)testCategories
{
    STAssertEquals((NSUInteger)2, [[channelTwo categories] count], @"There should be 2 categories in the sample2.xml file.");
    RssCategory* category = [[channelTwo categories] objectAtIndex:0];
    STAssertNotNil([category domain], @"First category in sample2.xml should have a domain");
    STAssertEqualObjects(@"http://foo.bar.com/domains#somedomain", [category domain], 
                         @"Invalid domain value for first category in sample2.xml");
    
    STAssertNotNil([category text], @"First category in sample2.xml should have a text value");
    STAssertEqualObjects(@"Science", [category text], 
                         @"First category in sample2.xml have Science as its value");
    
    category = [[channelTwo categories] objectAtIndex:1];
    STAssertNil([category domain], @"Second category in sample2.xml should not have a domain");
    STAssertNotNil([category text], @"Second category in sample2.xml should have a text value");
    
    STAssertEqualObjects(@"News", [category text], 
                         @"First category in sample2.xml have News as its value");
}

-(void)testCloud 
{
    STAssertNotNil([channelTwo cloud], @"Channel element shouldhave a cloud in sample2.xml");
    RssCloud* cloud = [channelTwo cloud];
    
    STAssertEqualObjects(@"foo.bar.com", [cloud domain], 
                         @"Cloud should have the foo.bar.com domain in sample2.xml");
    STAssertEqualObjects(@"/apis/news", [cloud path], 
                         @"Cloud should have the /apis/news path in sample2.xml");
    STAssertEqualObjects(@"register.do", [cloud registerProcedure], 
                         @"Cloud should have the register.do registerProcedure in sample2.xml");
    STAssertEqualObjects(@"xml-rpc", [cloud protocol], 
                         @"Cloud should have the xml-rpc protocol in sample2.xml");
    STAssertEquals(80, [cloud port], @"Cloud should have the value 80 for port in sample2.xml");
}

-(void)testImage {
    STAssertNotNil([channelTwo image], @"There should be in image the sample2.xml file");
    RssImage* image = [channelTwo image];
    
    STAssertEqualObjects(@"http://foo.bar.com/images/scienceNews.gif", [image url], 
                         @"Image should have the http://foo.bar.com/images/scienceNews.gif url");
    STAssertEqualObjects(@"Liftoff News", [image title], 
                         @"Image should have the title 'Liftoff News' in sample2.xml");
    STAssertEqualObjects(@"http://liftoff.msfc.nasa.gov/", [image link], 
                         @"Image should have the link http://liftoff.msfc.nasa.gov/ in sample2.xml");
    STAssertEquals(100, [image width], @"Image Width should be 100 in sample2.xml");
    STAssertEquals(35, [image height], @"Image height should be 35 in sample2.xml");
    STAssertEqualObjects(@"Science News Banner Image", [image rssDescription], 
                         @"Descripiton should be 'Science News Banner Image' in sample2.xml");
}

-(void)testTextInput {
    STAssertNotNil([channelTwo textInput], @"There should be a text input in sample2.xml");
    RssTextInput* textInput = [channelTwo textInput];
    
    STAssertEqualObjects(@"Search for news", [textInput title], 
                         @"The text item should have the title 'Search for news' in sample2.xml");
    STAssertEqualObjects(@"Enter a topic to search of particular stories", [textInput rssDescription], 
                         @"The text item should have a description 'Enter a topic to search of particular stories' in sample2.xml");
    STAssertEqualObjects(@"searchtext", [textInput name], 
                         @"The text item should have a name 'searchtext' in sample2.xml");
    STAssertEqualObjects(@"http://foo.bar.com/news/search", [textInput link], 
                         @"The text item should have a link 'http://foo.bar.com/news/search' in samepl2.xml");
}

-(void)testSkipHours {
    STAssertNotNil([channelTwo skipHours], @"Skip hours should not be null in sample2.xml");
    STAssertEquals([[channelTwo skipHours] count], (NSUInteger)7, @"There should be seven skp hours in sample2.xml");
    
    for(NSUInteger i = 0; i < 7; i++) {
        NSUInteger number = [[[channelTwo skipHours] objectAtIndex:i] intValue];
        STAssertEquals(i, number, @"Skip hours should have been %d in sample2.xml but was %d", i, number);
    }
}

-(void)testSkipDays {
    STAssertNotNil([channelTwo skipDays], @"Skip days should not be null in sample2.xml");
    STAssertEquals([[channelTwo skipDays] count], (NSUInteger)2, @"There should be 2 skip days in sample2.xml");
    
    STAssertEqualObjects([[channelTwo skipDays] objectAtIndex:0], @"Saturday", 
                         @"The first skip day in sample2.xml should be Saturday");
    STAssertEqualObjects([[channelTwo skipDays] objectAtIndex:1], @"Sunday", 
                         @"The second skip day in sample2.xml should be Sunday");
}

@end
