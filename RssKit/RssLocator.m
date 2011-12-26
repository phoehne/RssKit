//
//  RssLocator.m
//  QuickChart
//
//  Created by Paul Hoehne on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
// http://feeds.finance.yahoo.com/rss/2.0/headline?s=AAPL&region=US&lang=en-US
//

#import "RssLocator.h"
#import "RssRoot.h"
#import "RssItem.h"
#import "RssImage.h"
#import "RssChannel.h"
#import "RssTextInput.h"
#import "RssCloud.h"
#import "RssCategory.h"
#import "RssEnclosure.h"
#import "RssSource.h"

@implementation RssLocator

@synthesize ticker, feedUrl;

-(id) init {
    self = [super init];
    
    titleStr = xmlCharStrdup("title");
    copyrightStr = xmlCharStrdup("copyright");
    linkStr = xmlCharStrdup("link");
    descriptionStr = xmlCharStrdup("description");
    languageStr = xmlCharStrdup("language");
    lastBuildDateStr = xmlCharStrdup("lastBuildDate");
    guidStr = xmlCharStrdup("guid");
    pubDateStr = xmlCharStrdup("pubDate");
    imageStr = xmlCharStrdup("image");
    itemStr = xmlCharStrdup("item");
    urlStr = xmlCharStrdup("url");
    widthStr = xmlCharStrdup("width");
    heightStr = xmlCharStrdup("height");
    
    isPermaLinkStr = xmlCharStrdup("isPermaLink");
    
    managingEditorStr = xmlCharStrdup("managingEditor");
    webMasterStr = xmlCharStrdup("webMaster");
    categoryStr = xmlCharStrdup("category");
    generatorStr = xmlCharStrdup("generator");
    docsStr = xmlCharStrdup("docs");
    cloudStr = xmlCharStrdup("cloud");
    ttlStr = xmlCharStrdup("ttl");
    ratingStr = xmlCharStrdup("rating");
    textInputStr = xmlCharStrdup("textInput");
    skipHoursStr = xmlCharStrdup("skipHours");
    skipDaysStr = xmlCharStrdup("skipDays");
    authorStr = xmlCharStrdup("author");
    commentsStr = xmlCharStrdup("comments");
    enclosureStr = xmlCharStrdup("enclosure");
    sourceStr = xmlCharStrdup("source");
    
    dayStr = xmlCharStrdup("day");
    nameStr = xmlCharStrdup("name");
    
    domainStr = xmlCharStrdup("domain");
    portStr = xmlCharStrdup("port");
    pathStr = xmlCharStrdup("path");
    registerProcedureStr = xmlCharStrdup("registerProcedure");
    protoclStr = xmlCharStrdup("protocol");
    
    htmlStr = xmlCharStrdup("html");
    headStr = xmlCharStrdup("head");
    bodyStr = xmlCharStrdup("body");
    rssStr = xmlCharStrdup("rss");
    hourStr = xmlCharStrdup("hour");
    
    lengthStr = xmlCharStrdup("length");
    typeStr = xmlCharStrdup("type");
    
    return self;
}

-(void) dealloc {
    free(titleStr);
    free(copyrightStr);
    free(linkStr);
    free(descriptionStr);
    free(languageStr);
    free(lastBuildDateStr);
    free(guidStr);
    free(pubDateStr);
    free(imageStr);
    free(itemStr);
    
    free(managingEditorStr);
    free(webMasterStr);
    free(categoryStr);
    free(generatorStr);
    free(docsStr);
    free(cloudStr);
    free(ttlStr);
    free(ratingStr);
    free(textInputStr);
    free(skipHoursStr);
    free(skipDaysStr);
    free(authorStr);
    free(commentsStr);
    free(enclosureStr);
    free(sourceStr);
    
    free(nameStr);
    
    free(domainStr);
    free(portStr);
    free(pathStr);
    free(registerProcedureStr);
    free(protoclStr);
    
    free(htmlStr);
    free(headStr);
    free(bodyStr);
    free(rssStr);
    
    free(hourStr);
    
    free(lengthStr);
    free(typeStr);
    
}

-(void) handleChannelAttributes: (xmlNode*)node forChannle: (RssChannel*)rssChannel {
    const char* contentString = (const char*)xmlNodeGetContent(node->children);
    NSString* nativeString = [NSString stringWithUTF8String: contentString];
    
    if(xmlStrcmp(titleStr, node->name) == 0)               { [rssChannel setTitle: nativeString]; } 
    else if(xmlStrcmp(copyrightStr, node->name) == 0)      { [rssChannel setCopyright: nativeString]; } 
    else if(xmlStrcmp(linkStr, node->name) == 0)           { [rssChannel setLink: nativeString]; } 
    else if(xmlStrcmp(descriptionStr, node->name) == 0)    { [rssChannel setDescription: nativeString]; } 
    else if(xmlStrcmp(languageStr, node->name) == 0)       { [rssChannel setLanguage: nativeString]; } 
    else if(xmlStrcmp(lastBuildDateStr, node->name) == 0)  { [rssChannel setLastBuildDate: nativeString]; } 
    else if(xmlStrcmp(pubDateStr, node->name) == 0)        { [rssChannel setPubDate: nativeString]; } 
    else if(xmlStrcmp(managingEditorStr, node->name) == 0) { [rssChannel setManagingEditor:nativeString]; } 
    else if(xmlStrcmp(webMasterStr, node->name) == 0)      { [rssChannel setWebMaster:nativeString]; }
    else if(xmlStrcmp(generatorStr, node->name) == 0)      { [rssChannel setGenerator:nativeString]; }
    else if(xmlStrcmp(docsStr, node->name) == 0)           { [rssChannel setDocs:nativeString]; }
    else if(xmlStrcmp(ttlStr, node->name) == 0)            { [rssChannel setTtl:nativeString]; }
    else if(xmlStrcmp(ratingStr, node->name) == 0)         { [rssChannel setRating:nativeString]; }
}

-(RssRoot*) retrieveFeed {
    xmlDoc* doc = NULL;
    xmlNode* root = NULL;
    xmlNode* channel = NULL;
    RssRoot* rssRoot = [[RssRoot alloc] init];
    RssChannel* rssChannel = [[RssChannel alloc] init];
    NSMutableArray* itemArray = [[NSMutableArray alloc] init];
    NSMutableArray* categoryArray = [[NSMutableArray alloc] init];
    
    if(feedUrl == nil) { 
        @throw [NSException exceptionWithName:@"NoFeedUrl" 
                                       reason:@"No feed URL was specified for this RssLocator" 
                                     userInfo:nil];
    }
    
    doc = xmlReadFile([[[self feedUrl] absoluteString] cStringUsingEncoding:NSASCIIStringEncoding], NULL, 
                      XML_PARSE_RECOVER | XML_PARSE_DTDLOAD | XML_PARSE_PEDANTIC);
    
    if(doc == NULL) {
        @throw [NSException exceptionWithName:@"NoDocumentReturned" 
                                       reason:[NSString stringWithFormat:@"Unable to retrieve a valid document from %@", [self feedUrl]] 
                                     userInfo:nil];
    }
    
    root = xmlDocGetRootElement(doc);
    
    if(xmlStrcmp(root->name, rssStr)) {
        @throw [NSException exceptionWithName:@"InvalidDocumentReturned" 
                                       reason:@"The document does not appear to be an RSS feed" 
                                     userInfo:nil];
    }
    
    channel = root->children;
    while((channel->type != XML_ELEMENT_NODE) && (channel != NULL)) { 
        channel = channel->next;
    }
    
    if(channel == NULL) { 
        @throw [NSException exceptionWithName:@"InvalidDocumentReturned" 
                                       reason:@"The document does not appear to be an RSS feed" 
                                     userInfo:nil];
    }
    
    for(xmlNode* node = channel->children; node != NULL; node = node->next) {
        if(node->type == XML_ELEMENT_NODE) {
            if(xmlStrcmp(itemStr, node->name) == 0) {
                RssItem* item = [self processItem:node];
                if(item != nil) { 
                    [itemArray addObject: item]; 
                };
            } else if(xmlStrcmp(imageStr, node->name) == 0) {
                [rssChannel setImage: [self processImage: node]];
            } else if(xmlStrcmp(skipDaysStr, node->name) == 0) {
                [rssChannel setSkipDays: [self processSkipDays: node]];
            } else if(xmlStrcmp(textInputStr, node->name) == 0) {
                [rssChannel setTextInput: [self processTextInput: node]];
            } else if(xmlStrcmp(cloudStr, node->name) == 0) {
                [rssChannel setCloud: [self processCloud: node]];
            } else if(xmlStrcmp(categoryStr, node->name) == 0) {
                RssCategory* category = [self processCategory:node];
                if(category != nil) { 
                    [categoryArray addObject: category];
                }
            } else if(xmlStrcmp(skipHoursStr, node->name) == 0) {
                [rssChannel setSkipHours: [self processSkipHours:node]];
            } else {
                [self handleChannelAttributes:node forChannle:rssChannel];
            }
        }
    }
    
    [rssChannel setItems: itemArray];
    [rssChannel setCategories:categoryArray];
    [rssRoot setChannel: rssChannel];
    xmlFree(doc);
    xmlCleanupParser();
    return rssRoot;
}

-(RssItem*) processItem:(xmlNode *)node {
    xmlNode* itemChild;
    if(node == NULL) { return nil; }
    RssItem* result = [[RssItem alloc] init];
    NSMutableArray* categoryArray = [[NSMutableArray alloc] init];
    
    for(itemChild = node->children; itemChild != NULL; itemChild = itemChild->next) {
        if(itemChild->type == XML_ELEMENT_NODE) { 
            const char* contentString = (const char*)xmlNodeGetContent(itemChild);
            if(xmlStrcmp(linkStr, itemChild->name) == 0) {
                [result setLink: [NSString stringWithUTF8String: contentString]];
            } else if(xmlStrcmp(titleStr, itemChild->name) == 0) {
                [result setTitle: [NSString stringWithUTF8String: contentString]];
            } else if(xmlStrcmp(guidStr, itemChild->name) == 0) {
                [result setGuid: [NSString stringWithUTF8String: contentString]];
                xmlChar* prop = xmlGetProp(itemChild, isPermaLinkStr);
                if(prop != NULL) {
                    NSString* converted = [NSString stringWithUTF8String: (const char*)prop];
                    if(![converted isEqualToString:@"false"]) {
                        [result setIsPermaLink:YES];
                    }
                }
            } else if(xmlStrcmp(pubDateStr, itemChild->name) == 0) {
                [result setPubDate: [NSString stringWithUTF8String: contentString]];
            } else if(xmlStrcmp(authorStr, itemChild->name) == 0) {
                [result setAuthor: [NSString stringWithUTF8String:contentString]];
            } else if(xmlStrcmp(descriptionStr, itemChild->name) == 0) {
                [result setRssDescription: [NSString stringWithUTF8String:contentString]];
            } else if(xmlStrcmp(commentsStr, itemChild->name) == 0) {
                [result setComments: [NSString stringWithUTF8String:contentString]];
            } else if(xmlStrcmp(categoryStr, itemChild->name) == 0) {
                RssCategory* category = [self processCategory: itemChild];
                if(category != nil) {
                    [categoryArray addObject:category];
                }
            } else if(xmlStrcmp(enclosureStr, itemChild->name) == 0) {
                [result setEnclosure:[self processEnclosure:itemChild]];
            } else if(xmlStrcmp(sourceStr, itemChild->name) == 0) {
                [result setSource: [self processSource:itemChild]];
            }
        }
    }
    
    [result setCategories:categoryArray];
    
    return result;
}

-(RssImage*) processImage: (xmlNode*)node {
    xmlNode* imageChild;
    if(node == NULL) { return nil; }
    RssImage* result = [[RssImage alloc] init];
    
    for(imageChild = node->children; imageChild != NULL; imageChild = imageChild->next) {
        if(imageChild->type == XML_ELEMENT_NODE) {
            const char* contentString = (const char*)xmlNodeGetContent(imageChild);
            if(xmlStrcmp(urlStr, imageChild->name) == 0) {
                [result setUrl: [NSString stringWithUTF8String: contentString]];
            } else if(xmlStrcmp(titleStr, imageChild->name) == 0) {
                [result setTitle: [NSString stringWithUTF8String: contentString]];
            } else if(xmlStrcmp(linkStr, imageChild->name) == 0) {
                [result setLink: [NSString stringWithUTF8String: contentString]];
            } else if(xmlStrcmp(widthStr, imageChild->name) == 0) {
                [result setWidth: [[NSString stringWithUTF8String: contentString] intValue]];
            } else if(xmlStrcmp(descriptionStr, imageChild->name) == 0) {
                [result setRssDescription: [NSString stringWithUTF8String: contentString]];
            } else if(xmlStrcmp(heightStr, imageChild->name) == 0) {
                [result setHeight: [[NSString stringWithUTF8String: contentString] intValue]];
            }
        }
    }
    return result;
}

-(NSArray*) processSkipHours:(xmlNode *)node {
    xmlNode* currentHour;
    NSMutableArray* skipHours = [[NSMutableArray alloc] init];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    
    for(currentHour = node->children; currentHour != NULL; currentHour = currentHour->next) {
        if(currentHour->type == XML_ELEMENT_NODE) {
            const char* hourText = (const char*)xmlNodeGetContent(currentHour->children);
            if(hourStr != NULL) {
                [skipHours addObject: [formatter numberFromString: [NSString stringWithUTF8String:hourText]]];
            }
        }
    }
    return skipHours;
}

-(NSArray*) processSkipDays: (xmlNode*)node {
    xmlNode* currentDay;
    NSMutableArray* skipDays = [[NSMutableArray alloc] init];
    
    for(currentDay = node->children; currentDay != NULL; currentDay = currentDay->next) {
        if(currentDay->type == XML_ELEMENT_NODE) {
            if(xmlStrcmp(dayStr, currentDay->name) == 0) {
                const char* dayName = (const char*)xmlNodeGetContent(currentDay->children);
                if(dayName != NULL) {
                    [skipDays addObject: [NSString stringWithUTF8String:dayName]];
                }
            }
        }
    }
    
    return skipDays;
}

-(RssTextInput*) processTextInput: (xmlNode*)node {
    RssTextInput* result = [[RssTextInput alloc] init];
    xmlNode* currentNode;
    
    for(currentNode = node->children; currentNode != NULL; currentNode = currentNode->next) {
        if(currentNode->type == XML_ELEMENT_NODE) {
            NSString* nativeString = [NSString stringWithUTF8String: (const char*)xmlNodeGetContent(currentNode)];
            if(xmlStrcmp(titleStr, currentNode->name) == 0) {
                [result setTitle:nativeString];
            } else if(xmlStrcmp(descriptionStr, currentNode->name) == 0) {
                [result setRssDescription:nativeString];
            } else if(xmlStrcmp(nameStr, currentNode->name) == 0) {
                [result setName:nativeString];
            } else if(xmlStrcmp(linkStr, currentNode->name) == 0) {
                [result setLink:nativeString];
            }
        }
    }
    
    
    return result;
}

-(RssCloud*) processCloud: (xmlNode*)node {
    RssCloud* result = [[RssCloud alloc] init];
    xmlChar* temp;
    
    temp = xmlGetProp(node, domainStr);
    if(temp != NULL) { [result setDomain: [NSString stringWithUTF8String:(const char*)temp]]; }
    
    temp = xmlGetProp(node, pathStr);
    if(temp != NULL) { [result setPath: [NSString stringWithUTF8String:(const char*)temp]]; }
    
    temp = xmlGetProp(node, portStr);
    if(temp != NULL) { [result setPort: [[NSString stringWithUTF8String:(const char*)temp] intValue]]; }
    
    temp = xmlGetProp(node, registerProcedureStr);
    if(temp != NULL) { [result setRegisterProcedure: [NSString stringWithUTF8String:(const char*)temp]]; }
    
    temp = xmlGetProp(node, protoclStr);
    if(temp != NULL) { [result setProtocol:[NSString stringWithUTF8String:(const char*)temp]]; }
    
    return result;
}

-(RssCategory*) processCategory: (xmlNode*)node {
    RssCategory* result = [[RssCategory alloc] init];
    
    xmlChar* temp = xmlGetProp(node, domainStr);
    if(temp != NULL) { [result setDomain: [NSString stringWithUTF8String:(const char*)temp]]; }
    
    if(node->children != NULL) {
        temp = xmlNodeGetContent(node);
        if(temp != NULL) { 
            [result setText: [NSString stringWithUTF8String: (const char*)temp]];
        }
    }
    
    return result;
}

-(RssEnclosure*) processEnclosure: (xmlNode*)node {
    RssEnclosure* result = [[RssEnclosure alloc] init];
    
    xmlChar* tempUrl = xmlGetProp(node, urlStr);
    xmlChar* tempLength = xmlGetProp(node, lengthStr);
    xmlChar* tempType = xmlGetProp(node, typeStr);
    
    if(tempUrl != NULL) { 
        [result setUrl:[NSString stringWithUTF8String: (const char*)tempUrl]];
    } 
    
    if(tempLength != NULL) {
        [result setLength:[[NSString stringWithUTF8String: (const char*)tempLength] intValue]];
    }
    
    if(tempType != NULL) {
        [result setMimeType:[NSString stringWithUTF8String: (const char*)tempType]];
    }
    return result;
}

-(RssSource*) processSource:(xmlNode *)node {
    RssSource* result = [[RssSource alloc] init];
    
    xmlChar* temp = xmlGetProp(node, urlStr);
    if(temp != NULL) { [result setUrl: [NSString stringWithUTF8String:(const char*)temp]]; }
    
    if(node->children != NULL) {
        temp = xmlNodeGetContent(node);
        if(temp != NULL) { 
            [result setText: [NSString stringWithUTF8String: (const char*)temp]];
        }
    }
    
    return result;
}

@end
