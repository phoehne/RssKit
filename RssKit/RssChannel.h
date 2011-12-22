//
//  Channel.h
//  QuickChart
//
//  Created by Paul Hoehne on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RssImage;
@class RssCloud;
@class RssTextInput;

@interface RssChannel : NSObject {
    
}

@property (strong) NSString* title;
@property (strong) NSString* copyright;
@property (strong) NSString* link;
@property (strong) NSString* description;
@property (strong) NSString* language;
@property (strong) NSString* lastBuildDate;
@property (strong) NSString* managingEditor;
@property (strong) NSString* webMaster;
@property (strong) NSString* pubDate;
@property (strong) NSArray* categories;
@property (strong) NSString* generator;
@property (strong) NSString* docs;
@property (strong) NSString* rating;
@property (strong) RssCloud* cloud;
@property (assign) int skipHours;
@property (strong) NSArray* skipDays;
@property (strong) NSString* ttl;
@property (strong) RssTextInput* textInput;
@property (strong) RssImage* image;
@property (strong) NSArray* items;
@end
