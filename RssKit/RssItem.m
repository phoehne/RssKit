//
//  Item.m
//  QuickChart
//
//  Created by Paul Hoehne on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RssItem.h"

@implementation RssItem

@synthesize title, link, description, guid, pubDate, isPermaLink, author, source, category, comments, enclosure;

-(id) init {
    self = [super init];
    
    [self setIsPermaLink:NO];
    
    return self;
}



@end
