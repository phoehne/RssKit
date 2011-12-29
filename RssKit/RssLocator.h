//
//  RssLocator.h
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


#import <Foundation/Foundation.h>
#include <libxml/parser.h>
#include <libxml/tree.h>
#include <libxml/xmlstring.h>

@class RssRoot;
@class RssItem;
@class RssImage;
@class RssTextInput;
@class RssCloud;
@class RssCategory;
@class RssEnclosure;
@class RssSource;

@interface RssLocator : NSObject {
    xmlChar* titleStr;
    xmlChar* copyrightStr;
    xmlChar* linkStr;
    xmlChar* descriptionStr;
    xmlChar* languageStr;
    xmlChar* lastBuildDateStr;
    xmlChar* guidStr;
    xmlChar* pubDateStr;
    xmlChar* imageStr;
    xmlChar* itemStr;
    xmlChar* urlStr;
    xmlChar* widthStr;
    xmlChar* heightStr;
    xmlChar* isPermaLinkStr;
    xmlChar* managingEditorStr;
    xmlChar* webMasterStr;
    xmlChar* categoryStr;
    xmlChar* generatorStr;
    xmlChar* docsStr;
    xmlChar* cloudStr;
    xmlChar* ttlStr;
    xmlChar* ratingStr;
    xmlChar* textInputStr;
    xmlChar* skipHoursStr;
    xmlChar* skipDaysStr;
    xmlChar* authorStr;
    xmlChar* commentsStr;
    xmlChar* enclosureStr;
    xmlChar* sourceStr;
    xmlChar* dayStr;
    xmlChar* nameStr;
    xmlChar* portStr;
    xmlChar* domainStr;
    xmlChar* registerProcedureStr;
    xmlChar* pathStr;
    xmlChar* protoclStr;
    xmlChar* htmlStr;
    xmlChar* headStr;
    xmlChar* bodyStr;
    xmlChar* rssStr;
    xmlChar* hourStr;
    xmlChar* lengthStr;
    xmlChar* typeStr;
    NSDateFormatter* dateFormatter;
}

@property (strong) NSString* ticker;
@property (strong) NSURL* feedUrl;

-(RssRoot*) retrieveFeed;

-(RssItem*) processItem: (xmlNode*)node;
-(RssImage*) processImage: (xmlNode*)node;
-(NSArray*) processSkipDays: (xmlNode*)node;
-(NSArray*) processSkipHours: (xmlNode*)node;
-(RssTextInput*) processTextInput: (xmlNode*)node;
-(RssCloud*) processCloud: (xmlNode*)node;
-(RssCategory*) processCategory: (xmlNode*)node;
-(RssEnclosure*) processEnclosure: (xmlNode*)node;
-(RssSource*) processSource: (xmlNode*)node;

@end
