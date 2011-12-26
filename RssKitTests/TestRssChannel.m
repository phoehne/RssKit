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
#import "RssCategory.h"
#import "RssCloud.h"
#import "RssImage.h"
#import "RssTextInput.h"

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

-(void)testOptionalElements 
{
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample2.xml" withExtension:nil]];
    RssRoot* root = [locator retrieveFeed];
    
    RssChannel* channel = [root channel];
    STAssertNotNil([channel language], @"Optional element langauge should be present in sample2.xml");
    STAssertNotNil([channel copyright], @"Optional eleemnt copyright should be present in sampel2.xml");
    STAssertNotNil([channel managingEditor], @"Optional element managingEditor should be present in sample2.xml");
    STAssertNotNil([channel webMaster], @"Optional element webMaster should be present in sample2.xmo");
    STAssertNotNil([channel pubDate], @"Optional element pubDate should be present in sample2.xml");
    STAssertNotNil([channel lastBuildDate], @"Optional element lastBuildDate should be present in sample2.xmo");
    STAssertNotNil([channel categories], @"Optional element categories should be present in sample2.xml");
    STAssertNotNil([channel generator], @"Optional element generator should be present in sample2.xml");
    STAssertNotNil([channel docs], @"Optional element docs should be present in sample2.xml");
    STAssertNotNil([channel cloud], @"Optional element cloud should be present in sample2.xml");
    STAssertNotNil([channel ttl], @"Optional element ttl should be present in sample2.xmo");
    STAssertNotNil([channel image], @"Optional element image should be present in sample2.xml");
    STAssertNotNil([channel rating], @"Optional element rating should be present ins sample2.xml");
    STAssertNotNil([channel textInput], @"Optional element textInput should be present in sample2.xml");
    STAssertNotNil([channel skipHours], @"Optional element skipHours should be present in sample2.xml");
    STAssertNotNil([channel skipDays], @"Optional element skipDays should be present in sample2.xml");
}

-(void)testOptionalValues
{
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample2.xml" withExtension:nil]];
    RssRoot* root = [locator retrieveFeed];
    
    RssChannel* channel = [root channel];
    STAssertEqualObjects(@"en-us", [channel language], 
                         @"Optional element langauge is not valid in sample2.xml");
    STAssertEqualObjects(@"Copyright 2011, Major Eastern Syndicate", [channel copyright], 
                         @"Optional eleemnt copyright should be present in sampel2.xml");
    STAssertEqualObjects(@"editor@example.com", [channel managingEditor], 
                         @"Optional element managingEditor is not valid in sample2.xml");
    STAssertEqualObjects(@"webmaster@example.com", [channel webMaster], 
                         @"Optional element webMaster is not valid in sample2.xmo");
    STAssertEqualObjects(@"Tue, 10 Jun 2003 04:00:00 GMT", [channel pubDate], 
                         @"Optional element pubDate is not valid in sample2.xml");
    STAssertEqualObjects(@"Tue, 10 Jun 2003 09:41:01 GMT", [channel lastBuildDate], 
                         @"Optional element lastBuildDate sis not valid in sample2.xmo");
    STAssertEqualObjects(@"Weblog Editor 2.0", [channel generator], 
                         @"Optional element generator is not valid in sample2.xml");
    STAssertEqualObjects(@"http://www.rssboard.org/rss-specification", [channel docs], 
                         @"Optional element docs is not valid in sample2.xml");
    STAssertEqualObjects(@"480", [channel ttl], 
                         @"Optional element ttl is not valid in sample2.xmo");
}

-(void)testCategories
{
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample2.xml" withExtension:nil]];
    RssRoot* root = [locator retrieveFeed];
    RssChannel* channel = [root channel];
    
    STAssertEquals((NSUInteger)2, [[channel categories] count], @"There should be 2 categories in the sample2.xml file.");
    RssCategory* category = [[channel categories] objectAtIndex:0];
    STAssertNotNil([category domain], @"First category in sample2.xml should have a domain");
    STAssertEqualObjects(@"http://foo.bar.com/domains#somedomain", [category domain], 
                         @"Invalid domain value for first category in sample2.xml");
    
    STAssertNotNil([category text], @"First category in sample2.xml should have a text value");
    STAssertEqualObjects(@"Science", [category text], 
                         @"First category in sample2.xml have Science as its value");
    
    category = [[channel categories] objectAtIndex:1];
    STAssertNil([category domain], @"Second category in sample2.xml should not have a domain");
    STAssertNotNil([category text], @"Second category in sample2.xml should have a text value");
    
    STAssertEqualObjects(@"News", [category text], 
                         @"First category in sample2.xml have News as its value");
}

-(void)testCloud 
{
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample2.xml" withExtension:nil]];
    RssRoot* root = [locator retrieveFeed];
    RssChannel* channel = [root channel];
    
    STAssertNotNil([channel cloud], @"Channel element shouldhave a cloud in sample2.xml");
    RssCloud* cloud = [channel cloud];
    
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
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample2.xml" withExtension:nil]];
    RssRoot* root = [locator retrieveFeed];
    RssChannel* channel = [root channel];
    
    STAssertNotNil([channel image], @"There should be in image the sample2.xml file");
    RssImage* image = [channel image];
    
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
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample2.xml" withExtension:nil]];
    
    RssRoot* root = [locator retrieveFeed];
    RssChannel* channel = [root channel];
    
    STAssertNotNil([channel textInput], @"There should be a text input in sample2.xml");
    RssTextInput* textInput = [channel textInput];
    
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
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample2.xml" withExtension:nil]];
    
    RssRoot* root = [locator retrieveFeed];
    RssChannel* channel = [root channel];
    
    STAssertNotNil([channel skipHours], @"Skip hours should not be null in sample2.xml");
    STAssertEquals([[channel skipHours] count], (NSUInteger)7, @"There should be seven skp hours in sample2.xml");
    
    for(NSUInteger i = 0; i < 7; i++) {
        NSUInteger number = [[[channel skipHours] objectAtIndex:i] intValue];
        STAssertEquals(i, number, @"Skip hours should have been %d in sample2.xml but was %d", i, number);
    }
}

-(void)testSkipDays {
    RssLocator* locator = [[RssLocator alloc] init];
    [locator setFeedUrl: [[NSBundle bundleForClass:[self class]] URLForResource:@"sample2.xml" withExtension:nil]];
    
    RssRoot* root = [locator retrieveFeed];
    RssChannel* channel = [root channel];
    
    STAssertNotNil([channel skipDays], @"Skip days should not be null in sample2.xml");
    STAssertEquals([[channel skipDays] count], (NSUInteger)2, @"There should be 2 skip days in sample2.xml");
    
    STAssertEqualObjects([[channel skipDays] objectAtIndex:0], @"Saturday", 
                         @"The first skip day in sample2.xml should be Saturday");
    STAssertEqualObjects([[channel skipDays] objectAtIndex:1], @"Sunday", 
                         @"The second skip day in sample2.xml should be Sunday");
}

@end
