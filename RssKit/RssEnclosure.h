//
//  Enclosure.h
//  FeedGetter
//
//  Created by Paul Hoehne on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssEnclosure : NSObject


@property (strong) NSString* url;
@property (assign) int length;
@property (strong) NSString* mimeType;

@end
