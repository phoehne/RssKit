//
//  Item.h
//  QuickChart
//
//  Created by Paul Hoehne on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RssCategory;
@class RssEnclosure;
@class RssSource;

@interface RssItem : NSObject {
    
}

@property (strong) NSString* title;
@property (strong) NSString* link;
@property (strong) NSString* description;
@property (strong) NSString* guid;
@property (strong) NSString* pubDate;
@property (assign) BOOL isPermaLink;
@property (strong) NSString* author;
@property (strong) RssCategory* category;
@property (strong) NSString* comments;
@property (strong) RssEnclosure* enclosure;
@property (strong) RssSource* source;
@end
