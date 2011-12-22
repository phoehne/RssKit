//
//  RssLocator.h
//  QuickChart
//
//  Created by Paul Hoehne on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
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
}

@property (strong) NSString* ticker;
@property (strong) NSString* feedUrl;

-(RssRoot*) retrieveFeed;

-(RssItem*) processItem: (xmlNode*)node;
-(RssImage*) processImage: (xmlNode*)node;
-(NSArray*) processSkipDays: (xmlNode*)node;
-(RssTextInput*) processTextInput: (xmlNode*)node;
-(RssCloud*) processCloud: (xmlNode*)node;
-(RssCategory*) processCategory: (xmlNode*)node;

@end
